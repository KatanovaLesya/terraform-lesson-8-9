resource "kubernetes_namespace" "jenkins" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  namespace  = var.namespace
  version    = var.chart_version

  values = [
    file("${path.module}/values.yaml")
  ]

  timeout = 1200
  wait    = false

  set = [
    {
      name  = "controller.admin.username"
      value = var.admin_user
    },
    {
      name  = "controller.admin.password"
      value = var.admin_password
    },
    {
      name  = "controller.persistence.enabled"
      value = "false"
    },
    {
      name  = "controller.serviceType"
      value = "ClusterIP"
    }
  ]

  depends_on = [kubernetes_namespace.jenkins]
}
