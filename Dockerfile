# Dockerfile

# Docker: to build a container with tag name 'addressbook' 
# In directory with Dockerfile enter, "docker build -t addressbook ."

# Docker: to run the container 
# "docker run -it -p 3000:3000 addressbook"


# FROM: tells Docker what base image to use as a starting point
FROM node:16.15-alpine3.14

# RUN: executes commands inside the container
RUN mkdir -p /opt/app

# WORKDIR: changes the active directory
WORKDIR /opt/app

RUN adduser -S app
COPY addressbook/ .
RUN npm install
RUN npm install --save pm2
RUN chown -R app /opt/app

# USER: changes the active user for the rest of the commands
USER app

# EXPOSE: tells Docker which ports should be mapped outside the container
EXPOSE 3000

# CMD: defines the command to run when the container starts
# Every time a command is executed, it acts as a sort of git commit-like action in that it takes the current image, executes commands on top of it, and then returns a new image with the committed changes
CMD [ "npm", "run", "pm2" ]