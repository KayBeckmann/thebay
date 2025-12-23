# Bay Platform - Production Deployment Guide

Complete guide for deploying the Bay platform to production.

## Prerequisites

- Server with at least 2 GB RAM, 2 CPU cores, 20 GB storage
- Ubuntu 22.04 LTS or similar Linux distribution
- Docker and Docker Compose installed
- Domain name pointing to your server's IP address

## Pre-Deployment Checklist

### 1. Server Preparation

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Install Docker Compose
sudo apt install docker-compose-plugin -y

# Add your user to docker group
sudo usermod -aG docker $USER
newgrp docker
```

### 2. Clone Repository

```bash
git clone <your-repository-url> bay
cd bay
```

### 3. Environment Configuration

Create `.env.production` file:

```bash
cp .env.example .env.production
```

Edit `.env.production` with production values:

```bash
# Database
POSTGRES_USER=postgres
POSTGRES_DB=bay
POSTGRES_PASSWORD=<generate-strong-password>
POSTGRES_HOST_PORT=8090

# Redis
REDIS_PASSWORD=<generate-strong-password>
REDIS_HOST_PORT=8091

# Serverpod
SERVERPOD_SERVICE_SECRET=<generate-strong-secret>
ADMIN_USERNAME=admin
ADMIN_PASSWORD=<generate-strong-password>

# Backup
BORG_PASSPHRASE=<generate-strong-passphrase>
BACKUP_PATH=/mnt/backups  # External storage path

# Ports (optional, defaults shown)
SERVERPOD_API_PORT=8080
SERVERPOD_INSIGHTS_PORT=8081
SERVERPOD_WEB_PORT=8082
FRONTEND_PORT=80
```

**IMPORTANT**: Generate strong passwords and secrets:
```bash
# Generate secure random passwords
openssl rand -base64 32
```

### 4. SSL Certificate Setup

#### Option A: Let's Encrypt (Recommended)

```bash
# Install Certbot
sudo apt install certbot -y

# Get certificate (stop nginx first if running)
sudo certbot certonly --standalone -d your-domain.com -d www.your-domain.com

