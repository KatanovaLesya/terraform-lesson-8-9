variable "namespace" {
  description = "Namespace for Argo CD"
  type        = string
  default     = "argocd"
}

variable "chart_version" {
  description = "Argo CD Helm chart version"
  type        = string
  default     = "7.6.11"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}
