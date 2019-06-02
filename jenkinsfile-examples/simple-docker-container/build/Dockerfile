# Stage 1: Build
FROM node:lts-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install -g yarn
RUN yarn
COPY . .
RUN yarn build

# Stage 2: Final Image
FROM nginx:stable-alpine as production-stage
COPY --from=builder /app/dist /usr/share/nginx/html
COPY build/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
