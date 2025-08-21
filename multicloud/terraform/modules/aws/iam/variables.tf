variable "cluster_role_name" {
  type        = string
  description = "Nome da IAM Role para o cluster EKS"
  default     = "eks-cluster-role"
}

variable "node_role_name" {
  type        = string
  description = "Nome da IAM Role para os nodes EKS"
  default     = "eks-node-role"
}
