# =====================
# Step 1: Define the Base Image (Runtime)
# =====================
FROM node:20-alpine AS base
WORKDIR /app
# Expose the port your frontend app will run on
EXPOSE 3000
ENV HOST=0.0.0.0
ENV PORT=3000

# =====================
# Step 2: Build the Application
# =====================
FROM node:20-alpine AS build
WORKDIR /src
# Copy package.json and package-lock.json first for caching
COPY package*.json ./
RUN npm install
# Copy all frontend source files
COPY . .

# =====================
# Step 3: Publish the Application
# =====================
FROM build AS publish
WORKDIR /app
COPY --from=build /src ./
# If using a frontend framework (React/Vue/Angular), run build command
RUN npm run build

# =====================
# Final Stage
# =====================
FROM node:20-alpine AS final
WORKDIR /app
COPY --from=publish /app ./
# For production, you may serve with a lightweight server like serve
RUN npm install -g serve
ENTRYPOINT ["serve", "-s", "build", "-l", "3000"]
