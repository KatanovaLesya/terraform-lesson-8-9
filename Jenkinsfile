pipeline {
    agent any

    environment {
        AWS_REGION      = "us-east-1"
        AWS_ACCOUNT_ID  = "979126074710"
        ECR_REPOSITORY  = "lesson-8-9-django-ecr"
        ECR_REGISTRY    = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
        IMAGE_TAG       = "${env.BUILD_NUMBER}"

        // TODO: заміни IDs на свої credentials в Jenkins
        AWS_CREDENTIALS_ID = "aws-creds"
        GIT_CREDENTIALS_ID = "github-creds"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[
                        url: 'https://github.com/KatanovaLesya/terraform-lesson-8-9.git',
                        credentialsId: "${GIT_CREDENTIALS_ID}"
                    ]]
                ])
            }
        }

        stage('Login to ECR') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: "${AWS_CREDENTIALS_ID}"
                ]]) {
                    sh """
                      aws configure set default.region ${AWS_REGION}
                      aws ecr get-login-password --region ${AWS_REGION} \
                        | docker login --username AWS --password-stdin ${ECR_REGISTRY}
                    """
                }
            }
        }

        stage('Build Docker image') {
            steps {
                sh """
                  cd web
                  docker build -t ${ECR_REPOSITORY}:${IMAGE_TAG} .
                  docker tag ${ECR_REPOSITORY}:${IMAGE_TAG} ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}
                """
            }
        }

        stage('Push to ECR') {
            steps {
                sh """
                  docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}
                """
            }
        }

        stage('Update Helm values') {
            steps {
                sh """
                  sed -i.bak 's|^  tag:.*|  tag: "${IMAGE_TAG}"|' charts/django-app/values.yaml
                  rm -f charts/django-app/values.yaml.bak
                """
            }
        }

        stage('Git commit & push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${GIT_CREDENTIALS_ID}",
                    usernameVariable: 'GIT_USER',
                    passwordVariable: 'GIT_PASS'
                )]) {
                    sh """
                      git config user.email "jenkins@example.com"
                      git config user.name  "Jenkins"

                      git add charts/django-app/values.yaml
                      git commit -m "Update image tag to ${IMAGE_TAG}" || echo "Nothing to commit"

                      git push https://$GIT_USER:$GIT_PASS@github.com/USERNAME/terraform-lesson-8-9.git HEAD:main
                    """
                }
            }
        }
    }
}
