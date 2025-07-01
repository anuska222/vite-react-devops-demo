# Step 1: Build the Vite app
FROM node:18 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Step 2: Serve the app using nginx
FROM nginx:1.17.1-alpine

# Optional: add a custom nginx config (you can remove this if you don't have nginx.conf)
# COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
