# Frontend Dockerfile
FROM node:18-slim

# Set working directory
WORKDIR /app

# Copy package files first (for caching)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all source code
COPY . .

# Set the environment variable for the React build
ENV REACT_APP_BASE_URL=http://backend:8706

# Build the React application
RUN npm run build

# Expose port
EXPOSE 3000

# Set default environment for runtime
ENV PORT=3000
ENV HOST=0.0.0.0

# Start the application
CMD ["npm", "start"]
