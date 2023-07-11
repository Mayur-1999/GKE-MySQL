variable "cluster_name" {
  type    = string
  default = "wp-cluster"
}

variable "project_id" {
  type = string
}

variable "location" {
  type    = string
  default = "us-central1"
}

variable "machine_type" {
  type    = string
  default = "e2-medium"
}

variable "disk_type" {
  type    = string
  default = 50
}

variable "node_pool_name" {
  type    = string
  default = "default-pool"
}

variable "node_pool_location" {
  type    = string
  default = "us-central1"
}

variable "node_count" {
  type    = string
  default = "2"
}

variable "initial_node_count" {
  default = 1
}

variable "tags" {
  type    = list(string)
  default = ["prometheus"]
}

#variable "service_account" {
#}

variable "network" {

}
variable "subnetwork" {
}