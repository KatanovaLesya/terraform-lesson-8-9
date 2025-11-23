# Terraform

README.md for Terraform RDS Module in modules/rds

## Terraform Project – Lesson DB Module

### 🎯 Опис завдання

Цей проєкт реалізує гнучку Terraform-інфраструктуру з модульною структурою.
У рамках цього домашнього завдання створено універсальний RDS PostgreSQL модуль, який автоматично створює:

AWS RDS Instance (PostgreSQL)

DB Subnet Group

Security Group

Parameter Group з базовими налаштуваннями

Модуль побудовано для багаторазового використання та легкої інтеграції в існуючу Terraform інфраструктуру.

### 📁 Структура проєкту

terraform-lesson-8-9/
├── main.tf
├── backend.tf
├── providers.tf
├── outputs.tf
├── variables.tf
└── modules/
    ├── vpc/
    ├── eks/
    ├── ecr/
    ├── jenkins/
    ├── argo_cd/
    ├── s3-backend/
    └── rds/
        ├── rds.tf
        ├── shared.tf
        ├── variables.tf
        ├── outputs.tf
        └── README.md

### ⚙️ Приклад використання модуля rds

module "rds" {
  source         = "./modules/rds"
  engine_version = "12.22"
  instance_class = "db.t3.micro"
  db_name        = "mydb"
  username       = "dbadmin"
  password       = "StrongPass123!"
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnet_ids
}

### 📦 Запуск інфраструктури

terraform init
terraform plan
terraform apply

Після розгортання Terraform виведе:

db_endpoint = "mydb.xxxxxx.us-east-1.rds.amazonaws.com"
db_name     = "mydb"

### 🧾 Ключові зміни

✅ Створено модуль rds з підтримкою PostgreSQL.

✅ Автоматично генерується subnet group, parameter group, security group.

✅ Використані змінні з дефолтними значеннями та типами.

✅ Модуль інтегровано в основний проєкт через main.tf.

✅ Перевірено виконання terraform plan та apply — без помилок.

### 🧠 Автор

Катанова Леся
Database Module (Terraform RDS)
Branch: lesson-db-module
AWS Region: us-east-1
