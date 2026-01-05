resource "random_password" "db_password" {
  length  = 16
  special = false
}

resource "google_sql_database_instance" "postgres" {
  name             = "fof-db-${var.environment}"
  database_version = "POSTGRES_18"
  region           = var.region

  settings {
    tier = var.tier
  }

  deletion_protection = var.deletion_protection
}

resource "google_sql_database" "database" {
  name     = "fof"
  instance = google_sql_database_instance.postgres.name
}

resource "google_sql_user" "users" {
  name     = "fof-user"
  instance = google_sql_database_instance.postgres.name
  password = random_password.db_password.result
}
