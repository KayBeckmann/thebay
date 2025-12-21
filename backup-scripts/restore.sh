#!/bin/bash
set -e

# Restore script for Bay platform
# Restores data from BorgBackup archives

# Configuration
BORG_REPO="${BORG_REPO:-/backups/repo}"
RESTORE_DIR="/tmp/restore"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
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

log_prompt() {
    echo -e "${BLUE}[PROMPT]${NC} $1"
}

# Check if repository exists
if [ ! -d "$BORG_REPO" ]; then
    log_error "Borg repository not found at $BORG_REPO"
    exit 1
fi

# List available backups
log_info "Available backups in repository:"
borg list "$BORG_REPO"

# Get backup name
if [ -z "$1" ]; then
    log_prompt "Please specify which backup to restore:"
    log_prompt "Usage: $0 <backup-name>"
    log_prompt "Example: $0 bay-2025-12-21-120000"
    exit 1
fi

BACKUP_NAME="$1"

# Verify backup exists
borg list "$BORG_REPO" | grep -q "$BACKUP_NAME"
if [ $? -ne 0 ]; then
    log_error "Backup '$BACKUP_NAME' not found in repository"
    exit 1
fi

# Warning
log_warn "========================================"
log_warn "WARNING: This will restore data from backup!"
log_warn "Backup: $BACKUP_NAME"
log_warn "========================================"
log_prompt "Do you want to continue? (yes/no)"
read -r confirmation

if [ "$confirmation" != "yes" ]; then
    log_info "Restore cancelled"
    exit 0
fi

# Create restore directory
log_info "Creating restore directory..."
mkdir -p "$RESTORE_DIR"
cd "$RESTORE_DIR"

# Extract backup
log_info "Extracting backup archive..."
borg extract "$BORG_REPO::$BACKUP_NAME"

if [ $? -ne 0 ]; then
    log_error "Failed to extract backup"
    exit 1
fi

log_info "Backup extracted successfully"

# Show metadata
if [ -f "$RESTORE_DIR/tmp/backup/metadata.json" ]; then
    log_info "Backup metadata:"
    cat "$RESTORE_DIR/tmp/backup/metadata.json"
fi

# Restore PostgreSQL
log_info "========================================"
log_prompt "Restore PostgreSQL database? (yes/no)"
read -r restore_postgres

if [ "$restore_postgres" = "yes" ]; then
    log_warn "This will DROP and recreate the database!"
    log_prompt "Are you sure? (yes/no)"
    read -r confirm_postgres

    if [ "$confirm_postgres" = "yes" ]; then
        log_info "Restoring PostgreSQL database..."

        # Drop and recreate database
        PGPASSWORD="$POSTGRES_PASSWORD" psql -h postgres -U "${POSTGRES_USER:-postgres}" -c "DROP DATABASE IF EXISTS ${POSTGRES_DB:-bay};"
        PGPASSWORD="$POSTGRES_PASSWORD" psql -h postgres -U "${POSTGRES_USER:-postgres}" -c "CREATE DATABASE ${POSTGRES_DB:-bay};"

        # Restore from backup
        PGPASSWORD="$POSTGRES_PASSWORD" pg_restore \
            -h postgres \
            -U "${POSTGRES_USER:-postgres}" \
            -d "${POSTGRES_DB:-bay}" \
            -F c \
            "$RESTORE_DIR/tmp/backup/postgres_dump.backup"

        if [ $? -eq 0 ]; then
            log_info "PostgreSQL database restored successfully"
        else
            log_error "PostgreSQL restore failed"
        fi
    else
        log_info "PostgreSQL restore skipped"
    fi
else
    log_info "PostgreSQL restore skipped"
fi

# Restore uploads
log_info "========================================"
log_prompt "Restore uploads directory? (yes/no)"
read -r restore_uploads

if [ "$restore_uploads" = "yes" ]; then
    if [ -d "$RESTORE_DIR/tmp/backup/uploads" ]; then
        log_info "Restoring uploads..."

        # Backup current uploads first
        if [ -d "/app/uploads" ]; then
            log_info "Backing up current uploads to /app/uploads.backup..."
            mv /app/uploads /app/uploads.backup.$(date +%s)
        fi

        # Restore uploads
        cp -r "$RESTORE_DIR/tmp/backup/uploads" /app/uploads
        log_info "Uploads restored successfully"
    else
        log_warn "No uploads found in backup"
    fi
else
    log_info "Uploads restore skipped"
fi

# Cleanup
log_info "Cleaning up restore directory..."
cd /
rm -rf "$RESTORE_DIR"

log_info "========================================"
log_info "Restore completed!"
log_info "========================================"
log_warn "Don't forget to restart the application services if needed"
