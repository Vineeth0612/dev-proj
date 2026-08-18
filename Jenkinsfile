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
               withCredentials([
            usernamePassword(
                credentialsId: 'dockerhub-creds',
                usernameVariable: 'DOCKER_USER',
                passwordVariable: 'DOCKER_PASS'
            )
        ]) {
            sh '''
                echo "$DOCKER_PASS" | docker login -u "$vineeth0612" --password-stdin
            '''
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                 script {
                   sh 'docker push vineeth0612/k8s-deploy:${BUILD_NUMBER}'    
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
