variable "project_id" {
  type    = string
  description = "The ID of the project where the resources will be created"
  default = "<YOUR-PROJECT-ID>"
}

variable "region" {
  type    = string
  description = "The region in which resources will be applied"
  default = "us-east1"
}

variable "dcc_bucket" {
  type    = string
  description = "Name of existing DCC bucket to store function source code"
  default = "gcptosynapse"
}

variable "google_service_account" {
  description = "Service account information"
  type = object({
    sa = object({
      email = string
    })
  })
}

variable "account_id" {
  type        = string
  description = "account_id of service account"
  default     = null
}

variable "display_name" {
  type        = string
  description = "display name of service account"
  default     = null
}

variable "job_name" {
  type        = string
  description = "The name of the scheduled job to run"
  default     = null
}

variable "job_description" {
  type        = string
  description = "Additional text to describe the job"
  default     = null
}

variable "job_schedule" {
  type        = string
  description = "The job frequency, in cron syntax"
  default     = "0 3 * * *"
}

variable "time_zone" {
  type        = string
  description = "Time zone to specify for job scheduler"
  default     = "America/New_York"
}