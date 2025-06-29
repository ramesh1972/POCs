# Stage 1: Build the Angular app
FROM node:18-alpine AS build
WORKDIR /app

# Install dependencies and build the Angular app
COPY package.json package-lock.json ./
RUN npm install --legacy-peer-deps
COPY . .
RUN npm run build:prod

# Stage 2: Serve the Angular app using pm2 on Alpine
FROM alpine:3.21
WORKDIR /app

# Install necessary packages
RUN apk add --no-cache nodejs npm bash

# Install pm2 globally
RUN npm install -g pm2

# Install a lightweight HTTP server to serve the Angular app
RUN npm install -g http-server

# Copy the built Angular app from the build stage
COPY --from=build /app/dist/destiny-limo/browser ./dist

FROM nginx:alpine
COPY --from=build /app/dist/destiny-limo/browser /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 9080
CMD ["nginx", "-g", "daemon off;"]