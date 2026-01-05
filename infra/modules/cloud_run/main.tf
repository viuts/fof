resource "google_cloud_run_v2_service" "default" {
  name     = var.service_name
  location = var.region
  project  = var.project_id
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = var.image_url
      resources {
        limits = {
          cpu    = "1000m"
          memory = "512Mi"
        }
      }
    }

    scaling {
      min_instance_count = 0
      max_instance_count = 2
    }
  }
}

resource "google_cloud_run_service_iam_binding" "default" {
  count    = var.allow_unauthenticated ? 1 : 0
  location = google_cloud_run_v2_service.default.location
  service  = google_cloud_run_v2_service.default.name
  project  = google_cloud_run_v2_service.default.project
  role     = "roles/run.invoker"

  members = [
    "allUsers"
  ]
}

resource "google_cloud_run_service_iam_member" "deployers" {
  for_each = toset(var.deployer_service_accounts)

  location = google_cloud_run_v2_service.default.location
  service  = google_cloud_run_v2_service.default.name
  project  = google_cloud_run_v2_service.default.project
  role     = "roles/run.admin"
  member   = "serviceAccount:${each.value}"
}

# Grant Service Account User role to deployers on the service identity
# This is tricky because usually this is granted on the deployer on the project level
# or on the service account that the Cloud Run service runs AS.
# Here we assume the Cloud Run service runs as the default compute service account
# and the deployer needs "iam.serviceAccounts.actAs" on IT.

output "service_url" {
  value = google_cloud_run_v2_service.default.uri
}
