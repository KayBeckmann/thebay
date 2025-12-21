#!/bin/bash
set -e

# Backup script for Bay platform
# Uses BorgBackup for deduplicated, encrypted backups

# Configuration
BORG_REPO="${BORG_REPO:-/backups/repo}"
BACKUP_NAME="bay-$(date +%Y-%m-%d-%H%M%S)"
TEMP_DIR="/tmp/backup"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Initialize backup directory
log_info "Initializing backup: $BACKUP_NAME"
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR"

# 1. Backup PostgreSQL database
log_info "Backing up PostgreSQL database..."
PGPASSWORD="$POSTGRES_PASSWORD" pg_dump \
    -h postgres \
    -U "${POSTGRES_USER:-postgres}" \
    -d "${POSTGRES_DB:-bay}" \
    -F c \
    -f postgres_dump.backup

if [ $? -eq 0 ]; then
    log_info "PostgreSQL backup completed: $(du -h postgres_dump.backup | cut -f1)"
else
    log_error "PostgreSQL backup failed"
    exit 1
fi

# 2. Backup Redis data (if needed - optional since Redis is cache)
log_info "Redis data is cache and not backed up (can be regenerated)"

# 3. Copy uploads directory
log_info "Backing up uploads directory..."
if [ -d "/app/uploads" ] && [ "$(ls -A /app/uploads)" ]; then
    cp -r /app/uploads ./uploads
    log_info "Uploads backup completed: $(du -sh uploads | cut -f1)"
else
    log_warn "No uploads directory found or it's empty"
    mkdir -p ./uploads
fi

# 4. Create backup metadata
log_info "Creating backup metadata..."
cat > metadata.json <<EOF
{
  "backup_name": "$BACKUP_NAME",
  "timestamp": "$(date -Iseconds)",
  "hostname": "$(hostname)",
  "postgres_version": "$(PGPASSWORD=$POSTGRES_PASSWORD psql -h postgres -U ${POSTGRES_USER:-postgres} -d ${POSTGRES_DB:-bay} -t -c 'SELECT version();' | head -n1 | xargs)",
  "files": {
    "postgres_dump": "$(stat -c%s postgres_dump.backup 2>/dev/null || echo 0) bytes",
    "uploads_count": "$(find uploads -type f 2>/dev/null | wc -l) files"
  }
}
EOF

log_info "Backup metadata created"

# 5. Create Borg backup
log_info "Creating Borg archive..."

# Initialize repository if it doesn't exist
if [ ! -d "$BORG_REPO" ]; then
    log_info "Initializing Borg repository..."
    borg init --encryption=repokey "$BORG_REPO"
    log_info "Borg repository initialized"
fi

# Create the backup archive
borg create \
    --stats \
    --progress \
    --compression lz4 \
    "$BORG_REPO::$BACKUP_NAME" \
    "$TEMP_DIR"

if [ $? -eq 0 ]; then
    log_info "Borg backup created successfully"
else
    log_error "Borg backup failed"
    exit 1
fi

# 6. Prune old backups (retention policy)
log_info "Pruning old backups..."
borg prune \
    --list \
    --keep-daily=7 \
    --keep-weekly=4 \
    --keep-monthly=6 \
    "$BORG_REPO"

if [ $? -eq 0 ]; then
    log_info "Backup pruning completed"
else
    log_warn "Backup pruning had issues"
fi

# 7. Cleanup temporary files
log_info "Cleaning up temporary files..."
cd /
rm -rf "$TEMP_DIR"

# 8. Show backup info
log_info "Backup completed successfully!"
log_info "Listing recent backups:"
borg list "$BORG_REPO" | tail -5

# Export repository key info (important for disaster recovery)
if [ ! -f "/backups/BORG_KEY_EXPORTED" ]; then
    log_warn "Exporting Borg repository key (DO THIS ONCE AND STORE SAFELY!)..."
    borg key export "$BORG_REPO" /backups/borg-repo-key.txt
    touch /backups/BORG_KEY_EXPORTED
    log_warn "Repository key exported to /backups/borg-repo-key.txt"
    log_warn "IMPORTANT: Store this key in a safe location outside of the backup server!"
fi

log_info "All done!"
