FROM node:19-alpine as primero
WORKDIR /usr/src/app
COPY ./package.json .
RUN ["npm", "install", "-D"]

FROM node:19-alpine
WORKDIR /usr/src/app
RUN ["apk", "update"]
RUN ["apk", "add", "bash"]
COPY ./package.json .
COPY ./wait-for-it.sh .
COPY ./src ./src
COPY --from=primero /usr/src/app/node_modules ./node_modules
RUN ["chmod", "+x", "/usr/src/app/wait-for-it.sh"]
EXPOSE 3000