# Use official Node.js image for best compatibility with Railway
FROM node:20-alpine AS base

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json (if it exists)
COPY package.json ./
COPY package-lock.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy all remaining files
COPY . .

# Build the project
RUN npm run build

# Production image
FROM node:20-alpine AS production

WORKDIR /app

# Copy node_modules and built files from previous stage
COPY --from=base /app/node_modules ./node_modules
COPY --from=base /app/.next ./.next
COPY --from=base /app/public ./public
COPY --from=base /app/package.json ./package.json

# Set environment variables
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

# Expose port 3000
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
