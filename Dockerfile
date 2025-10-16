FROM node:20 AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
ENV VUE_APP_ORDER_SERVICE_URL=http://localhost:3000/orders
ENV VUE_APP_PRODUCT_SERVICE_URL=http://localhost:3030/products
RUN npm run build

FROM nginx:alpine
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80