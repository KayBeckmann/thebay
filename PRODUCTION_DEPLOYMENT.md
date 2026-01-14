# Production Deployment Anleitung

## Voraussetzungen
Du hast auf dem Server bereits Container laufen. Jetzt müssen die Fixes übertragen und neu deployed werden.

## Schritt 1: Code auf den Server übertragen

### Option A: Mit Git (empfohlen)
Auf deinem **lokalen Rechner**:
```bash
# Änderungen committen
git add bay_server/Dockerfile bay_server/docker-entrypoint.sh
git commit -m "fix: Update Serverpod Dockerfile for production compatibility

- Switch from Alpine to Debian-based image for glibc compatibility
- Add entrypoint script to generate passwords.yaml from environment variables
- Dynamically configure production.yaml with correct database settings

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

# Zum Repository pushen
git push
```

Auf dem **Server** (SSH einloggen):
```bash
cd /home/kay/thebay  # Oder wo auch immer dein Projekt liegt
git pull
```

### Option B: Mit rsync
Falls kein Git-Repository vorhanden:
```bash
# Von deinem lokalen Rechner aus
rsync -avz bay_server/Dockerfile kay@SERVER_IP:/home/kay/thebay/bay_server/
rsync -avz bay_server/docker-entrypoint.sh kay@SERVER_IP:/home/kay/thebay/bay_server/
```

## Schritt 2: Environment-Datei überprüfen

Auf dem **Server**:
```bash
cd /home/kay/thebay

# Stelle sicher, dass die .env Datei die richtigen Production-Werte hat
# Falls du .env.production verwendest, benenne sie um:
cp .env.production .env

# ODER verwende --env-file beim docker-compose Befehl (siehe Schritt 3)
```

**WICHTIG**: Die Passwörter in der `.env` müssen mit denen in der Datenbank übereinstimmen!

## Schritt 3: Container neu bauen und starten

Auf dem **Server**:
```bash
cd /home/kay/thebay

# Container stoppen
docker-compose -f docker-compose.prod.yaml down

# Serverpod-Image neu bauen (zwingt Neuaufbau)
docker-compose -f docker-compose.prod.yaml build --no-cache serverpod

# OPTION 1: Mit .env Datei starten
docker-compose -f docker-compose.prod.yaml up -d

# OPTION 2: Mit spezifischer env-Datei starten
docker-compose -f docker-compose.prod.yaml --env-file .env.production up -d
```

## Schritt 4: Status überprüfen

```bash
# Container-Status überprüfen
docker ps

# Der bay_serverpod Container sollte jetzt "Up" sein, nicht "Restarting"
```

## Schritt 5: Logs überprüfen

```bash
# Serverpod-Logs in Echtzeit anzeigen
docker logs -f bay_serverpod

# Du solltest sehen:
# === Serverpod Container Startup ===
# Generating configuration from environment variables...
# ✓ Generated passwords.yaml
# ✓ Updated database name to: baywoaegvbwope4tfgw
# ✓ Updated database user to: postgres
# === Configuration complete, starting server ===
```

Wenn der Server erfolgreich startet, solltest du sehen:
- Datenbank-Migrationen werden angewendet
- Server lauscht auf Port 8080, 8081, 8082
- Keine Fehler über fehlende Passwörter oder Verbindungsfehler

## Schritt 6: Anwendung testen

```bash
# API Health-Check
curl http://10.10.2.94/health

# Sollte zurückgeben: "healthy"
```

Dann im Browser öffnen: `http://10.10.2.94/`

## Problembehebung

### Container startet immer noch nicht?

**Logs mit mehr Details anzeigen:**
```bash
docker logs bay_serverpod --tail 200
```

**Häufige Probleme:**

1. **"Connection refused" zu Postgres/Redis**
   - Überprüfe, ob postgres und redis Container healthy sind:
     ```bash
     docker ps
     ```
   - Beide sollten "(healthy)" im STATUS haben

2. **"Authentication failed"**
   - Passwörter in `.env` stimmen nicht mit DB überein
   - Lösung: Entweder DB-Passwort zurücksetzen oder .env anpassen

3. **"Database does not exist"**
   - Datenbank-Name in `.env` überprüfen
   - Postgres-Container neu initialisieren (ACHTUNG: Löscht Daten!):
     ```bash
     docker-compose -f docker-compose.prod.yaml down -v
     docker-compose -f docker-compose.prod.yaml up -d
     ```

### Alle Container neu starten

```bash
docker-compose -f docker-compose.prod.yaml restart
```

### Kompletter Neustart (ACHTUNG: Löscht Daten!)

```bash
docker-compose -f docker-compose.prod.yaml down -v
docker-compose -f docker-compose.prod.yaml up -d
```

## Service Worker Warnung

Die Warnung "Service Worker API unavailable" ist normal für HTTP (nicht HTTPS).

**Für Produktion empfohlen:**
- HTTPS mit Let's Encrypt einrichten
- Siehe: `docs/ssl-setup.md` (falls vorhanden)

## Nächste Schritte für eine sichere Produktion

1. **HTTPS einrichten** (Let's Encrypt mit Certbot)
2. **Firewall konfigurieren** (nur Port 80/443 öffnen)
3. **Monitoring einrichten** (z.B. Uptime monitoring)
4. **Backups testen** (sind bereits konfiguriert)
5. **Log-Rotation einrichten**

## Support

Bei weiteren Problemen, bitte die Logs mit diesem Befehl sammeln:
```bash
docker logs bay_serverpod > serverpod.log 2>&1
docker logs bay_nginx > nginx.log 2>&1
docker logs bay_postgres > postgres.log 2>&1
```
