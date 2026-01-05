# Generate a key for the existing Firebase Admin SDK service account
# The account ID is typically firebase-adminsdk-fbsvc@PROJECT_ID.iam.gserviceaccount.com
resource "google_service_account_key" "backend_key" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/firebase-adminsdk-fbsvc@${var.project_id}.iam.gserviceaccount.com"
}

resource "google_secret_manager_secret" "secrets" {
  for_each = toset(var.secret_names)

  secret_id = "${each.key}-${var.environment}"

  replication {
    auto {}
  }
}

# Grant access to the Default Compute Service Account (Cloud Run runtime)
resource "google_secret_manager_secret_iam_member" "accessor" {
  for_each = google_secret_manager_secret.secrets

  project   = var.project_id
  secret_id = each.value.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${var.project_number}-compute@developer.gserviceaccount.com"
}

resource "google_secret_manager_secret_version" "database_url" {
  secret      = google_secret_manager_secret.secrets["postgresql-connection-string"].id
  secret_data = var.database_url
}

resource "google_secret_manager_secret_version" "firebase_private_key" {
  secret = google_secret_manager_secret.secrets["auth-firebase-private-key"].id
  # The output is base64 encoded, but App Hosting might need the raw JSON.
  # google_service_account_key.backend_key.private_key is base64 encoded JSON.
  secret_data = base64decode(google_service_account_key.backend_key.private_key)
}
