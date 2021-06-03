# Use ionic base image
FROM beevelop/ionic AS ionic

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies by copying
# package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy app source
COPY . .

# Compile app source
RUN ionic build

# Final container
FROM nginx:alpine
EXPOSE 80
COPY --from=ionic /usr/src/app/www /usr/share/nginx/html
