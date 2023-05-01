# Use a Node.js base image
FROM node:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY server/package*.json ./

# Install the dependencies
RUN npm install

# Install ts-node
RUN npm install -g typescript ts-node

# Copy the rest of the server code to the container
COPY server .

# Set the environment variables
ENV NODE_ENV=ENV
ENV PORT=4000

# Expose the port the server will listen on
EXPOSE $PORT

RUN npx prisma generate --schema ./src/prisma/schema.prisma

# Start the server
CMD ["ts-node", "-r", "tsconfig-paths/register", "src/index.ts"]
