# 🚀 Final DevOps Project — Full AWS Infrastructure with Terraform

## Основна мета

На основі попередніх завдань створено повну DevOps-інфраструктуру в AWS за допомогою Terraform.
Проєкт автоматизує процес розгортання інфраструктури з повним CI/CD циклом.

## Компоненти інфраструктури

🏗 VPC — створення приватних і публічних сабнетів, Internet Gateway, маршрути
🐳 ECR — Docker Registry для зберігання образів
☸️ EKS — Kubernetes кластер для розгортання застосунків
🔧 Jenkins — CI-сервер для автоматизації збірки та деплою
🚀 Argo CD — CD-система для управління застосунками (GitOps)
💾 RDS / Aurora — реляційна база даних
📊 Prometheus + Grafana — моніторинг стану системи
☁️ S3 + DynamoDB — бекенд для збереження Terraform state

## Структура проєкту

terraform-lesson-8-9/
├── main.tf               # головний файл — підключення всіх модулів
├── backend.tf            # бекенд для Terraform state (S3 + DynamoDB)
├── providers.tf          # провайдери AWS, Kubernetes, Helm
├── variables.tf          # глобальні змінні
├── outputs.tf            # основні вихідні дані
│
├── modules/
│   ├── s3-backend/       # модуль бекенду (S3 + DynamoDB)
│   ├── vpc/              # мережа VPC
│   ├── ecr/              # контейнерний реєстр
│   ├── eks/              # Kubernetes кластер (EKS)
│   ├── rds/              # база даних (RDS/Aurora)
│   ├── jenkins/          # Jenkins (CI)
│   ├── argo_cd/          # Argo CD (CD)
│   └── monitoring/       # Prometheus + Grafana
│
├── charts/
│   └── django-app/       # Helm-чарт для демо-застосунку
│
└── Django/
    ├── app/
    ├── Dockerfile
    ├── Jenkinsfile
    └── docker-compose.yaml

## Покрокова інструкція розгортання

### Ініціалізація Terraform

terraform init -upgrade

### Перевірка плану

terraform plan

### Розгортання інфраструктури

terraform apply -auto-approve

## Перевірка стану ресурсів

### Kubernetes

kubectl get nodes
kubectl get pods -A

### Перевірка по неймспейсах

kubectl get all -n jenkins
kubectl get all -n argocd
kubectl get all -n monitoring

## Порт-форвардинг для доступу до сервісів

| Сервіс         | Команда                                                                       | Порт | Опис         |
| -------------- | ----------------------------------------------------------------------------- | ---- | ------------ |
| **Jenkins**    | `kubectl port-forward svc/jenkins 8080:8080 -n jenkins`                       | 8080 | Доступ до CI |
| **Argo CD**    | `kubectl port-forward svc/argocd-server 8081:443 -n argocd`                   | 8081 | Доступ до CD |
| **Grafana**    | `kubectl port-forward svc/prometheus-grafana 3000:80 -n monitoring`           | 3000 | Моніторинг   |
| **Prometheus** | `kubectl port-forward svc/prometheus-kube-prometheus -n monitoring 9090:9090` | 9090 | Метрики      |

## Моніторинг

Grafana Dashboard доступна на <http://localhost:3000>
Prometheus метрики на <http://localhost:9090>

## Видалення інфраструктури

terraform destroy -auto-approve

## Використані технології

Terraform • AWS (EKS, ECR, RDS, S3, IAM, VPC) • Helm • Jenkins • Argo CD • Prometheus • Grafana • Docker

### 🧠 Автор

Катанова Леся
Branch: final-project
AWS Region: us-east-1
