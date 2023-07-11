/*
output "instance_name" {
  value       = google_sql_database_instance.instance.name
  description = "The instance name for the master instance"
}

output "instance_ip_address" {
  value       = google_sql_database_instance.instance.ip_address
  description = "The IPv4 address assigned for the master instance"
}

output "cloud_sql_instance" {
  value       = google_sql_database_instance.instance
  description = "The cloud sql instance created."
}
/*
output "sql_database" {
  value       = google_sql_database.sql_database
  description = "The db created."
}

output "sql_user" {
  value       = google_sql_user.sql_user
  description = "The user created."
}

output "sql_user_password" {
  value       = google_sql_user.sql_user.password
  description = "The password of user created."
  sensitive   = true
}

output "sql_user_host" {
  value       = google_sql_user.sql_user.host
  description = "The host the user can connect from."
}
*/