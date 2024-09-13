# Use the official Node.js image as a base
FROM node:14

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Install Mocha globally (if necessary)
RUN npm install -g mocha

# Set permissions (if necessary)
RUN chown -R node:node /usr/src/app

# Switch to a non-root user
USER node

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]

