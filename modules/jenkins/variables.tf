variable "namespace" {
  description = "Namespace for Jenkins"
  type        = string
  default     = "jenkins"
}

variable "chart_version" {
  description = "Version of the Jenkins Helm chart"
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
