FROM node:20-alpine AS base
WORKDIR /app
COPY package.json ./  # Only this line remains
RUN npm install --legacy-peer-deps
COPY . .
RUN npm run build
CMD ["npm", "start"]
