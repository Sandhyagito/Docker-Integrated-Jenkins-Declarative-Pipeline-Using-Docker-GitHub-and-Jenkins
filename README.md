# 🚀 Declarative Jenkins Pipeline Using Docker

This project demonstrates how to automate the build and deployment of a Dockerized Node.js application using a Declarative Jenkins Pipeline. The project covers setting up Jenkins, Docker, and deploying the application to an EC2 instance, following a Continuous Integration/Continuous Deployment (CI/CD) process.

## Table of Contents

- [Project Overview](#project-overview)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
- [Pipeline Stages](#pipeline-stages)
- [Jenkinsfile and Dockerfile](#jenkinsfile-and-dockerfile)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Project Overview

In this project, you will build a CI/CD pipeline using Jenkins to automate the testing, building, and deployment of a Node.js application inside a Docker container. The project focuses on the integration of Jenkins and Docker, using a declarative pipeline to streamline deployment to an EC2 instance. The Jenkins pipeline will automatically push Docker images to Docker Hub and deploy the application on an EC2 server.

## Prerequisites

Before getting started, make sure you have the following:

- Docker Hub account
- AWS EC2 instance (Ubuntu preferred)
- Jenkins installed on your EC2 instance
- Node.js and npm installed on your local machine
- GitHub account for version control
- Jenkins plugins: Docker Pipeline, SSH Agent, Git Plugin

## Setup Instructions

### 1. Clone the repository:

```bash
git clone https://github.com/yourusername/project-name.git
cd project-name
```

### 2. Jenkins Setup:

Install Jenkins on your EC2 instance.
Install the necessary plugins: Docker Pipeline, SSH Agent, and Git.
Configure credentials for Docker Hub in Jenkins (under Manage Jenkins > Manage Credentials).
Configure SSH access to your EC2 instance for deployment.

### 3. Docker Setup:
   
Ensure Docker is installed and running on your EC2 instance.

Build the Docker image for your Node.js app using the Dockerfile in the repo:

```bash
docker build -t my-nodejs-app .
```
### 4. Pipeline Configuration:

Create a Jenkins Pipeline Job.
Add the Jenkinsfile from this repository to define the pipeline stages.

### Pipeline Stages

This project uses a Jenkinsfile to automate the CI/CD process for the Node.js web application. The pipeline consists of several key stages:

- **Checkout**: Retrieves the code from the GitHub repository.
- **Build Docker Image** Builds the Docker image for the Node.js application.
- **Run Tests**: Runs basic tests in a Docker container (e.g., npm test).
- **Push to Docker Hub**: Pushes the Docker image to Docker Hub for deployment.
- **Deploy to EC2**: Deploys the application(container) to an EC2 instance via SSH.

### Jenkinsfile and Dockerfile

## Jenkinsfile

The Jenkinsfile defines the pipeline stages in a declarative syntax:

```bash
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/yourusername/project-name.git'
            }
        }
        stage('Build') {
            steps {
                sh 'docker build -t my-nodejs-app .'
            }
        }
        stage('Test') {
            steps {
                sh 'npm test'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        docker.image('yourusername/my-nodejs-app:latest').push()
                    }
                }
            }
        }
        stage('Deploy to EC2') {
            steps {
                sshagent (credentials: ['ec2-ssh-credentials']) {
                    sh '''
                    ssh ubuntu@your-ec2-ip << EOF
                    docker stop my-nodejs-app || true
                    docker rm my-nodejs-app || true
                    docker run -d -p 80:3000 my-nodejs-app
                    EOF
                    '''
                }
            }
        }
    }
}
```

## Dockerfile

The Dockerfile defines how the Node.js application will be containerized:

```bash
FROM node:14
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD [ "node", "app.js" ]
```
### Usage

Push code to GitHub to trigger the Jenkins pipeline.
Jenkins will automatically execute the pipeline: build, test, push to Docker Hub, and deploy to EC2.
After successful deployment, access the Node.js app on your EC2 instance’s public IP address.

### Contributing
Contributions are welcome! Feel free to fork the repository and submit a pull request with your improvements or bug fixes.

### License
This project is licensed under the MIT License. See the LICENSE file for more details.

### Contact
For any questions or issues, please raise a GitHub issue or contact me at sandhya.bca7@gmail.com.
