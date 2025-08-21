variable "region" {
  type        = string
  description = "AWS region"
}

variable "cluster_name" {
  type        = string
  description = "Nome do cluster EKS"
}

variable "cluster_role_arn" {
  type        = string
  description = "ARN da IAM Role do cluster EKS"
}

variable "node_role_arn" {
  type        = string
  description = "ARN da IAM Role dos nodes EKS"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Lista de subnets para o cluster"
}

variable "node_desired_size" {
  type        = number
  default     = 2
  description = "Quantidade desejada de nodes"
}

variable "node_max_size" {
  type        = number
  default     = 3
  description = "Máximo de nodes"
}

variable "node_min_size" {
  type        = number
  default     = 1
  description = "Mínimo de nodes"
}
