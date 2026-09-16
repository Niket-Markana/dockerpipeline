# Use the official Node.js image as the base image, specifically the "slim" variant,
# which is a smaller version of the image
FROM node:slim

# Set the environment variable NODE_ENV to "development"
# This can be used by your application to determine the environment it is running in
ENV NODE_ENV development

# Set the working directory in the container to /express-docker
# All subsequent commands will be run in this directory
WORKDIR /express-docker

# Copy all files from the current directory on the host machine to the working directory in the container
COPY . .

# Run the command "npm install" to install all dependencies listed in the package.json file
RUN npm install

# Inform Docker that the container will listen on port 3000 at runtime
EXPOSE 3000

# Specify the command to run when the container starts
# Here, it will run "node index.js" to start your Node.js application
CMD [ "node", "index.js" ]
