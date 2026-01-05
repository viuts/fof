variable "project_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "secret_names" {
  type    = list(string)
  default = ["postgresql-connection-string", "auth-firebase-private-key"]
}

variable "database_url" {
  type      = string
  sensitive = true
}
