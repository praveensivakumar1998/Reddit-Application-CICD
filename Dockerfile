FROM node:18

WORKDIR /reddit-app

COPY . /reddit-app/

RUN npm install

CMD ["npm","start"]
