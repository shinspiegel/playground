# Base image to start from
# A node image using the latest version using Alpine Linux 3.11
FROM node:current-alpine3.11

# Set the Working Directory the Containers Terminal Starts from
WORKDIR /usr/src/app

# Copy Project Over from this folder "." to "/usr/src/app/" in the container
COPY . /usr/src/app/

# install dependencies
RUN npm install

# Kick start the container with the entrypoint script
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]