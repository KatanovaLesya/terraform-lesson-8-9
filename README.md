# Terraform Project. DB Module

README.md for Terraform RDS Module in modules/rds

## 🎯 Опис завдання

Цей проєкт реалізує гнучку Terraform-інфраструктуру з модульною структурою.  
У рамках цього домашнього завдання створено **універсальний RDS/Aurora PostgreSQL модуль**, який може автоматично створювати:

- ✅ Звичайний AWS RDS Instance (PostgreSQL)  
- ✅ Або Aurora PostgreSQL Cluster (через прапор `use_aurora = true`)  

Модуль також автоматично створює:

- DB Subnet Group  
- Security Group  
- Parameter Group (для RDS)  

Побудований для багаторазового використання та легкої інтеграції у будь-яку Terraform інфраструктуру.

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
        |── aurora.tf
        ├── shared.tf
        ├── variables.tf
        ├── outputs.tf
        └── README.md

### ⚙️ Приклад використання модуля rds

#### ▶️ Звичайна RDS база

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

#### ▶️ Aurora PostgreSQL Cluster

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

### 📦 Запуск інфраструктури

terraform init
terraform plan
terraform apply

Після розгортання Terraform виведе:

db_endpoint = "xxxxx.cluster-xxxxxx.us-east-1.rds.amazonaws.com"
db_name     = "mydb"
db_type     = "RDS Instance" або "Aurora Cluster"

### 🧾 Ключові зміни

✅ Універсальний модуль rds, який підтримує як RDS, так і Aurora
✅ Додано змінну use_aurora для вибору типу бази
✅ Параметри гнучко налаштовуються через змінні
✅ Оновлено outputs.tf для відображення endpoint будь-якого типу
✅ Перевірено terraform plan і apply — без помилок

### 🧠 Автор

Катанова Леся
Branch: lesson-db-module
AWS Region: us-east-1
