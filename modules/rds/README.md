# Terraform RDS Module (PostgreSQL)

## Description

This module creates a standard AWS RDS PostgreSQL database instance. It includes:

- RDS instance
- DB subnet group
- Security group
- Parameter group

## Example usage

module "rds" {
  source         = "./modules/rds"
  engine_version = "15.3"
  instance_class = "db.t3.micro"
  db_name        = "mydb"
  username       = "admin"
  password       = "StrongPass123!"
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnets
}

## Variables

| Name           | Type             | Default     | Description        |
| -------------- | ---------------- | ----------- | ------------------ |
| engine_version | string           | 15.3        | PostgreSQL version |
| instance_class | string           | db.t3.micro | RDS instance class |
| multi_az       | bool             | false       | Enable Multi-AZ    |
| db_name        | string           | appdb       | Database name      |
| username       | string           | admin       | Master username    |
| password       | sensitive string | n/a         | Master password    |
| vpc_id         | string           | n/a         | Target VPC ID      |
| subnet_ids     | list(string)     | n/a         | Subnets for RDS    |
| tags           | map(string)      | {}          | Additional tags    |

## Outputs

db_endpoint — Endpoint of RDS instance

db_name — Database name

security_group_id — Security Group ID

## ⚠️ Note

run terraform destroy after testing to avoid AWS charges
