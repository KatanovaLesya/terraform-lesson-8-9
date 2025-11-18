variable "cluster_name" {
  description = "Назва EKS кластера"
  type        = string
}

variable "vpc_id" {
  description = "ID існуючої VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "Список приватних сабнетів для воркерів EKS"
  type        = list(string)
}
