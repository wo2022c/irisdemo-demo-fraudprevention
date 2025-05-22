FROM node:10

LABEL maintainer="Phillip Booth <phillip.booth@intersystems.com>"

EXPOSE 4200

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global

RUN mkdir -p /home/node/app && chown -R node:node /home/node

USER node

WORKDIR /home/node/app

COPY --chown=node:node ./app/ /home/node/app

RUN npm install typescript@2.9.2 --save-dev

RUN npm config set unsafe-perm true && \
    npm install node-sass@4.12.0 --unsafe-perm=true --allow-root --save-dev

RUN npm install

CMD ["npm", "start"]