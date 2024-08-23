pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id')
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Sandhyagito/Jenkins-Declarative-Pipeline-Using-Docker-GitHub-and-Jenkins.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('sandhyadev836/myapp:latest')
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'DOCKERHUB_CREDENTIALS') {
                        docker.image('sandhyadev836/myapp:latest').push()
                    }
                }
            }
        }
    }
}

