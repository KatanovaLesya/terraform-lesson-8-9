variable "namespace" {
  description = "Namespace for monitoring tools"
  type        = string
  default     = "monitoring"
}

variable "grafana_admin" {
  description = "Grafana admin username"
  type        = string
}

variable "grafana_pass" {
  description = "Grafana admin password"
  type        = string
  sensitive   = true
}

variable "cluster_name" {
  description = "EKS cluster name for monitoring connection"
  type        = string
}
