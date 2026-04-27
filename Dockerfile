#PRIMERA FASE CONSTRUIR LA SOLUCIÒN
FROM node:lts-bullseye as buildtodeploy
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

#FASE 2 CREACIÒN DE LA IMAGEN DE DOCKER
FROM nginx:alpine
ADD ./config/default.conf /etc/nginx/conf.d/default.conf
COPY --from=buildtodeploy /app/.next/ /var/www/app/
EXPOSE 80
CMD ["mgnix","-g","daemon off;"]
