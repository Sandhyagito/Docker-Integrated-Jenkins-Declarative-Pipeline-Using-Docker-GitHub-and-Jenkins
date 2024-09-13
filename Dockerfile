# Use the official Node.js image
FROM node:14

# Create app directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first to install dependencies
COPY package*.json ./

# Set npm cache directory and fix permissions
RUN npm config set cache /home/node/.npm --global
RUN mkdir -p /home/node/.npm && chown -R node:node /home/node/.npm

# Install dependencies using npm ci
RUN npm ci

# Copy the rest of the application code
COPY . .

# Set the correct permissions
RUN chown -R node:node /usr/src/app

# Switch to the node user
USER node

# Expose the port
EXPOSE 8080

# Start the app
CMD ["npm", "start"]

