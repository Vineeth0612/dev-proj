pipeline {

    agent any

    environment {
        DOCKER_IMAGE = "vineeth0612/deployment:vk"
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
               sh 'docker build -t vineeth0612/deployment:vk${BUILD_NUMBER} .'
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
                printf '%s' "$DOCKER_PASS" | docker login \
                    --username "$DOCKER_USER" \
                    --password-stdin
            '''
        }
    }
}

        stage('Push Docker Image') {
            steps {
                 script {
                   sh 'docker push vineeth0612/deployment:vk${BUILD_NUMBER}'    
                    }
                }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'pwd'
                sh 'export KUBECONFIG=/var/lib/jenkins/.kube/config'
                sh 'kubectl apply -f Deployment.yaml'
                sh 'kubectl apply -f Service.yaml'
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
