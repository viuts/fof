variable "project_id" {
  description = "The Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "The Google Cloud region"
  type        = string
  default     = "us-central1"
}

variable "service_name" {
  description = "The name of the Cloud Run service"
  type        = string
}

variable "image_url" {
  description = "The container image URL"
  type        = string
  # Default placeholder if not ready yet
  default = "us-docker.pkg.dev/cloudrun/container/hello"
}

variable "allow_unauthenticated" {
  description = "Whether to allow unauthenticated invocations"
  type        = bool
  default     = true
}

variable "deployer_service_accounts" {
  description = "List of service account emails to grant deploy access"
  type        = list(string)
  default     = []
}
