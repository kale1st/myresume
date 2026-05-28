FROM node:22-alpine AS build
WORKDIR /usr/src/app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build -- --configuration production

FROM nginx:1.19.10-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/dist/myresume /usr/share/nginx/html

EXPOSE 80
CMD ["ng", "serve", "--host", "0.0.0.0", "--port", "4200"]