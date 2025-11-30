########################################
# 1️⃣ Backend для Terraform state
########################################
module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "lesya-terraform-backend-2025"
  table_name  = "terraform-locks"
}

########################################
# 2️⃣ VPC — базова мережа
########################################
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  vpc_name           = "lesson-10-vpc"
}

########################################
# 3️⃣ ECR — контейнерний реєстр
########################################
module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = "lesson-10-django-ecr"
  scan_on_push = true
}

########################################
# 4️⃣ EKS — Kubernetes кластер
########################################
module "eks" {
  source             = "./modules/eks"
  cluster_name       = "lesson-10-eks"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.public_subnet_ids
}

########################################
# 5️⃣ RDS — база даних PostgreSQL
########################################
module "rds" {
  source         = "./modules/rds"
  use_aurora     = false
  engine         = "postgres"
  engine_version = "12.22"
  instance_class = "db.t3.micro"
  db_name        = "mydb"
  username       = "lesya_db"
  password       = "StrongPass123!"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids
}

########################################
# 6️⃣ Jenkins — CI/CD сервер
########################################
module "jenkins" {
  source = "./modules/jenkins"

  namespace      = "jenkins"
  admin_user     = "admin"
  admin_password = "Admin123!"
}



########################################
# 7️⃣ Argo CD — CD для Kubernetes
########################################
module "argo_cd" {
  source                        = "./modules/argo_cd"
  cluster_name                  = module.eks.cluster_name
  cluster_endpoint              = module.eks.cluster_endpoint
  cluster_certificate_authority = module.eks.cluster_ca_data
}

########################################
# 8️⃣ Monitoring — Prometheus + Grafana
########################################
module "monitoring" {
  source = "./modules/monitoring"

  namespace     = "monitoring"
  grafana_admin = "admin"
  grafana_pass  = "Grafana123!"
  cluster_name  = module.eks.cluster_name
}

