# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory inside the container
WORKDIR /usr/src/app

# Change ownership of the /usr/src/app directory to the node user
RUN chown -R node:node /usr/src/app

# Switch to the node user
USER node

# Copy the package.json and install dependencies
COPY --chown=node:node package*.json ./
RUN npm install

# Copy the rest of the application code
COPY --chown=node:node . .

# Expose the application port
EXPOSE 3000

# Start the application
CMD [ "node", "app.js" ]

