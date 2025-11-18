variable "bucket_name" {
  description = "Им'я існуючого S3 бакета з бекендом Terraform"
  type        = string
}

variable "table_name" {
  description = "Им'я існуючої таблиці DynamoDB для Terraform locking"
  type        = string
}
