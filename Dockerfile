# Multi-step build

# Specify a base image and tag this phase with the name
FROM node:alpine as builder
WORKDIR '/app'
# Install some dependencies
COPY package.json .
RUN npm install
# Copy over all of source code
COPY . .
# Default container start command
CMD ["npm", "run", "build"]

FROM nginx
# Copy over build dir from the previous phase we were working on to nginx/html
COPY --from=builder /app/build /usr/share/nginx/html
# The default command of the nginx image/container is to start nginx, so we don't need to specify it here