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

# Final stage - Use Debian-based image for glibc compatibility
FROM debian:bookworm-slim

# Environment variables
ENV runmode=production
ENV serverid=default
ENV logging=normal
ENV role=monolith
ENV apply_migrations=true

# Install runtime dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy compiled server executable
COPY --from=build /app/bin/server server

# Copy configuration files and resources
COPY --from=build /app/config/ config/
COPY --from=build /app/web/ web/
COPY --from=build /app/migrations/ migrations/

# Copy entrypoint script
COPY docker-entrypoint.sh /app/docker-entrypoint.sh
RUN chmod +x /app/docker-entrypoint.sh

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
ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["--mode=production", "--server-id=default", "--logging=normal", "--role=monolith", "--apply-migrations"]
