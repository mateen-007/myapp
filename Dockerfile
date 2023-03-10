# Base image with Node.js installed
FROM node:14-alpine AS build

# Create a working directory for the app
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy the rest of the app source code to the working directory
COPY . .

# Build the app
RUN npm run build

# Base image with Nginx installed
FROM nginx:alpine

# Copy the app build artifacts from the previous stage to the default Nginx public directory
COPY --from=build /app/dist/my-app /usr/share/nginx/html

# Expose the default Nginx port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
