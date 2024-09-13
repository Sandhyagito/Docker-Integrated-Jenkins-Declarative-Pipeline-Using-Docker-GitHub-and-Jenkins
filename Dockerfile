# Use an official Node.js runtime as a parent image
FROM node:14

# Install sudo
RUN apt-get update && apt-get install -y sudo

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json (if you have it)
COPY package*.json ./

# Set the npm cache directory globally
RUN npm config set cache /tmp/.npm --global && mkdir -p /tmp/.npm

# Install dependencies as root
RUN npm install

# Copy the rest of the application code
COPY . .

# Set ownership of the working directory for the non-root user
RUN chown -R node:node /usr/src/app

# Switch to the non-root user
USER node

# Expose the application port
EXPOSE 3000

# Command to run the application
CMD ["node", "app.js"]

