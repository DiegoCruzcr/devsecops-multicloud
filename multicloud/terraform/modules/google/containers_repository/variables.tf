variable "location" {
  description = "The location where the repository will be created"
  type        = string
  default     = "us-central1"
}

variable "repository_name" {
  description = "The name of the container repository"
  type        = string
}

variable "description" {
  description = "Description for the repository"
  type        = string
  default     = "Container repository for multicloud application"
}

variable "labels" {
  description = "Labels to apply to the repository"
  type        = map(string)
  default     = {}
}
