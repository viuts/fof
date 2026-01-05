variable "project_id" {
  description = "The Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "The Google Cloud region"
  type        = string
}

variable "repository_id" {
  description = "The name of the repository"
  type        = string
}

variable "description" {
  description = "The description of the repository"
  type        = string
  default     = "Docker repository"
}

variable "format" {
  description = "The format of packages to be stored"
  type        = string
  default     = "DOCKER"
}

variable "writer_service_accounts" {
  description = "List of service account emails to grant write access"
  type        = list(string)
  default     = []
}
