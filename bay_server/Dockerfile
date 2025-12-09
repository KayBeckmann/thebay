# Build stage
FROM dart:stable AS build
WORKDIR /app

# Copy pubspec files first for better layer caching
COPY pubspec.* ./
RUN dart pub get

# Copy source code
COPY . .

# Install dependencies and compile the server executable
RUN dart pub get --offline
RUN dart compile exe bin/main.dart -o bin/server

# Final stage
FROM alpine:latest

# Environment variables
ENV runmode=production
ENV serverid=default
ENV logging=normal
ENV role=monolith
ENV apply_migrations=true

# Copy runtime dependencies
COPY --from=build /runtime/ /

# Create app directory
WORKDIR /app

# Copy compiled server executable
COPY --from=build /app/bin/server server

# Copy configuration files and resources
COPY --from=build /app/config/ config/
COPY --from=build /app/web/ web/
COPY --from=build /app/migrations/ migrations/

# This file is required to enable the endpoint log filter in Insights.
COPY --from=build /app/lib/src/generated/protocol.yaml lib/src/generated/protocol.yaml

# Create uploads directory for images
RUN mkdir -p /app/uploads && chmod 755 /app/uploads

# Expose ports
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:8080/ || exit 1

# Define the entrypoint command
ENTRYPOINT ./server --mode=$runmode --server-id=$serverid --logging=$logging --role=$role --apply-migrations
