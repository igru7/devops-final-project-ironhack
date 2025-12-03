# Base Image
FROM node:latest

# Metadata
LABEL maintainer="Ironhack DevOps"

# Set Working Directory
WORKDIR /app

# Copy application files to the container
COPY . .

# Install dependencies
RUN npm install

#Env
ENV HOST=0.0.0.0
ENV PORT=3000

# Expose application port
EXPOSE 3000

# Define persistent volume for application files
VOLUME [ "/app" ]

# Start the application
CMD ["npm", "run", "dev"]