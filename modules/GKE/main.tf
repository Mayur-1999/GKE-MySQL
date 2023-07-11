resource "google_container_cluster" "test_cluster" {
  name     = var.cluster_name
  # node_locations = ["us-central1-a", "us-central1-b", "us-central1-c"]
  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count
  location = var.location
  
  ip_allocation_policy { 
  }
  networking_mode = "VPC_NATIVE"

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS", "APISERVER"]
    managed_prometheus {
         enabled = false
      }
    } 

  node_config {
    disk_size_gb = 50
    disk_type = "pd-ssd"
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/devstorage.read_write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    #tags = var.tags
    #service_account = var.service_account
    labels = {
      env = var.project_id
    }

    preemptible  = true
    machine_type = "e2-small"
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  network    = var.network
  subnetwork = var.subnetwork

   addons_config {
     gke_backup_agent_config {
      enabled = false
    }
 }

  #vertical autoscale enabling
  vertical_pod_autoscaling {
    enabled = false #changed
  }
  #workload identity enabling
  workload_identity_config {
    workload_pool = "${data.google_project.project.project_id}.svc.id.goog"    
  }
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.test_cluster.name
  location   = var.location
  cluster    = google_container_cluster.test_cluster.name
  node_count = var.node_count
 # depends_on = [google_container_cluster.test_cluster] #added newly

  node_config {
    disk_size_gb = 50
    disk_type = "pd-ssd"
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}

#data block for workload identity 
data "google_project" "project" {
  project_id = var.project_id
}

/*
 ##enable GKEbackup API
resource "google_project_service" "backup_api" {
  project = var.project_id
  service = "gkebackup.googleapis.com"
  disable_on_destroy = false
}

# Backup plan for GKE , needs to be configured according to our use 
resource "google_gke_backup_backup_plan" "backup_plan" {
  name = "full-backup-plan"
  cluster = google_container_cluster.sre_cluster.id
  depends_on = [google_container_node_pool.primary_nodes]
  location = var.location
  retention_policy {
     backup_delete_lock_days = 30
     backup_retain_days = 180
  }
  backup_schedule {
     cron_schedule = "5 4 30 2 3"
  }
  backup_config {
    include_volume_data = true
    include_secrets = true
    all_namespaces = true
  }
  
}
*/