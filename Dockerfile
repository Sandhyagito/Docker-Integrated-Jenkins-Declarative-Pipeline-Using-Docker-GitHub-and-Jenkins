FROM node:14

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first
COPY package*.json ./

# Set npm cache directory and permissions
RUN npm config set cache /home/node/.npm --global && \
    mkdir -p /home/node/.npm && \
    chown -R node:node /home/node/.npm

# Install dependencies
RUN npm ci

# Copy the rest of the application code
COPY . .

# Change ownership of the app directory to the node user
RUN chown -R node:node /usr/src/app

USER node

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD [ "node", "index.js" ]

