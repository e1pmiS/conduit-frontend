# Build
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
# angular.json already sets: outputPath: dist/angular-conduit
RUN npm run build -- --configuration=production

# Run
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist/angular-conduit/ /usr/share/nginx/html/
EXPOSE 80
