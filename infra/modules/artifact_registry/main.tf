resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = var.repository_id
  description   = var.description
  format        = var.format
  project       = var.project_id
}

resource "google_artifact_registry_repository_iam_member" "writers" {
  for_each = toset(var.writer_service_accounts)

  project    = google_artifact_registry_repository.repo.project
  location   = google_artifact_registry_repository.repo.location
  repository = google_artifact_registry_repository.repo.name
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${each.value}"
}
