# Multistage docker file

FROM node:18-alpine3.18
WORKDIR /app
COPY package.json /app/package.json
RUN npm install
COPY . /app
EXPOSE 3000
CMD ["npm", "start"]

# Build Stage
FROM node:18-alpine3.18 as build
WORKDIR /app
COPY package.json /app/package.json
RUN npm install
COPY . /app
RUN npm run build

# # Production Stage
FROM nginx:stable-alpine as deploy
WORKDIR /usr/share/nginx/html
COPY --from=BUILD /app/build .
EXPOSE 80