output "connection_name" {
  value = google_sql_database_instance.postgres.connection_name
}

output "public_ip_address" {
  value = google_sql_database_instance.postgres.public_ip_address
}

output "db_password" {
  value     = random_password.db_password.result
  sensitive = true
}

output "database_url" {
  # Constructing the DSN: postgres://user:password@host/dbname
  value     = "postgres://${google_sql_user.users.name}:${random_password.db_password.result}@${google_sql_database_instance.postgres.public_ip_address}/${google_sql_database.database.name}"
  sensitive = true
}
