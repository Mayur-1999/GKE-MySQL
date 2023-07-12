/*****************************************
 MySQL
*****************************************/

module "MySql" {
  source                       = "./modules/MySQL"
  project_id                   = var.project_id
  instance_name                = "test-instance"
  region                       = var.region
  tier                         = "db-f1-micro"
  network                      = module.vpc.vpc.self_link
  private_ip_address_name      = "private-ip"
  database_name                = "test-database"
  dbuser_name                  = "db-user"
  dbuser_password              = "db-password"
  depends_on = [ 
     module.vpc
  ] 
}

/*****************************************
 GKE
*****************************************/

module "test-cluster" {
  source             = "./modules/GKE"
  cluster_name       = "test-cluster"
  project_id         = var.project_id
  location           = var.region
  node_count         = 3
  initial_node_count = 1
  #service_account    = var.service_account
  network            =  module.vpc.vpc.self_link
  subnetwork         = "projects/${var.project_id}/regions/${var.region}/subnetworks/subnet"

  depends_on = [ 
     module.vpc
  ] 
}

/*****************************************
VPC Subnets
*****************************************/

module "vpc" {
  source                  = "./modules/vpc"
  project_id              = var.project_id
  network_name            = "vpc"
  auto_create_subnetworks = false
}

module "subnet" {
  source       = "./modules/subnet"
  project_id   = var.project_id
  network_name = module.vpc.vpc.self_link
  role         = "ACTIVE"
  subnets = [{
    subnet_name           = "subnet"
    subnet_region         = "us-central1"
    subnet_ip             = "10.10.0.0/24"
    subnet_flow_logs      = "false"
    subnet_private_access = "false"
    }]

  depends_on = [
    module.vpc
  ]
}

module "proxy-subnet" {
  source       = "./modules/subnet"
  project_id   = var.project_id
  network_name = module.vpc.vpc.self_link
  purpose      = "REGIONAL_MANAGED_PROXY"
  role         = "ACTIVE"
  subnets = [{
    subnet_name           = "proxy-only-subnet"
    subnet_region         = "us-central1"
    subnet_ip             = "10.9.0.0/23" #"10.129.0.0/23"
    subnet_flow_logs      = "false"
    subnet_private_access = "false"
    }
  ]
  depends_on = [
    module.vpc
  ]
}

/*****************************************
service account
*****************************************/

resource "google_service_account" "service_acc" {
  project      = var.project_id
  account_id   = "gke-service-account"
  display_name = "GKE Service Account"
}

resource "google_project_iam_binding" "cloudsql_client" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  members = [
  "serviceAccount:gke-service-account@${var.project_id}.iam.gserviceaccount.com",
  ]
  depends_on= [
   google_service_account.service_acc
  ]
}

resource "google_project_iam_binding" "logging_logWriter" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  members = [
  "serviceAccount:gke-service-account@${var.project_id}.iam.gserviceaccount.com",
  ]
  depends_on= [
   google_service_account.service_acc
  ]
}
