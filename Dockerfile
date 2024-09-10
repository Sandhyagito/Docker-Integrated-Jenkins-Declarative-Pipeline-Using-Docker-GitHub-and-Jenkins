# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json (if you have it)
COPY package*.json ./

# Set the npm cache directory and create it
RUN npm config set cache /tmp/.npm --global && mkdir -p /tmp/.npm

# Change ownership of the npm cache directory
RUN chown -R node:node /tmp/.npm

# Install dependencies as the node user
USER node
RUN npm install

# Copy the rest of the application code
COPY --chown=node:node . .

# Expose the application port
EXPOSE 3000

# Command to run the application
CMD ["node", "app.js"]

