FROM node:fermium-alpine as builder

COPY ./app /app
WORKDIR /app
RUN apk add -U build-base python
RUN yarn && \ yarn build && \ yarn install --production --ignore-scripts --prefer-offline
