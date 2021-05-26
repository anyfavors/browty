FROM node:fermium-alpine as builder

COPY ./app /app
WORKDIR /app

RUN yarn && \ yarn build && \ yarn install --production --ignore-scripts --prefer-offline
