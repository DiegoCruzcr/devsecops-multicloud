provider "aws" {
  region = var.region
}

# provider "google" {
#   project = var.project_id
#   region  = var.google_region
# }

# data "google_client_config" "provider" {}

module "network" {
  source             = "./modules/aws/network"
  vpc_cidr           = "10.20.0.0/16"
  vpc_name           = "eks-test-vpc"
  public_subnet_cidrs = ["10.20.1.0/24", "10.20.2.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
}

module "iam" {
  source            = "./modules/aws/iam"
  cluster_role_name = "eks-cluster-role"
  node_role_name    = "eks-node-role"
}

module "eks" {
  source           = "./modules/aws/eks"
  region           = var.region
  cluster_name     = var.cluster_name
  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn
  subnet_ids       = module.network.public_subnet_ids
  node_desired_size = var.node_desired_size
  node_max_size     = var.node_max_size
  node_min_size     = var.node_min_size
  depends_on        = [module.network]
}

module "containers_repository" {
  source          = "./modules/aws/containers_repository"
  repository_name = "minha-app-repo"
  tags = {
    Environment = "dev"
    Project     = "minha-app"
  }
}

# Google Cloud modules
# module "google_network" {
#   source                        = "./modules/google/network"
#   region                        = var.google_region
# }

# module "google_containers_repository" {
#   source          = "./modules/google/containers_repository"
#   repository_name = "minha-app-repo"
#   location        = var.google_region
#   labels = {
#     environment = "dev"
#     project     = "minha-app"
#   }
# }

# module "google_gke" {
#   source                        = "./modules/google/gke"
#   region                        = var.google_region
#   network                       = module.google_network.network_name
#   subnetwork                    = module.google_network.subnetwork_name
#   services_secondary_range_name = "services-range"
#   cluster_secondary_range_name  = "pod-ranges"
#   depends_on                    = [module.google_network]
# }

