# Step 1: Build
FROM node:15.2-alpine AS build
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build --prod

# Step 2: Run
FROM nginx:1.17-alpine AS prod-stage
COPY --from=build /app/dist/angular-docker /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]