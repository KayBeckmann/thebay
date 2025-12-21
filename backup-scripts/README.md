# Bay Platform - Backup System

Automated backup system using BorgBackup for the Bay platform.

## Features

- **Automated Backups**: Daily backups at 2:00 AM
- **Deduplication**: BorgBackup uses deduplication to save space
- **Encryption**: All backups are encrypted with a passphrase
- **Compression**: LZ4 compression for faster backups
- **Retention Policy**:
  - Daily backups: 7 days
  - Weekly backups: 4 weeks
  - Monthly backups: 6 months

## What is Backed Up

1. **PostgreSQL Database** - Full database dump
2. **Uploads Directory** - All user-uploaded files (images, etc.)
3. **Metadata** - Backup information and statistics

## Setup

### 1. Configure Environment Variables

Add to your `.env` file:

```bash
# Borg backup passphrase (IMPORTANT: Change this to a strong passphrase!)
BORG_PASSPHRASE=your-strong-passphrase-here
```

**IMPORTANT**: Store this passphrase securely! You will need it to restore backups.

### 2. Start Backup Container

```bash
docker compose up -d backup
```

### 3. Initialize Repository (First Time Only)

The repository is automatically initialized on first backup run.

### 4. Export Repository Key

After the first backup, export the repository key:

```bash
docker exec bay_backup cat /backups/borg-repo-key.txt > borg-repo-key.txt
```

**CRITICAL**: Store this key file in a safe location outside of the server! You will need it for disaster recovery.

## Manual Operations

### Run Manual Backup

```bash
docker exec bay_backup /backup-scripts/backup.sh
```

### List Available Backups

```bash
docker exec bay_backup borg list /backups/repo
```

### View Backup Information

```bash
docker exec bay_backup borg info /backups/repo::bay-2025-12-21-120000
```

Replace `bay-2025-12-21-120000` with the actual backup name.

### Check Backup Logs

```bash
docker exec bay_backup tail -f /var/log/backup.log
```

## Restore Operations

### Full Restore

1. Stop the application (optional but recommended):
   ```bash
   docker compose stop serverpod
   ```

2. Run the restore script:
   ```bash
   docker exec -it bay_backup /backup-scripts/restore.sh bay-2025-12-21-120000
   ```

3. Follow the interactive prompts to restore:
   - PostgreSQL database
   - Uploads directory

4. Restart the application:
   ```bash
   docker compose start serverpod
   ```

### Restore Only Database

```bash
# Extract backup
docker exec bay_backup borg extract /backups/repo::bay-2025-12-21-120000

# Restore database manually
docker exec -i bay_postgres pg_restore \
    -U postgres \
    -d bay \
    -c \
    < /path/to/extracted/postgres_dump.backup
```

### Restore Only Uploads

```bash
# Extract backup
docker exec bay_backup borg extract /backups/repo::bay-2025-12-21-120000

# Copy uploads
docker cp bay_backup:/tmp/restore/tmp/backup/uploads ./uploads_restored
```

## External Backup Storage

For production, mount the backup volume to external storage:

### Option 1: NFS Mount

```yaml
volumes:
  bay_backups:
    driver: local
    driver_opts:
      type: nfs
      o: addr=192.168.1.100,rw
      device: ":/backups/bay"
```

### Option 2: Cloud Storage (e.g., AWS S3)

Use tools like `rclone` to sync `/backups` to cloud storage:

```bash
# In another container or cron job
rclone sync /backups remote:bay-backups
```

### Option 3: External Disk

```yaml
volumes:
  bay_backups:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /mnt/external-disk/bay-backups
```

## Backup Schedule

Default schedule (configured in `crontab`):

- **Daily**: 2:00 AM

To change the schedule, edit `backup-scripts/crontab` and rebuild:

```bash
docker compose up -d --build backup
```

## Retention Policy

Configured in `backup.sh`:

```bash
borg prune \
    --keep-daily=7 \
    --keep-weekly=4 \
    --keep-monthly=6 \
    "$BORG_REPO"
```

Customize as needed for your requirements.

## Monitoring

### Check Last Backup

```bash
docker exec bay_backup borg list /backups/repo | tail -1
```

### Verify Backup Integrity

```bash
docker exec bay_backup borg check /backups/repo
```

### Backup Size

```bash
docker exec bay_backup borg info /backups/repo | grep "Original size"
```

## Disaster Recovery

In case of complete server failure:

1. **Restore the Borg repository** from external storage
2. **Import the repository key**:
   ```bash
   borg key import /backups/repo /path/to/borg-repo-key.txt
   ```
3. **Set the passphrase**:
   ```bash
   export BORG_PASSPHRASE=your-passphrase
   ```
4. **List and restore backups** as described above

## Troubleshooting

### "Repository already exists" Error

This is normal if the repository was already initialized.

### "Failed to create lock" Error

Another backup might be running. Wait for it to finish or:

```bash
docker exec bay_backup borg break-lock /backups/repo
```

### Disk Space Issues

Check backup repository size:

```bash
docker exec bay_backup du -sh /backups
```

Adjust retention policy if needed.

### Cron Not Running

Check cron status:

```bash
docker exec bay_backup ps aux | grep crond
```

View cron logs:

```bash
docker logs bay_backup
```

## Security Notes

- **Encryption Passphrase**: Never commit the passphrase to version control
- **Repository Key**: Store the exported key in a secure location (password manager, safe, etc.)
- **Access Control**: Limit access to the backup container and volumes
- **External Storage**: Use encrypted external storage for production backups

## Support

For issues or questions, consult the BorgBackup documentation:
https://borgbackup.readthedocs.io/
