variable "namespace" {
  description = "Namespace for Jenkins"
  type        = string
  default     = "jenkins"
}

variable "chart_version" {
  description = "Jenkins Helm chart version"
  type        = string
  default     = "5.3.2"
}

variable "admin_user" {
  description = "Jenkins admin username"
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Jenkins admin password"
  type        = string
  default     = "Admin123!"
}

variable "cluster_name" {
  description = "Назва EKS кластера"
  type        = string
}