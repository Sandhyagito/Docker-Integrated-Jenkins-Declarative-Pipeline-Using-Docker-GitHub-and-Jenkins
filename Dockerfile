# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory inside the container
WORKDIR /usr/src/app

# Create a non-root user and switch to it
RUN useradd -ms /bin/sh myuser
USER myuser

# Create npm directory with correct permissions
RUN mkdir -p /home/myuser/.npm && chown -R myuser:myuser /home/myuser/.npm

# Copy package.json and package-lock.json first to leverage Docker caching
COPY --chown=myuser:myuser package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY --chown=myuser:myuser . .

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["node", "app.js"]

