# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json (if you have it)
COPY package*.json ./

# Set the npm cache directory and install dependencies as root
RUN npm config set cache /tmp/.npm --global && mkdir -p /tmp/.npm \
    && chmod -R 777 /tmp/.npm \
    && npm install

# Copy the rest of the application code
COPY . .

# Set permissions for the working directory and npm cache
RUN chmod -R 777 /usr/src/app

# Switch to the non-root user
#USER node

# Expose the application port
EXPOSE 3000

# Command to run the application
CMD ["node", "app.js"]


