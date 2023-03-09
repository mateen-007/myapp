FROM node:14 as node
WORKDIR /my-app
COPY . .
RUN npm install
RUN npm run build --prod

FROM nginx:latest
RUN rm -rf /usr/share/nginx/html/*
COPY --from=node /my-app/dist/my-app /usr/share/nginx/html
