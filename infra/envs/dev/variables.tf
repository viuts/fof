variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "asia-northeast1"
}

variable "database_url" {
  type      = string
  sensitive = true
}
