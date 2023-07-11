resource "google_project_service" "service_networking" {
  project            = var.project_id
  service            = "servicenetworking.googleapis.com"
  disable_on_destroy = true
}

resource "google_compute_global_address" "private_ip_address" {
  provider      = google-beta
  name          = "private-ip-address"
  project       = var.project_id
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.network
  depends_on = [
    google_project_service.service_networking
  ]

}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider                = google-beta
  #project                 = var.project_id
  network                 = var.network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
  depends_on = [
    google_project_service.service_networking
  ]
}

resource "google_sql_database_instance" "sql_instance" {
  name                = var.instance_name
  project             = var.project_id
  region              = var.region
  database_version    = var.database_version
  deletion_protection = var.deletion_protection
  settings {
    tier              = var.tier
    ip_configuration {
      ipv4_enabled    = false   #var.ipv4_enabled
      private_network = var.network
    }
    backup_configuration {
      binary_log_enabled = true
      enabled            = true
    }
  }
  depends_on = [
    google_service_networking_connection.private_vpc_connection
  ]
}

resource "google_sql_database" "sql_database" {
  name       = var.database_name
  instance   = google_sql_database_instance.sql_instance.name
  depends_on = [google_sql_database_instance.sql_instance]
}

resource "google_sql_user" "sql_user" {
  name       = var.dbuser_name
  instance   = google_sql_database_instance.sql_instance.name
  password   = var.dbuser_password
  host       = "%"
  depends_on = [google_sql_database_instance.sql_instance]
}
