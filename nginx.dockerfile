# Stage 1 - building and preparing /dist folder
FROM node:latest as node
LABEL author="Slaven Tomac"
# workdir can be really anything, just for reference later
WORKDIR /app
# copy local into /app
COPY . .
# install npm packages
RUN npm install
ARG env=prod
RUN npm run build

# Stage 2
FROM nginx:alpine
VOLUME /var/cache/nginx
COPY --from=node /app/dist /usr/share/nginx/html
COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf
