output "grafana_credentials" {
  description = "Grafana admin credentials"
  value = {
    username = var.grafana_admin
    password = var.grafana_pass
  }
}

output "monitoring_namespace" {
  description = "Namespace for monitoring stack"
  value       = var.namespace
}
