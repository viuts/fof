variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "asia-northeast1"
}

variable "environment" {
  type = string
}

variable "tier" {
  type    = string
  default = "db-f1-micro"
}

variable "deletion_protection" {
  type    = bool
  default = true
}
