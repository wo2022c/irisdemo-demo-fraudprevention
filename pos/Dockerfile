FROM node:10

LABEL maintainer="Amir Samary <amir.samary@intersystems.com>"

EXPOSE 4200

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global

# Adding Node App source code
ADD ./app/ /home/node/app

# Switching Working Directory for NPM package installation
WORKDIR /home/node/app

RUN npm install --unsafe-perm

CMD npm start