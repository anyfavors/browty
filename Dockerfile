FROM node:fermium-alpine as builder
WORKDIR /app

COPY . /app
RUN yarn && \ yarn build && \ yarn install --production --ignore-scripts --prefer-offline
