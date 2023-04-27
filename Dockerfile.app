FROM node:16

COPY package-dockerfile-app.json ./package.json

RUN npm install

COPY elm.json ./

COPY serve.json ./

ENV ELM_HOME=/.elm

COPY ./public ./public
COPY ./src ./src

RUN npm run build:app

CMD ["npm", "run", "start:built-app"]
