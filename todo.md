# Anzeigenplattform - Projektplanung

## Projektbeschreibung
Eine Anzeigenplattform mit Fokus auf Privatsphäre und Sicherheit.

**Sprache der Anwendung**: Englisch

## Technische Anforderungen

### Frontend
- **Framework**: Flutter
- Plattformübergreifende Anwendung
- **Design**: Material Design
- **Zugriffskontrolle**: Registrierung & Login erforderlich (keine öffentliche Ansicht)

### Backend
- **Sprache**: Dart
- SQL Datenbank Anbindung

### Infrastructure
- Alle Dienste laufen in eigenen Docker Containern
- Konfiguration über .env-Datei:
  - Container-Ports (Frontend, Backend, Datenbank)
  - Frontend-URL
  - Admin-Zugangsdaten (Benutzername, Passwort)

## Funktionale Anforderungen

### Authentifizierung
- Benutzer-Anmeldung mit:
  - Benutzername
  - Passwort
- **KEINE** Email-Adressen erfassen
- **Admin-Konto**:
  - Wird beim ersten Start automatisch angelegt
  - Zugangsdaten aus .env-Datei (ADMIN_USERNAME, ADMIN_PASSWORD)
- **Registrierungsgebühr** (optional, für spätere Erweiterung):
  - Admin kann Preis für Registrierung festlegen
  - Zahlung muss erfolgen, bevor Account freigeschaltet wird

### Verschlüsselte Kommunikation
- PGP-Verschlüsselung für Kommunikation zwischen Benutzern
- Private Key Management:
  - Private Key wird auf dem Endgerät erzeugt und verwaltet
  - Optional: Verschlüsselter Upload des Private Keys auf den Server
    - **Sicherheitswarnung** muss vor Upload angezeigt werden
  - Download des Private Keys auf neuen Geräten möglich
  - Export-Funktion für Private Key
  - Import-Funktion für Private Key

### Angebote & Slots
- Jedes Angebot benötigt einen Slot
- Verkäufer können Slots kaufen
- Slot-Varianten (vom Admin konfigurierbar):
  - Preis pro Slot
  - Laufzeit (z.B. 3 Tage, 7 Tage, 14 Tage, 30 Tage)
  - Mehrere Varianten können parallel angeboten werden
- Nach Ablauf der Laufzeit wird das Angebot deaktiviert
- **Bilder**:
  - Bis zu 3 Bilder pro Angebot (direkter Upload, keine URLs)
  - Erstes Bild wird als Mini-Preview in der Übersicht angezeigt
  - Bildergalerie in der Detailansicht

### Kategorien
- Hierarchische Struktur: Kategorien und Subkategorien
- Verwaltung durch Admin im Admin-Panel

### Bewertungssystem
- Bewertung nach abgeschlossenem Handel
- Käufer und Verkäufer können sich gegenseitig bewerten
- Bewertungsoptionen:
  - Gut (positiv)
  - Neutral
  - Schlecht (negativ)

### Navigation / Menü
- Dashboard / Startseite
- Nachrichten
- Suchen
- Verkaufen
- Einstellungen
- Admin-Panel (nur für Admin sichtbar)

### Suchfunktion
- Volltextsuche
- Filter:
  - Kategorie
  - Subkategorie
  - Bezahlart (PayPal, Bitcoin)

### Zahlungsabwicklung
- Direktzahlung: Käufer zahlt direkt an den Verkäufer
- Unterstützte Zahlungsmethoden:
  - PayPal
  - Bitcoin
- Plattform wickelt keine Zahlungen ab (kein Treuhand/Escrow)
- Zahlungsinformationen im Nutzerprofil:
  - PayPal-Adresse (optional)
  - Bitcoin-Wallet-Adresse (optional)
  - Zahlungsinformationen werden erst nach Kontaktaufnahme sichtbar (Spam-Schutz)
  - Verkäufer kann wählen, welche Zahlungsmethoden er akzeptiert

### Admin-Panel
- Slot-Verwaltung:
  - Slot-Varianten erstellen/bearbeiten/löschen
  - Preis und Laufzeit festlegen
- Kategorie-Verwaltung:
  - Kategorien erstellen/bearbeiten/löschen
  - Subkategorien erstellen/bearbeiten/löschen
- Benutzer-Verwaltung (optional, für spätere Erweiterung)

## Offene Punkte
(Weitere Anforderungen folgen)

---
*Erstellt am: 2025-12-09*
