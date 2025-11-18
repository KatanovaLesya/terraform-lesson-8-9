region = "us-east-1"

vpc_id = "vpc-01b155ceac2d20e8c"

public_subnet_ids = [
  "subnet-05093ec1c602f1c8e",
  "subnet-0d7a495a8d6881de7",
  "subnet-0b7773ab2e97aabba",
]

private_subnet_ids = [
  "subnet-00174cfbb279a033b",
  "subnet-0a0c2bec514dd639a",
  "subnet-0d77102da5ab3b3e7",
]

cluster_name  = "lesson-7-eks"
ecr_repo_name = "lesson-7-ecr"
app_image_tag = "v1"
app_port      = 8000

ecr_name = "lesson-7-django-ecr"
