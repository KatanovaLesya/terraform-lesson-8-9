output "s3_backend_info" {
  value = {
    bucket_name = var.bucket_name
    table_name  = var.table_name
  }
}
