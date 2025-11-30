output "grafana_info" {
  value = {
    namespace = var.namespace
    username  = var.grafana_admin
    password  = var.grafana_pass
  }
  sensitive = true
}
