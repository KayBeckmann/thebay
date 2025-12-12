# Bay Flutter Web Frontend Dockerfile
# Multi-stage build for optimized production image
# NOTE: Build context must be the project root (not bay_flutter)

# =============================================================================
# Build Stage - Flutter Web
# =============================================================================
FROM debian:bookworm-slim AS build

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter (using stable channel for best compatibility)
ENV FLUTTER_HOME=/opt/flutter
ENV PATH="${FLUTTER_HOME}/bin:${PATH}"

RUN git clone https://github.com/flutter/flutter.git ${FLUTTER_HOME} \
    && cd ${FLUTTER_HOME} \
    && git checkout stable \
    && flutter doctor \
    && flutter config --enable-web

WORKDIR /app

# Copy bay_client first (dependency)
COPY bay_client /app/bay_client

# Copy bay_flutter
COPY bay_flutter /app/bay_flutter

WORKDIR /app/bay_flutter

# Get dependencies
RUN flutter pub get

# Build web release with server URL
ARG SERVER_URL=http://localhost:8080/
RUN flutter build web --release --dart-define=SERVER_URL=${SERVER_URL}

# =============================================================================
# Production Stage - Nginx
# =============================================================================
FROM nginx:alpine

# Copy nginx configuration
COPY bay_flutter/nginx.conf /etc/nginx/nginx.conf

# Copy built web app
COPY --from=build /app/bay_flutter/build/web /usr/share/nginx/html

# Add health check script
RUN apk add --no-cache wget

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:80/ || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
