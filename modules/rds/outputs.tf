output "db_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.this.endpoint
}

output "db_name" {
  description = "The name of the database"
  value       = var.db_name
}

output "security_group_id" {
  description = "Security group ID used by the DB"
  value       = aws_security_group.this.id
}
