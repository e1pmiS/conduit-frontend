FROM node:18-alpine

WORKDIR /app

# deterministic install using lockfile (npm 9)
COPY package*.json ./
RUN npm ci

# app sources + proxy
COPY . .
COPY proxy.conf.json ./proxy.conf.json

EXPOSE 4200
CMD ["npx","ng","serve","--host","0.0.0.0","--port","4200","--proxy-config","proxy.conf.json"]
