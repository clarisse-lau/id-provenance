# Generates an archive of the source code compressed as a .zip file.
data "archive_file" "source" {
  type        = "zip"
  source_dir  = "./src"
  output_path = "${path.module}/function.zip"
}

# Add source code zip to the Cloud Function's bucket (Cloud_function_bucket) 
resource "google_storage_bucket_object" "zip" {
  source       = data.archive_file.source.output_path
  content_type = "application/zip"
  name         = "src-id-prov-${data.archive_file.source.output_md5}.zip"
  bucket       = var.dcc_bucket
  depends_on = [
    data.archive_file.source
  ]
}

resource "google_pubsub_topic" "default" {
  project = var.project_id
  name = "id-prov-topic"
}

resource "google_cloud_scheduler_job" "job" {
  project = var.project_id
  region = var.region
  name        = "id-prov-bq-trigger"
  description = "Updates ID Provenance BigQuery table `htan-dcc.id_provenance.upstream_ids`. Run 'update-bq-metadata-tables-scheduler-trigger' first to use up-to-date tables"
  schedule    = "0 3 * * 1-5"
  time_zone   = "America/New_York"

  retry_config {
    retry_count = 3
  }

  pubsub_target {
    # topic.id is the topic's full resource name.
    topic_name = "${google_pubsub_topic.default.id}"
    data       = base64encode("test")
  }
}

resource "google_cloudfunctions2_function" "default" {
  project     = var.project_id
  name        = "id-prov-function"
  location    = var.region
  description = "Google Cloud Function to Update ID Provenance BigQuery table"

  build_config {
    runtime     = "python311"
    entry_point = "func" 
    environment_variables = {
      BUILD_CONFIG_TEST = "build_test"
    }
    source {
      storage_source {
        bucket = var.dcc_bucket
        object = google_storage_bucket_object.zip.name
      }
    }
  }

  service_config {
    max_instance_count = 3
    min_instance_count = 1
    available_memory   = "8G"
    timeout_seconds    = 540
    environment_variables = {
      SERVICE_CONFIG_TEST = "config_test"
    }
    ingress_settings               = "ALLOW_INTERNAL_ONLY"
    all_traffic_on_latest_revision = true
    service_account_email          = var.function_sa
  }

  event_trigger {
    trigger_region = var.region
    event_type     = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic   = google_pubsub_topic.default.id
    retry_policy   = "RETRY_POLICY_RETRY"
  }
}

