output "cluster_name" {
  description = "Назва EKS кластера"
  value       = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  description = "Ендпоінт API сервера Kubernetes"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_ca" {
  description = "CA сертифікат кластера"
  value       = aws_eks_cluster.this.certificate_authority[0].data
}
