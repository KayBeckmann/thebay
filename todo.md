# Anzeigenplattform - Projektplanung

## Projektbeschreibung
Eine Anzeigenplattform mit Fokus auf Privatsphäre und Sicherheit.

## Technische Anforderungen

### Frontend
- **Framework**: Flutter
- Plattformübergreifende Anwendung

### Backend
- **Sprache**: Dart
- SQL Datenbank Anbindung

### Infrastructure
- Alle Dienste laufen in eigenen Docker Containern

## Funktionale Anforderungen

### Authentifizierung
- Benutzer-Anmeldung mit:
  - Benutzername
  - Passwort
- **KEINE** Email-Adressen erfassen

### Verschlüsselte Kommunikation
- PGP-Verschlüsselung für Kommunikation zwischen Benutzern
- Private Key Management:
  - Private Key wird auf dem Endgerät erzeugt und verwaltet
  - Optional: Verschlüsselter Upload des Private Keys auf den Server
    - **Sicherheitswarnung** muss vor Upload angezeigt werden
  - Download des Private Keys auf neuen Geräten möglich
  - Export-Funktion für Private Key
  - Import-Funktion für Private Key

## Offene Punkte
(Weitere Anforderungen folgen)

---
*Erstellt am: 2025-12-09*
