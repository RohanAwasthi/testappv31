# Base image for building the application
FROM node:16 AS build-stage

# Set the working directory
WORKDIR /bookapp-react-js

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

CMD ["npm", "start"]

# Base image for serving the application
FROM nginx:1.22.1-alpine AS prod-stage

# Copy the built application from the previous stage
COPY --from=build-stage /bookapp-react-js/build /usr/share/nginx/html

# Expose the port
EXPOSE 80

# Command to run nginx
CMD ["nginx", "-g", "daemon off;"]
