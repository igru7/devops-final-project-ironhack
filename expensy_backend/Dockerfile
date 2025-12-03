# =====================
# Step 1: Define the Base Image (Runtime)
# =====================
FROM node:20-alpine AS base
WORKDIR /app
EXPOSE 8706

# =====================
# Step 2: Build the Application
# =====================
FROM node:20-alpine AS build
WORKDIR /src
COPY package*.json ./
RUN npm install
COPY . .

# =====================
# Step 3: Publish the Application
# =====================
FROM build AS publish
WORKDIR /app
COPY --from=build /src .
RUN npm prune --production  # remove dev dependencies

# =====================
# Final Stage
# =====================
FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["npm", "start"]
