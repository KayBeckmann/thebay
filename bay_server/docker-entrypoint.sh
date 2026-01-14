#!/bin/bash
set -e

echo "=== Serverpod Container Startup ==="
echo "Generating configuration from environment variables..."

# Generate passwords.yaml from environment variables at runtime
cat > /app/config/passwords.yaml <<EOF
# Auto-generated passwords from environment variables
# Do not edit manually - this file is regenerated on container start

shared: {}

production:
  database: '${POSTGRES_PASSWORD}'
  redis: '${REDIS_PASSWORD}'
  serviceSecret: '${SERVERPOD_SERVICE_SECRET}'
EOF

echo "✓ Generated passwords.yaml"

# Update production.yaml with environment-specific database configuration
# Use sed to replace hardcoded values with environment variables
if [ -f /app/config/production.yaml ]; then
  # Update database name if POSTGRES_DB is set
  if [ ! -z "$POSTGRES_DB" ]; then
    sed -i "s/name: bay/name: ${POSTGRES_DB}/" /app/config/production.yaml
    echo "✓ Updated database name to: ${POSTGRES_DB}"
  fi

  # Update database user if POSTGRES_USER is set
  if [ ! -z "$POSTGRES_USER" ]; then
    sed -i "s/user: postgres/user: ${POSTGRES_USER}/" /app/config/production.yaml
    echo "✓ Updated database user to: ${POSTGRES_USER}"
  fi
fi

echo "=== Configuration complete, starting server ==="
echo ""

# Execute the server with all provided arguments
exec ./server "$@"
