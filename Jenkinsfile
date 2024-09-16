pipeline {
    agent any
 
    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credential'
        DOCKER_REGISTRY_URL = 'https://index.docker.io/v1/'
        EC2_KEY = credentials('ec2-sshkey')
        EC2_HOST = '54.173.65.249'
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
                    // Build the Docker image with the tag 'test'
                    docker.build('sandhyadev836/my-nodejs-webapp:test')
                }
            }
        }
 
        stage('Run Tests') {
            steps {
                script {
                    docker.image('sandhyadev836/my-nodejs-webapp:test').inside {
                        sh 'npm test --verbose'
                    }
                }
            }
        }
 
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry(DOCKER_REGISTRY_URL, DOCKER_CREDENTIALS_ID) {
                        // Push the image with tag 'test' to Docker Hub
                        docker.image('sandhyadev836/my-nodejs-webapp:test').push('test')
                    }
                }
            }
        }
 
        stage('Deploy to EC2') {
            steps {
                script {
                    sshagent(['ec2-sshkey']) {
                        sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@${EC2_HOST} "
                            # Stop and remove any existing container
                            docker stop webapp-ct || true
                            docker rm webapp-ct || true
 
                            # Remove any existing image
                            docker rmi sandhyadev836/my-nodejs-webapp:test || true
 
                            # Pull the latest image from Docker Hub
                            docker pull sandhyadev836/my-nodejs-webapp:test
 
                            # Run the new container with port 80 on EC2 mapped to port 3000 inside the container
                            docker run -d --name webapp-ct -p 80:3000 sandhyadev836/my-nodejs-webapp:test
 
                            # List running containers to confirm
                            docker ps
                        "
                        '''
                    }
                }
            }
        }
    }
 
    post {
        always {
            cleanWs()
        }
    }
}

