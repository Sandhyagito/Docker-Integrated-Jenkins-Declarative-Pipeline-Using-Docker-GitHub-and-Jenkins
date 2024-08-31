# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the package.json and install dependencies as root user
COPY package*.json ./
RUN npm install

# Create a non-root user and set permissions
RUN useradd -ms /bin/sh myuser
RUN chown -R myuser:myuser /usr/src/app

# Switch to non-root user
USER myuser

# Copy the rest of the application code
COPY --chown=myuser:myuser . .

# Expose the application port
EXPOSE 3000

# Start the application
CMD [ "node", "app.js" ]

