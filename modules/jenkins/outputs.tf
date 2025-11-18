output "namespace" {
  description = "Namespace where Jenkins is installed"
  value       = kubernetes_namespace.jenkins.metadata[0].name
}

output "admin_user" {
  value       = var.admin_user
  description = "Jenkins admin username"
}

output "admin_password" {
  value       = var.admin_password
  description = "Jenkins admin password"
  sensitive   = true
}