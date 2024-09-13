pipeline {
    agent any

    environment {
        // Docker Hub credentials and registry URL
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
        DOCKER_REGISTRY_URL = 'https://index.docker.io/v1/'

        // EC2 Deployment settings
        EC2_KEY = credentials('ec2-sshkey')  // Jenkins credentials ID for EC2 key
        EC2_HOST = '54.173.65.249' // Replace with your EC2 instance IP or DNS
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
                    docker.build('my-node-app:test')
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    docker.image('my-node-app:test').inside {
                        sh 'ls -la ./node_modules/.bin'  // List files to check permissions
                        sh 'npm test --verbose'          // Run tests with verbose output
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry(DOCKER_REGISTRY_URL, DOCKER_CREDENTIALS_ID) {
                        docker.image('my-node-app:test').push('latest')
                    }
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                script {
                    sshagent([EC2_KEY]) {
                        sh '''
                        ssh -o StrictHostKeyChecking=no ec2-user@${EC2_HOST} <<EOF
                        docker pull my-node-app:test
                        docker run -d -p 80:3000 my-node-app:test
                        EOF
                        '''
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up workspace after build
            cleanWs()
        }
    }
}

