# Stage 1: Builder
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Production
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist

# Security
RUN addgroup -g 1001 -S appgroup && \
    adduser -u 1001 -S appuser -G appgroup
USER appuser

# Environment
ENV NODE_ENV=production
ENV BACK4APP_APP_ID=your_app_id
ENV BACK4APP_JS_KEY=your_js_key
ENV BACK4APP_MASTER_KEY=your_master_key

EXPOSE 3000
CMD ["node", "dist/server.js"]