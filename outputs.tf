output "ecr_info" {
  description = "Інформація про ECR репозиторій"
  value = {
    repository_url = module.ecr.repository_url
  }
}
