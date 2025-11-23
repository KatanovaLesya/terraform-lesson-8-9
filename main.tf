module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "lesya-terraform-backend-2025"
  table_name  = "terraform-locks"
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  vpc_name           = "lesson-7-vpc"
}

module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = var.ecr_name
  scan_on_push = true
}

module "eks" {
  source             = "./modules/eks"
  cluster_name       = "lesson-7-eks"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.public_subnet_ids
}

module "jenkins" {
  source = "./modules/jenkins"

  namespace      = "jenkins"
  chart_version  = "5.3.2"
  admin_user     = "admin"
  admin_password = "Admin123!"

  cluster_name = module.eks.cluster_name
}

module "argo_cd" {
  source       = "./modules/argo_cd"
  namespace    = "argocd"
  chart_version = "7.6.11"

  cluster_name = module.eks.cluster_name
}

