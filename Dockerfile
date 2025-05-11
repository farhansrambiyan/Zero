# Use a Node.js image with pnpm pre-installed
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package.json first (for dependency caching)
COPY package.json ./

# Install dependencies with pnpm
RUN npm install -g pnpm && pnpm install

# Copy all remaining files
COPY . .

# Build the project
RUN pnpm build

# Start the app
CMD ["pnpm", "start"]
