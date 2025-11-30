############################################
# Namespace для Argo CD
############################################
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.namespace
  }
}

############################################
# Встановлення Argo CD через Helm
############################################
resource "helm_release" "argocd" {
  name       = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = var.namespace
  version    = var.chart_version

  # чекаємо до 10 хвилин на успішне встановлення
  timeout = 600
  wait    = true

  values = [
    file("${path.module}/values.yaml")
  ]

  depends_on = [kubernetes_namespace.argocd]
}
