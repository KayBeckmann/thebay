# Bay - Sichere Anzeigenplattform

Eine sichere, privacy-fokussierte Anzeigenplattform mit End-to-End-verschlüsselter Kommunikation, gebaut mit Flutter und Serverpod.

## 🎯 Übersicht

Bay ist eine moderne Kleinanzeigen-Plattform, die Sicherheit und Privatsphäre in den Vordergrund stellt. Benutzer können Angebote erstellen, handeln und sicher kommunizieren - alles mit PGP-verschlüsselten Nachrichten.

## ✨ Features

### Kernsystem
- 🔐 **Sichere Authentifizierung** mit Argon2id Passwort-Hashing
- 🎫 **Slot-basiertes System** für zeitlich begrenzte Anzeigen
- 💰 **Flexible Zahlungen** via PayPal und Bitcoin
- 🔒 **PGP-Verschlüsselte Nachrichten** für sichere Kommunikation

### Marketplace
- 📝 **Angebote erstellen** mit bis zu 3 Bildern
- 🔍 **Volltextsuche** mit Kategorien und Filtern
- ⭐ **Favoriten-System** für interessante Angebote
- 💵 **Multi-Währungs-Support** (USD, EUR, GBP, CHF, BTC)

### Handel & Transaktionen
- 🤝 **Strukturierter Handelsablauf** (Open → Shipped → Received → Completed)
- ⏰ **Automatischer Abschluss** nach 14 Tagen
- 🏆 **Bewertungssystem** (Positiv/Neutral/Negativ)
- 🚨 **Reklamations-/Dispute-System** mit Moderator-Support

### Administration
- 👥 **Rollensystem** (User, Moderator, Admin)
- 📊 **User-Management** mit Ban-Funktionalität
- 🎟️ **Slot-Varianten-Verwaltung** inkl. kostenloser Promotion-Slots
- 📰 **News-System** mit automatischer Ablauf-Verwaltung
- 🚩 **Report-System** für Inhalte und Benutzer

### Sicherheit & Moderation
- 🔐 **PGP Key Management** (RSA 4096 on-device)
- 🛡️ **Report-System** für Listings und User
- 👮 **Moderator-Panel** für Meldungs-Bearbeitung
- 📜 **Ban-System** mit Historie
- ⚡ **Rate Limiting** und Session-Management

## 🛠️ Technologie-Stack

### Frontend
- **Flutter 3.x** - Cross-platform UI Framework
- **Material Design 3** - Modern, responsive UI
- **Serverpod Flutter Client** - Type-safe API communication
- **OpenPGP** - Client-side Verschlüsselung
- **Flutter Secure Storage** - Sichere Schlüssel-Speicherung

### Backend
- **Serverpod 2.9.2** - Full-stack Dart Framework
- **PostgreSQL** - Relationale Datenbank
- **Argon2** - Passwort-Hashing
- **Docker & Docker Compose** - Containerization

### DevOps
- **BorgBackup** - Automatische Backups
- **Nginx** - Reverse Proxy mit SSL/TLS
- **GitHub Actions** - CI/CD (geplant)

## 📁 Projekt-Struktur

```
bay/
├── bay_server/          # Serverpod Backend
│   ├── lib/src/
│   │   ├── endpoints/   # API Endpoints
│   │   ├── models/      # Datenmodelle (.spy.yaml)
│   │   └── services/    # Business Logic Services
│   └── migrations/      # Datenbank-Migrationen
├── bay_flutter/         # Flutter Frontend
│   └── lib/
│       ├── screens/     # UI Screens
│       ├── services/    # Client Services
│       └── widgets/     # Wiederverwendbare Widgets
├── bay_client/          # Generierte Client-Library
├── docker-compose.yml   # Development Setup
├── docker-compose.prod.yaml  # Production Setup
└── backup-scripts/      # Backup-Automatisierung
```

## 🚀 Quick Start

### Voraussetzungen

- Flutter SDK (3.x oder höher)
- Dart SDK (3.x oder höher)
- Serverpod CLI (`dart pub global activate serverpod_cli`)
- Docker & Docker Compose
- PostgreSQL (via Docker)

### Installation

1. **Repository klonen:**
   ```bash
   git clone git@github.com:KayBeckmann/thebay.git
   cd bay
   ```

