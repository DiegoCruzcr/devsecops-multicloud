output "cluster_role_arn" {
  description = "ARN da IAM Role do cluster EKS"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "node_role_arn" {
  description = "ARN da IAM Role dos nodes EKS"
  value       = aws_iam_role.eks_node_role.arn
}
