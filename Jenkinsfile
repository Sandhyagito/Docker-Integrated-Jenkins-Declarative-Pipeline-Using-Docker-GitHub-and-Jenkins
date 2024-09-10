pipeline {
    agent any

    environment {
        EC2_CREDENTIALS = credentials('ec2-credential')
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credential')
        EC2_INSTANCE_IP = '54.197.14.84'  // Replace with your EC2 instance IP address
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
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credential') {
                        docker.image('sandhyadev836/mynodejs-webapp:latest').push('latest')
                    }
                }
            }
        }
        stage('Deploy to EC2') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'ec2-credential', usernameVariable: 'EC2_USER', passwordVariable: 'EC2_PASSWORD')]) {
                    sh '''
                    # Use sshpass to avoid interactive prompts for the SSH password
                    sshpass -p "$EC2_PASSWORD" ssh -o StrictHostKeyChecking=no $EC2_USER@$EC2_INSTANCE_IP << 'EOF'
                    
                    # Pull the latest Docker image
                    docker pull sandhyadev836/mynodejs-webapp:latest

                    # Stop and remove any existing container with the same name
                    docker stop mynodejs-webapp || true
                    docker rm mynodejs-webapp || true

                    # Run the new container
                    docker run -d --name mynodejs-webapp -p 8080:3000 sandhyadev836/mynodejs-webapp:latest
                    EOF
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

