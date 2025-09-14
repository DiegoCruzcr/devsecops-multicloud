variable "region" {
  type    = string
  default = "us-east-1"
}

variable "cluster_name" {
  type    = string
  default = "meu-cluster-eks"
}

variable "node_desired_size" {
  type    = number
  default = 2
}

variable "node_max_size" {
  type    = number
  default = 2
}

variable "node_min_size" {
  type    = number
  default = 1
}

variable "project_id" {
  type    = string
  default = "devsecops-multicloud"
}

variable "google_region" {
  type    = string
  default = "us-central1"
}