2. **Umgebungsvariablen konfigurieren:**
   ```bash
   cp .env.example .env
   # Bearbeite .env mit deinen Konfigurationen
   ```

3. **Docker Container starten:**
   ```bash
   docker-compose up -d
   ```

4. **Datenbank-Migrationen ausführen:**
   ```bash
   cd bay_server
   serverpod create-migration
   dart bin/main.dart --apply-migrations
   ```

5. **Backend starten:**
   ```bash
   cd bay_server
   dart bin/main.dart
   ```

6. **Flutter App starten:**
   ```bash
   cd bay_flutter
   flutter pub get
   flutter run
   ```

### Standard-Admin-Account

Nach dem ersten Start wird automatisch ein Admin-Account aus der `.env` erstellt:
- **Username:** Definiert in `.env` (`ADMIN_USERNAME`)
- **Passwort:** Definiert in `.env` (`ADMIN_PASSWORD`)

## 🔧 Entwicklung

### Datenmodelle generieren

Nach Änderungen an `.spy.yaml` Dateien:

```bash
cd bay_server
serverpod generate
```

### Neue Migration erstellen

```bash
cd bay_server
serverpod create-migration
```

### Tests ausführen

```bash
cd bay_server
dart test
```

## 📦 Deployment

### Production Build

1. **Frontend bauen:**
   ```bash
   cd bay_flutter
   flutter build web
   # oder
   flutter build apk --release
   ```

2. **Production Setup starten:**
   ```bash
   docker-compose -f docker-compose.prod.yaml up -d
   ```

3. **SSL/TLS konfigurieren:**
   Siehe `DEPLOYMENT.md` für detaillierte Anweisungen zu Let's Encrypt Setup.

### Backup & Restore

Automatische Backups werden täglich um 2:00 Uhr ausgeführt (via BorgBackup).

**Manuelles Backup:**
```bash
docker exec bay_backup borg create ::manual-{now} /data
```

**Restore:**
```bash
./backup-scripts/restore.sh
```

Details in `backup-scripts/README.md`.

## 📚 Dokumentation

- **Deployment-Guide:** `DEPLOYMENT.md`
- **Backup-Dokumentation:** `backup-scripts/README.md`
- **Roadmap:** `roadmap.md` - Vollständige Feature-Planung und Status
- **API-Dokumentation:** Auto-generiert via Serverpod

## 🗺️ Roadmap

Siehe [roadmap.md](roadmap.md) für den detaillierten Projekt-Fortschritt.

**Abgeschlossene Meilensteine:**
- ✅ Projekt-Setup & Grundstruktur
- ✅ Authentifizierung & Benutzerverwaltung
- ✅ Navigation & UI
- ✅ Kategorien & Admin-Panel
- ✅ Angebote & Bild-Upload
- ✅ Slot-Kauf & Verwaltung
- ✅ Zahlungsintegration (PayPal & Bitcoin)
- ✅ Suche & Favoriten
- ✅ PGP Key Management
- ✅ Verschlüsselte Nachrichten
- ✅ Benutzerprofil & Kontakt
- ✅ Transaktionen & Handel
- ✅ Bewertungssystem
- ✅ Währung & Umrechnung
- ✅ Report-System
- ✅ Moderator-Panel
- ✅ Admin-Benutzerverwaltung
- ✅ Wartungs-Automatisierung
- ✅ Backup-System
- ✅ Testing & Deployment
- ✅ Kostenlose Promotion-Slots

**In Planung:**
- ⏳ Multilingualer Support (i18n)
- 🔜 2FA (Zwei-Faktor-Authentifizierung)
- 🔜 Registrierungsgebühr

## 🤝 Beitragen

Dieses Projekt ist derzeit in privater Entwicklung. Contributions sind willkommen nach Absprache.

## 📄 Lizenz

Alle Rechte vorbehalten - Privates Projekt

## 👤 Autor

**Kay Beckmann**
- GitHub: [@KayBeckmann](https://github.com/KayBeckmann)

## 🙏 Danksagungen

- **Flutter Team** - Fantastisches Cross-Platform Framework
- **Serverpod** - Leistungsstarkes Full-Stack Dart Framework
- **OpenPGP** - Sichere Verschlüsselungs-Library
- **Claude Code** - KI-gestützte Entwicklungsunterstützung

---

🤖 Generiert mit [Claude Code](https://claude.com/claude-code)
