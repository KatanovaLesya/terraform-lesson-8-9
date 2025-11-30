resource "helm_release" "prometheus" {
  name             = "prometheus"
  namespace        = var.namespace
  create_namespace = true

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "65.3.0"

  values = [
    <<EOF
grafana:
  adminUser: ${var.grafana_admin}
  adminPassword: ${var.grafana_pass}
EOF
  ]
}
