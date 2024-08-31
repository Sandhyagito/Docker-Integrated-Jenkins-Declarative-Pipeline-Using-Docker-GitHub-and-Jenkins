# Use an official Node.js runtime as a parent image
FROM node:14

# Create a non-root user and set permissions
RUN useradd -ms /bin/sh myuser
USER myuser

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the package.json and install dependencies
COPY --chown=myuser:myuser package*.json ./
RUN npm install

# Copy the rest of the application code
COPY --chown=myuser:myuser . .

# Expose the application port
EXPOSE 3000

# Start the application
CMD [ "node", "app.js" ]

