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

  # важливо: не чекаємо, поки pod стане Ready
  timeout = 600
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
      # вимикаємо PVC, щоб Jenkins не створював PersistentVolumeClaim
      name  = "controller.persistence.enabled"
      value = "false"
    },
  ]
}