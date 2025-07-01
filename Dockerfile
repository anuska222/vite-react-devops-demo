# Step 1: Build the Vite app
FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . ./
RUN npm run build
RUN ls

# Step 2: Serve the build using Nginx
FROM nginx:1.17.1-alpine

# Comment out this line if you don't have nginx.conf
# COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
