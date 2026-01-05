terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
  backend "gcs" {
    bucket = "fof-terraform-state-dev"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

// For cost saving we are using Aiven DB until we hit the limit
# module "database" {
#   source = "../../modules/google_sql"

#   project_id          = var.project_id
#   region              = var.region
#   environment         = "dev"
#   tier                = "db-f1-micro"
#   deletion_protection = false
# }

module "secrets" {
  source = "../../modules/secrets"

  project_id  = var.project_id
  environment = "dev"
  # database_url = module.database.database_url
  database_url = var.database_url
}

module "backend_service" {
  source = "../../modules/cloud_run"

  project_id   = var.project_id
  region       = var.region
  service_name = "fof-backend"
  # Initial placeholder image until CI/CD pushes the real one
  image_url             = "us-docker.pkg.dev/cloudrun/container/hello"
  allow_unauthenticated = true
}

module "artifact_registry" {
  source = "../../modules/artifact_registry"

  project_id    = var.project_id
  region        = var.region
  repository_id = "fof-backend"

  writer_service_accounts = [
    # The account used by GitHub Actions (via Workload Identity or key)
    # The user identified this as the one needing access
    "firebase-adminsdk-fbsvc@${var.project_id}.iam.gserviceaccount.com"
  ]
}

output "service_url" {
  value = module.backend_service.service_url
}
