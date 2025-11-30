resource "helm_release" "prometheus" {
  name             = "prometheus"
  namespace        = var.namespace
  create_namespace = true

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  values = [
    <<EOF
grafana:
  adminUser: ${var.grafana_admin}
  adminPassword: ${var.grafana_pass}
  service:
    type: ClusterIP
prometheus:
  service:
    type: ClusterIP
EOF
  ]
}
