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

variable "function_sa" {
  type    = string
  description = "ID of Google Service Account to be used by Cloud Function"
  default = ""
}

