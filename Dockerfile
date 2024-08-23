# Use a lightweight Node.js image as a parent image
FROM node:14

# Set the working directory
WORKDIR /usr/src/app

# Copy the Dockerfile and Jenkinsfile (as placeholders)
COPY Dockerfile Jenkinsfile ./

# Create a basic script as a placeholder
RUN echo "console.log('Hello, Jenkins and Docker!');" > app.js

# Expose a default application port
EXPOSE 8080

# Command to run the application
CMD ["node", "app.js"]

