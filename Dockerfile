FROM node:18.0-alpine3.14 as build-stage
ENV NODE_ENV=production

WORKDIR /app

COPY package.json .

RUN npm config set registry https://registry.npmmirror.com/

RUN npm install
RUN npm install -g @nestjs/cli

COPY . .

RUN NODE_ENV=production npm run build

# production stage
FROM node:18.0-alpine3.14 as production-stage

COPY --from=build-stage /app/dist /app
COPY --from=build-stage /app/package.json /app/package.json

WORKDIR /app

RUN npm config set registry https://registry.npmmirror.com/

RUN npm install --production

EXPOSE 3005

CMD ["node", "/app/main.js"]
