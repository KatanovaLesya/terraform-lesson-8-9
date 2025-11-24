# Terraform RDS/Aurora Module

## Description

This module creates either:

- a **standard AWS RDS PostgreSQL instance**, or  
- an **Aurora PostgreSQL cluster**  

depending on the flag `use_aurora`.

It automatically includes:

- DB Subnet Group  
- Security Group  
- Parameter Group (for RDS)  

## Example usage

### ▶️ Regular RDS instance

module "rds" {
  source         = "./modules/rds"
  use_aurora     = false
  engine         = "postgres"
  engine_version = "12.22"
  instance_class = "db.t3.micro"
  db_name        = "mydb"
  username       = "dbadmin"
  password       = "StrongPass123!"
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnet_ids
}

### ▶ Aurora Cluster

module "rds" {
  source         = "./modules/rds"
  use_aurora     = true
  engine         = "aurora-postgresql"
  engine_version = "12.22"
  instance_class = "db.t3.medium"
  db_name        = "aurora_db"
  username       = "dbadmin"
  password       = "StrongPass123!"
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnet_ids
}

## Variables

| Name             | Type             | Default       | Description                                     |
| ---------------- | ---------------- | ------------- | ----------------------------------------------- |
| `use_aurora`     | bool             | false         | If true, deploy Aurora cluster instead of RDS   |
| `engine`         | string           | "postgres"    | Engine type (`postgres` or `aurora-postgresql`) |
| `engine_version` | string           | "12.22"       | Engine version                                  |
| `instance_class` | string           | "db.t3.micro" | Instance class                                  |
| `multi_az`       | bool             | false         | Enable Multi-AZ (RDS only)                      |
| `db_name`        | string           | "appdb"       | Database name                                   |
| `username`       | string           | "dbadmin"     | Master username                                 |
| `password`       | sensitive string | n/a           | Master password                                 |
| `vpc_id`         | string           | n/a           | VPC ID                                          |
| `subnet_ids`     | list(string)     | n/a           | Subnet IDs for DB subnet group                  |
| `tags`           | map(string)      | {}            | Additional tags                                 |

## Outputs

| Name                | Description                                     |
| ------------------- | ----------------------------------------------- |
| `db_endpoint`       | Endpoint of RDS or Aurora database              |
| `db_name`           | Database name                                   |
| `security_group_id` | Security group ID used by the DB                |
| `db_type`           | Shows which DB type was created (RDS or Aurora) |

## ⚠️ Note

Run terraform destroy after testing to avoid AWS costs.
Aurora clusters may take longer to create than regular RDS instances.
Parameter Group is only created for standard RDS databases.
