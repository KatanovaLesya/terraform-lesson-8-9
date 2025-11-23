# CI/CD Pipeline: Terraform + Jenkins + ECR + Helm + Argo CD  

## Lesson 8-9 — Katanova Lesia

## 🎯 Мета проєкту

Реалізувати повний CI/CD процес із використанням Terraform, Jenkins, Amazon ECR, Helm і Argo CD, який:

- автоматично збирає Docker-образ Django-застосунку;
- пушить образ в Amazon ECR;
- оновлює тег у `values.yaml` Helm-чарту;
- пушить зміни у Git;
- Argo CD автоматично синхронізує застосунок у кластері Kubernetes.

---

## 🏗️ Інфраструктура (Terraform)

### 📦 Що створюється

| Компонент | Опис |
|-----------|------|
| S3 + DynamoDB | Backend для Terraform state |
| VPC | Приватні та публічні підмережі, Internet Gateway |
| EKS Cluster | Kubernetes кластер |
| ECR Repository | Реєстр Docker-образів |
| IAM Roles | Для EKS кластера та нод |
| Jenkins | Встановлений через Helm через Terraform |
| Argo CD | Встановлено через Helm через Terraform |

---

## 🚀 Команди для запуску Terraform

### 1️⃣ Ініціалізація проєкту

terraform init

### 2️⃣ Перевірка конфігурації

terraform validate

### 3️⃣ Перегляд плану

terraform plan

### 4️⃣ Створення ресурсів

terraform apply

### 5️⃣ Видалення всієї інфраструктури (після перевірки!)

terraform destroy

## 🔐 Jenkins доступ

### Перевірка статусу Helm release

helm status jenkins -n jenkins
kubectl get pods -n jenkins

### Отримати пароль адміністратора

kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- \
/bin/cat /run/secrets/additional/chart-admin-password && echo

### Проксі доступ (локально)

kubectl port-forward -n jenkins svc/jenkins 8080:8080

### 🌐 Відкрити в браузері

<http://localhost:8080>

### 👤 Логін

admin

## 🧰 CI/CD Pipeline (Jenkinsfile)

Jenkins виконує:

1️⃣ Клонує репозиторій з Django-проєктом
2️⃣ Будує Docker image через Kaniko
3️⃣ Пушить образ в ECR:

979126074710.dkr.ecr.us-east-1.amazonaws.com/lesson-8-9-django-ecr

4️⃣ Оновлює тег у charts/django-app/values.yaml
5️⃣ Комітить зміни і пушить у main
6️⃣ Argo CD автоматично їх підхоплює

## 🌐 Argo CD встановлення та перевірка

### Перевірка інсталяції

kubectl get pods -n argocd
helm status argo-cd -n argocd

### Port-forward для доступу до UI

kubectl port-forward svc/argocd-server -n argocd 8080:443

### Web UI

<https://localhost:8080>

### 👤 Логін

Username: admin

Пароль:

kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d

## 📄 Argo CD Applications (Helm chart)

### Структура модулю argo_cd

modules/argo_cd/
 ├── providers.tf
 ├── argo_cd.tf
 ├── variables.tf
 ├── charts/
 │   └── django-app/
 │       ├── Chart.yaml
 │       ├── values.yaml
 │       └── templates/
 │           ├── application.yaml
 │           └── repository.yaml

### 📁 Структура репозиторію

terraform-lesson-8-9/
├── main.tf
├── backend.tf
├── outputs.tf
├── modules/
│   ├── s3-backend/
│   ├── vpc/
│   ├── eks/
│   ├── ecr/
│   ├── jenkins/
│   └── argo_cd/
└── charts/
    └── django-app/

### 📦 Docker Image перевірка

aws ecr describe-images \
  --repository-name lesson-8-9-django-ecr \
  --region us-east-1

### 📌 Посилання

GitHub репозиторій 📎 [](https://github.com/KatanovaLesya/terraform-lesson-8-9.git)
ECR repository 979126074710.dkr.ecr.us-east-1.amazonaws.com/lesson-8-9-django-ecr

## 📌 Автор

👤 Katanova Lesia
📘 DevOps Terraform + Jenkins + Argo CD
🗓️ 2025
