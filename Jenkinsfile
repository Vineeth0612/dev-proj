pipeline {

    agent any

    environment {
        DOCKER_IMAGE = "vineeth0612/k8s-deploy"
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/Vineeth0612/dev-proj.git'
            }
        }

        stage('Build Docker Image') {
            steps {
               sh 'docker build -t vineeth0612/k8s-deploy:${BUILD_NUMBER} .'
            }
        }

        stage('Login Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-creds') {
                        echo 'Logged in to DockerHub'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                 script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-creds') {
                        docker.image("vineeth0612/k8s-deploy").push()
                       
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yaml'
                sh 'kubectl apply -f k8s/service.yaml'
            }
        }

        stage('Verify Deployment') {
            steps {
                sh 'kubectl get pods'
                sh 'kubectl get services'
            }
        }
    }
}
