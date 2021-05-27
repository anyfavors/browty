FROM node:fermium-alpine as builder

COPY ./app /app
WORKDIR /app
RUN apk add -U build-base python
RUN yarn 
RUN yarn build
RUN yarn install --production --ignore-scripts --prefer-offline

FROM node:fermium-alpine
WORKDIR /app
ENV NODE_ENV=production
EXPOSE 3000


COPY --from=builder /app/build /app/build
COPY --from=builder /app/node_modules /app/node_modules
COPY ./app/package.json /app


RUN apk add -U openssh-client sshpass
ADD run.sh /app

# Default ENV params used by wetty
ENV REMOTE_SSH_SERVER=127.0.0.1 \
    REMOTE_SSH_PORT=22 \
    WETTY_PORT=3000
    
EXPOSE 3000

ENTRYPOINT "./run.sh"
