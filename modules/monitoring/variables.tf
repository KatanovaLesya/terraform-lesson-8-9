variable "namespace" {
  description = "Namespace for Prometheus and Grafana"
  type        = string
  default     = "monitoring"
}

variable "grafana_admin" {
  description = "Grafana admin username"
  type        = string
  default     = "admin"
}

variable "grafana_pass" {
  description = "Grafana admin password"
  type        = string
  default     = "Grafana123!"
}

variable "cluster_name" {
  description = "EKS cluster name (for Helm provider)"
  type        = string
}
