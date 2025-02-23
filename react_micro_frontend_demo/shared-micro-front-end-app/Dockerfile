# Step 1: Build Angular app
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy all files and build the Angular app
COPY . .
RUN npm run build --prod

# Step 2: Serve the app using NGINX
FROM nginx:1.27.3-alpine

# Copy the Angular build output to the NGINX directory
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy custom NGINX configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose the NGINX port
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
