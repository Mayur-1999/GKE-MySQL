variable "project_id" {
  description = "Project ID."
  type        = string
  default     = ""
}

variable "region" {
  description = "Region to deploy the resource."
  type        = string
  default     = "us-east1"
}

variable "service_account_email" {
  description = "Email ID of service account."
  type        = string
  default     = ""
}

variable "user" {
  description = "sample app DB user username."
  type        = string
  default     = "wpuser"
}
/*
variable "password" {
  description = "sample app DB user password."
  sensitive   = true
  type        = string
}
*/
variable "dbname" {
  description = "The name for sample app database."
  type        = string
  default     = "sample-app-db"
}
