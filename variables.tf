variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "VPC ID для EKS"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

# EKS
variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "node_instance_types" {
  description = "Instance types for worker nodes"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "desired_size" {
  description = "Desired node count"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Min node count"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Max node count"
  type        = number
  default     = 6
}

# ECR / образ
variable "ecr_repo_name" {
  description = "ECR repository name"
  type        = string
}

variable "app_image_tag" {
  description = "Docker image tag"
  type        = string
}

variable "app_port" {
  description = "Port, на якому слухає Django"
  type        = number
  default     = 8000
}

variable "ecr_name" {
  description = "Назва ECR репозиторію для Django"
  type        = string
  default     = "lesson-7-django-ecr"
}
