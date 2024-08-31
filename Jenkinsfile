pipeline {
    agent any

    environment {
        EC2_CREDENTIALS = credentials('ec2-credentials-id')
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Sandhyagito/Jenkins-Declarative-Pipeline-Using-Docker-GitHub-and-Jenkins.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('sandhyadev836/mynodejs-webapp:latest')
                }
            }
        }
        stage('Run Tests') {
            steps {
                script {
                    docker.image('sandhyadev836/mynodejs-webapp:latest').inside {
                        sh 'npm install'
                        sh 'npm test'
                    }
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials-id') {
                        docker.image('sandhyadev836/mynodejs-webapp:latest').push()
                    }
                }
            }
        }
        stage('Deploy to EC2') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'ec2-credentials-id', usernameVariable: 'EC2_USER', passwordVariable: 'EC2_PASSWORD')]) {
                    sh '''
                    sshpass -p "$EC2_PASSWORD" ssh -o StrictHostKeyChecking=no $EC2_USER@${EC2_INSTANCE_IP} "
                    docker pull sandhyadev836/mynodejs-webapp:latest &&
                    docker stop mynodejs-webapp || true &&
                    docker rm mynodejs-webapp || true &&
                    docker run -d --name mynodejs-webapp -p 8080:8080 sandhyadev836/mynodejs-webapp:latest
                    "
                    '''
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
        success {
            echo 'Deployment succeeded!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}

