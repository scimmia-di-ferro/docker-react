FROM node:16-alpine AS build-stage

RUN mkdir /app && chown node:node /app
WORKDIR /app

USER node
COPY --chown=node:node package.json .
RUN npm install

COPY --chown=node:node . .
RUN npm run build


FROM nginx
COPY --from=build-stage /app/build /usr/share/nginx/html

