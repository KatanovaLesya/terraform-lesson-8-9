##############################################
# Variables for RDS / Aurora Flexible Module
##############################################

variable "use_aurora" {
  description = "If true, deploy Aurora cluster instead of a single RDS instance"
  type        = bool
  default     = false
}

variable "engine" {
  description = "Database engine type (postgres or aurora-postgresql)"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Engine version for PostgreSQL or Aurora PostgreSQL"
  type        = string
  default     = "12.22"
}

variable "instance_class" {
  description = "Instance class for the RDS instance or Aurora cluster instance"
  type        = string
  default     = "db.t3.micro"
}

variable "multi_az" {
  description = "Whether to enable Multi-AZ (for regular RDS only)"
  type        = bool
  default     = false
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "username" {
  description = "Master username"
  type        = string
  default     = "dbadmin"
}

variable "password" {
  description = "Master password"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "VPC ID where the DB will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for DB subnet group"
  type        = list(string)
}

variable "tags" {
  description = "Additional tags for resources"
  type        = map(string)
  default     = {}
}
