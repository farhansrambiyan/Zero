# Use the official Node.js image as the base image
FROM node:20-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy only package.json first (for installing dependencies)
COPY package.json ./

# If you have a package-lock.json, uncomment the next line:
# COPY package-lock.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy all remaining files into the container
COPY . .

# Build the project (if you have a build script, e.g., for Next.js)
RUN npm run build

# Expose the app port (change if your app uses a different port)
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
