# Specify a base image
FROM node:18-alpine     

# Create the working directory
WORKDIR /usr/app

# Copy package.json into the container
COPY package.json ./

# Copy package.json into the container
#COPY ./ /usr/app/
#COPY ./ ./


# Install required dependencies
RUN npm install

# Copy the other files
COPY ./ ./

# Start the Node js-server
CMD ["npm","start"]