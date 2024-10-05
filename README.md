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
