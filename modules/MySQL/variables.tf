variable "private_ip_address_name" {
  description = "Name of private ip address to be reserved."
  type        = string
}

variable "address" {
  description = "The IP address or beginning of the address range represented by this resource. This can be supplied as an input to reserve a specific address or omitted to allow GCP to choose a valid one for you."
  type        = string
  default     = ""
}

variable "address_type" {
  description = "The type of the address to reserve. EXTERNAL indicates public/external single IP address. INTERNAL indicates internal IP ranges belonging to some network. Default value is EXTERNAL. Possible values are: EXTERNAL, INTERNAL."
  type        = string
  default     = "EXTERNAL"
}

variable "purpose" {
  description = "The purpose of the resource. Possible values include: VPC_PEERING - for peer networks, PRIVATE_SERVICE_CONNECT - for (Beta only) Private Service Connect networks"
  type        = string
  default     = "VPC_PEERING"
}

variable "prefix_length" {
  description = "The prefix length of the IP range. If not present, it means the address field is a single IP address. This field is not applicable to addresses with addressType=EXTERNAL, or addressType=INTERNAL when purpose=PRIVATE_SERVICE_CONNECT"
  type        = number
  default     = null
}

variable "network" {
  description = "The URL of the network in which to reserve the IP range. The IP range must be in RFC1918 space. The network cannot be deleted if there are any reserved IP ranges referring to it. This should only be set when using an Internal address."
  type        = string
  default     = null
}

variable "instance_name" {
  description = "The name of the instance. If the name is left blank, Terraform will randomly generate one when the instance is first created. This is done because after a name is used, it cannot be reused for up to one week."
  type        = string
  default     = null
}

variable "region" {
  description = "The region the instance will sit in. If a region is not provided in the resource definition, the provider region will be used instead."
  type        = string
  default     = null
}

variable "database_version" {
  description = "The MySQL, PostgreSQL or SQL Server version to use. Supported values include MYSQL_5_6, MYSQL_5_7, MYSQL_8_0, POSTGRES_9_6,POSTGRES_10, POSTGRES_11, POSTGRES_12, POSTGRES_13, POSTGRES_14, SQLSERVER_2017_STANDARD, SQLSERVER_2017_ENTERPRISE, SQLSERVER_2017_EXPRESS, SQLSERVER_2017_WEB. SQLSERVER_2019_STANDARD, SQLSERVER_2019_ENTERPRISE, SQLSERVER_2019_EXPRESS, SQLSERVER_2019_WEB"
  type        = string
  default     = "MYSQL_5_7"
}

variable "availability_type" {
  description = "The availability type of the Cloud SQL instance, high availability (REGIONAL) or single zone (ZONAL).' For all instances, ensure that settings.backup_configuration.enabled is set to true. For MySQL instances, ensure that settings.backup_configuration.binary_log_enabled is set to true. For Postgres and SQL Server instances, ensure that settings.backup_configuration.point_in_time_recovery_enabled is set to true. Defaults to ZONAL."
  type        = string
  default     = "ZONAL"
}

variable "deletion_protection" {
  description = "Whether or not to allow Terraform to destroy the instance. Unless this field is set to false in Terraform state, a terraform destroy or terraform apply command that deletes the instance will fail. Defaults to true."
  type        = bool
  default     = false
}

variable "ipv4_enabled" {
  description = "Whether this Cloud SQL instance should be assigned a public IPV4 address. At least ipv4_enabled must be enabled or a private_network must be configured."
  type        = bool
  default     = false
}

variable "database_name" {
  description = "The name of the database in the Cloud SQL instance. This does not include the project ID or instance name."
  type        = string
}

variable "dbuser_name" {
  description = "The name of the user. Changing this forces a new resource to be created."
  type        = string
}

variable "dbuser_password" {
  description = "The password for the user. Can be updated. For Postgres instances this is a Required field, unless type is set to either CLOUD_IAM_USER or CLOUD_IAM_SERVICE_ACCOUNT. Don't set this field for CLOUD_IAM_USER and CLOUD_IAM_SERVICE_ACCOUNT user types for any Cloud SQL instance."
  type        = string
  default     = ""
}

variable "tier" {
  description = "The machine type to use."
  type        = string
  default     = "db-f1-micro"
}

variable "project_id" {
  type = string
}