# Copy certificates to nginx directory
sudo cp /etc/letsencrypt/live/your-domain.com/fullchain.pem nginx/ssl/
sudo cp /etc/letsencrypt/live/your-domain.com/privkey.pem nginx/ssl/
sudo chmod 644 nginx/ssl/*.pem
```

Set up auto-renewal:
```bash
# Add to crontab
0 0 1 * * certbot renew --quiet && docker compose -f docker-compose.prod.yaml restart nginx
```

#### Option B: Self-Signed Certificate (Development/Testing)

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout nginx/ssl/privkey.pem \
    -out nginx/ssl/fullchain.pem \
    -subj "/C=US/ST=State/L=City/O=Organization/CN=your-domain.com"
```

### 5. Configure Nginx

Edit `nginx/conf.d/bay.conf`:
```nginx
# Replace 'your-domain.com' with your actual domain
server_name your-domain.com www.your-domain.com;
```

### 6. External Backup Storage

Mount external storage for backups:

```bash
# Example: Mount external disk
sudo mkdir -p /mnt/backups
sudo mount /dev/sdb1 /mnt/backups

# Add to /etc/fstab for persistent mount
/dev/sdb1 /mnt/backups ext4 defaults 0 2
```

Update `.env.production`:
```bash
BACKUP_PATH=/mnt/backups
```

## Deployment Steps

### 1. Build and Start Services

```bash
# Use production compose file
docker compose -f docker-compose.prod.yaml build

# Start all services
docker compose -f docker-compose.prod.yaml up -d

# Check status
docker compose -f docker-compose.prod.yaml ps
```

### 2. Verify Services

```bash
# Check logs
docker compose -f docker-compose.prod.yaml logs -f

# Verify health
docker compose -f docker-compose.prod.yaml ps

# Test API
curl https://your-domain.com/api/health

# Test frontend
curl https://your-domain.com/
```

### 3. Database Migrations

Migrations run automatically on startup. To run manually:

```bash
docker exec bay_serverpod ./server --apply-migrations
```

### 4. Create Admin Account

The admin account is created automatically from environment variables on first startup.

Login credentials:
- Username: Value of `ADMIN_USERNAME` (default: admin)
- Password: Value of `ADMIN_PASSWORD`

### 5. Test Backup System

```bash
# Run manual backup
docker exec bay_backup /backup-scripts/backup.sh

# List backups
docker exec bay_backup borg list /backups/repo

# Export repository key (IMPORTANT!)
docker exec bay_backup cat /backups/borg-repo-key.txt > borg-repo-key-backup.txt

# Store this file safely offline!
```

## Post-Deployment

### Security Hardening

1. **Firewall Configuration**:
```bash
# Allow HTTP/HTTPS only
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
```

2. **Fail2Ban** (Optional):
```bash
sudo apt install fail2ban -y
```

3. **Regular Updates**:
```bash
# Add to crontab for weekly updates
0 2 * * 0 cd /path/to/bay && docker compose -f docker-compose.prod.yaml pull && docker compose -f docker-compose.prod.yaml up -d
```

### Monitoring

1. **Check Logs**:
```bash
# All services
docker compose -f docker-compose.prod.yaml logs -f

# Specific service
docker logs bay_serverpod -f
```

2. **Monitor Resources**:
```bash
docker stats
```

3. **Backup Monitoring**:
```bash
# Check last backup
docker exec bay_backup borg list /backups/repo | tail -1

# Check backup logs
docker exec bay_backup tail -f /var/log/backup.log
```

### Performance Optimization

1. **Database Tuning**:
   - Adjust `config/postgresql.conf` based on server resources
   - Run `ANALYZE` and `VACUUM` regularly

2. **Redis Cache**:
   - Monitor memory usage
   - Adjust maxmemory in `docker-compose.prod.yaml`

3. **Nginx Caching**:
   - Tune cache settings in `nginx/nginx.conf`
   - Monitor cache hit rate

## Maintenance

### Regular Tasks

**Daily**:
- Check service health
- Monitor disk space
- Review error logs

**Weekly**:
- Verify backup completion
- Check security updates
- Review access logs

**Monthly**:
- Test backup restore
- Review user activity
- Update dependencies

### Common Operations

**Restart Services**:
```bash
docker compose -f docker-compose.prod.yaml restart
```

**Update Application**:
```bash
git pull
docker compose -f docker-compose.prod.yaml build
docker compose -f docker-compose.prod.yaml up -d
```

**Scale Services** (if needed):
```bash
docker compose -f docker-compose.prod.yaml up -d --scale serverpod=3
```

**View Resource Usage**:
```bash
docker stats --no-stream
```

## Disaster Recovery

### Full System Restore

1. **Restore from Backup**:
```bash
# List available backups
docker exec bay_backup borg list /backups/repo

# Run restore script
docker exec -it bay_backup /backup-scripts/restore.sh <backup-name>
```

2. **Rebuild Services**:
```bash
docker compose -f docker-compose.prod.yaml up -d --force-recreate
```

### Database-Only Restore

```bash
# Extract database from backup
docker exec bay_backup borg extract /backups/repo::<backup-name>

# Restore to PostgreSQL
docker exec -i bay_postgres pg_restore \
    -U postgres \
    -d bay \
    -c \
    < /path/to/extracted/postgres_dump.backup
```

## Troubleshooting

### Service Won't Start

```bash
# Check logs
docker compose -f docker-compose.prod.yaml logs <service-name>

# Check health
docker inspect bay_<service-name> | grep Health
```

### Database Connection Issues

```bash
# Test from serverpod container
docker exec bay_serverpod ping postgres

# Check PostgreSQL logs
docker logs bay_postgres
```

### SSL Certificate Issues

```bash
# Verify certificate
openssl s_client -connect your-domain.com:443 -showcerts

# Renew Let's Encrypt
sudo certbot renew --force-renewal
docker compose -f docker-compose.prod.yaml restart nginx
```

### Backup Failures

```bash
# Check backup logs
docker exec bay_backup tail -100 /var/log/backup.log

# Test manual backup
docker exec bay_backup /backup-scripts/backup.sh

# Verify repository
docker exec bay_backup borg check /backups/repo
```

## Support & Documentation

- **Serverpod Docs**: https://docs.serverpod.dev
- **BorgBackup Docs**: https://borgbackup.readthedocs.io
- **Nginx Docs**: https://nginx.org/en/docs/

## Security Notice

- Keep all passwords and secrets secure
- Regularly update all components
- Monitor access logs for suspicious activity
- Use strong, unique passwords for all accounts
- Enable 2FA for admin accounts (future enhancement)
- Regular security audits recommended

---

Last Updated: 2025-12-21
