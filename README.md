**Automating Docker Image Build and Deployment with Jenkins Declarative Pipeline, GitHub, and Webhooks**

Overview:

This project demonstrates how to automate the build and deployment process using Jenkins, Docker, GitHub, and webhooks. By setting up a declarative Jenkins pipeline, we’ll automate the process of building a Docker image from a GitHub repository, running a simple Node.js application, and pushing the Docker image to Docker Hub.

Objective:

The objective of this project is to:

Automate the build and deployment process using Jenkins.
Create a Jenkins pipeline that builds a Docker image from a GitHub repository, runs a simple Node.js application, and pushes the image to Docker Hub.
Integrate Docker with Jenkins for a streamlined CI/CD pipeline.
Automate the entire process using GitHub webhooks.

Prerequisites:

Jenkins installed (running on an EC2 instance or a local machine).
Docker installed and configured in Jenkins.
A GitHub account and a repository for the project.
Jenkins plugins: Git, Docker Pipeline, GitHub Integration.

Step-by-Step Instructions:

1. Setting Up the GitHub Repository:

Create a new repository on GitHub.

Clone the repository locally:

git clone https://github.com/YourUsername/YourRepo.git
cd YourRepo

Create the Dockerfile and Jenkinsfile:

touch Dockerfile Jenkinsfile

Use vi or any text editor to add the following content to the files.

2. Dockerfile Content:

dockerfile

![image](https://github.com/user-attachments/assets/c9db6744-d03a-48f7-aafd-39f11250c0eb)


3. Jenkinsfile Content:

![image](https://github.com/user-attachments/assets/2dbc9277-ae90-498b-a0d7-4a591ec804a2)
  ![image](https://github.com/user-attachments/assets/0a1f5cd4-d2de-4fa7-acc7-dd0adef03dbc)


4. Commit and Push Changes to GitHub:

git add Dockerfile Jenkinsfile
git commit -m "Added Dockerfile and Jenkinsfile"
git push origin main

6. Set Up Jenkins Pipeline:
Create a New Pipeline Job in Jenkins:

Open your Jenkins dashboard.
Click on "New Item".
Enter the job name (e.g., "Docker Jenkins Pipeline").
Select "Pipeline" as the project type and click "OK".
Under "Build Triggers":
Scroll down to the "Build Triggers" section.
Check the box for "GitHub hook trigger for GITScm polling". This ensures the pipeline triggers automatically when you push code to your GitHub repository.
Write the Pipeline Script:
In the "Pipeline" section, select "Pipeline script" and paste the following script( Jenkinsfile)
Save the Pipeline:
Click "Save" to store your pipeline configuration.

<img width="609" alt="build success" src="https://github.com/user-attachments/assets/de9761ce-f451-4288-a791-ee8e70d0fd93">

<img width="795" alt="jenkins pipeline success" src="https://github.com/user-attachments/assets/79ea4e40-b339-4fdf-a2ab-6e090ac66525">

6. Configure GitHub Webhook:

Go to your GitHub repository settings.
Under "Webhooks", click "Add webhook".
Enter the Jenkins URL followed by /github-webhook/ (e.g., http://your-jenkins-url/github-webhook/).

7. Testing the Automation:

Make a change in the repository (e.g., update the README).
Commit and push the change. Jenkins should automatically trigger the pipeline.

<img width="557" alt="automate CI trigger" src="https://github.com/user-attachments/assets/bb1dc9ec-946f-45df-9b62-4b857197f0d1">

Outcome:

This project automated the process of building a Docker image, running a simple Node.js application, and pushing the image to Docker Hub using Jenkins Declarative Pipeline and webhooks. The integration of GitHub webhooks ensures the process is fully automated upon every code change.

<img width="928" alt="Dockerhub" src="https://github.com/user-attachments/assets/cef5def4-9872-4f95-b7f6-f64e1f454013">

![image](https://github.com/user-attachments/assets/f42d76f5-484c-49aa-8f92-73011436772a)

Troubleshooting:

Git Checkout Issues: If Jenkins fails to fetch the repository, ensure the correct branch is specified and the repository URL is correct.
Docker Build Errors: Ensure Docker is correctly configured in Jenkins and that the Dockerfile syntax is valid.
Webhook Not Triggering: Double-check the webhook URL in GitHub and make sure Jenkins is accessible from GitHub.

Conclusion:

This project provided hands-on experience in setting up a fully automated CI/CD pipeline using Jenkins, Docker, and GitHub. The integration of webhooks showcases how continuous integration can be achieved efficiently, enabling seamless deployments.
