# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json (if you have it)
COPY package*.json ./

# Set the npm cache directory to a directory owned by the node user and create it
RUN npm config set cache /home/node/.npm --global && mkdir -p /home/node/.npm

# Install dependencies as root
RUN npm install

# Copy the rest of the application code
COPY . .

# Set less permissive permissions for the working directory and npm cache
RUN chmod -R 755 /usr/src/app /home/node/.npm

# Expose the application port
EXPOSE 3000

# Command to run the application (as root)
CMD ["node", "app.js"]
