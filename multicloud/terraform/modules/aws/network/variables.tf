variable "vpc_cidr" {
  type        = string
  description = "CIDR da VPC"
  default     = "10.20.0.0/16"
}

variable "vpc_name" {
  type        = string
  description = "Nome da VPC"
  default     = "eks-test-vpc"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Lista de CIDRs para subnets públicas"
  default     = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "availability_zones" {
  type        = list(string)
  description = "AZs para subnets"
  default     = ["us-east-1a", "us-east-1b"]
}
