project_id = "htan-dcc"
region = "us-east1"
dcc_bucket = "dcc-cloud-functions"

# service account variables
google_service_account = {
  sa = {
    email = "id-provenance@htan-dcc.iam.gserviceaccount.com"
  }
}
account_id = "id-provenance"
display_name = "Service Account used by Cloud Function to update ID provenance BQ table"

# job variables
job_name =  "id-prov-bq-trigger"
job_description = "Updates ID Provenance BigQuery table `htan-dcc.id_provenance.upstream_ids`. Run 'update-bq-metadata-tables-scheduler-trigger' first to use up-to-date tables"
job_schedule = "0 3 * * *"
time_zone = "America/New_York"