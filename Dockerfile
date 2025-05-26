# Stage 1: Build
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .

# Stage 2: Runtime
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app .

# Security: Non-root user
RUN addgroup -g 1001 -S appgroup && \
    adduser -u 1001 -S appuser -G appgroup
USER appuser

# Back4App connection
ENV BACK4APP_APP_ID=your_app_id \
    BACK4APP_JS_KEY=your_js_key \
    BACK4APP_MASTER_KEY=your_master_key \
    NODE_ENV=production

EXPOSE 3000
CMD ["node", "server.js"]