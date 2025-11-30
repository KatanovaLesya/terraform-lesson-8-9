##############################################
# Outputs for Flexible RDS / Aurora Module
##############################################

output "db_endpoint" {
  description = "Database endpoint (RDS or Aurora)"
  value       = var.use_aurora ? aws_rds_cluster.this[0].endpoint : aws_db_instance.this[0].endpoint
}

output "db_name" {
  description = "The name of the database"
  value       = var.db_name
}

output "security_group_id" {
  description = "Security group ID used by the DB"
  value       = aws_security_group.this.id
}

output "db_type" {
  description = "Type of database created (RDS or Aurora)"
  value       = var.use_aurora ? "Aurora Cluster" : "RDS Instance"
}
