# Dockerfile for BorgBackup container
FROM alpine:3.19

# Install required packages
RUN apk add --no-cache \
    borgbackup \
    postgresql16-client \
    bash \
    tzdata \
    ca-certificates

# Set timezone
ENV TZ=Europe/Berlin

# Create directories
RUN mkdir -p /backups /app/uploads /backup-scripts

# Copy backup scripts and crontab
COPY backup.sh /backup-scripts/backup.sh
COPY restore.sh /backup-scripts/restore.sh
COPY crontab /backup-scripts/crontab

# Make scripts executable
RUN chmod +x /backup-scripts/*.sh

# Set working directory
WORKDIR /backup-scripts

# Default command (can be overridden)
CMD ["tail", "-f", "/dev/null"]
