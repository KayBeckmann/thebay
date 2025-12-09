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
- **Framework**: Serverpod (Dart)
- Vorteile:
  - Full-Stack Framework für Flutter
  - Eingebaute ORM für SQL-Datenbanken
  - Session-Management
  - WebSocket-Support für Echtzeit-Nachrichten
  - Automatische API-Generierung
  - Code-Sharing mit Frontend (Models)

### Datenbank
- **PostgreSQL**
- **Backup**:
  - BorgBackup als Cron-Job
  - Option für externes Backup-Ziel (externes Gerät/Server)

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
- **Passwort-Sicherheit**:
  - Hashing mit Argon2id
  - Mindestanforderungen: 8 Zeichen, Groß- & Kleinbuchstaben, Ziffern
- **Rate Limiting (Login)**:
  - 3 Fehlversuche → 60 Sekunden Sperre
  - Weitere 3 Fehlversuche → 10 Minuten Sperre
- **AGB/Nutzungsbedingungen**:
  - Müssen bei Registrierung akzeptiert werden
- **Session**:
  - Timeout: 5 Minuten (Standard)
  - Option "Eingeloggt bleiben"
- **2FA** (optional, für spätere Erweiterung)

### Verschlüsselte Kommunikation
- PGP-Verschlüsselung für Kommunikation zwischen Benutzern
- **Key Management**:
  - Öffentliche Schlüssel liegen auf dem Server
  - Private Key wird auf dem Endgerät erzeugt und verwaltet
  - Optional: Verschlüsselter Upload des Private Keys auf den Server
    - **Sicherheitswarnung** muss vor Upload angezeigt werden
  - Download des Private Keys auf neuen Geräten möglich
  - Export-Funktion für Private Key
  - Import-Funktion für Private Key
- **Nachrichten**:
  - Werden vor dem Senden signiert und verschlüsselt
  - Kopie mit eigenem Schlüssel verschlüsselt im Gesendet-Ordner
  - Ungelesene Nachrichten werden kenntlich gemacht
- **Entwürfe**:
  - Verschlüsselt im Draft-Ordner gespeichert
  - Automatische Löschung nach 7 Tagen

### Angebote & Slots
- Jedes Angebot benötigt einen Slot
- Verkäufer können Slots kaufen
- Slot-Varianten (vom Admin konfigurierbar):
  - Preis pro Slot
  - Laufzeit (z.B. 3 Tage, 7 Tage, 14 Tage, 30 Tage)
  - Mehrere Varianten können parallel angeboten werden
- Nach Ablauf der Laufzeit wird das Angebot deaktiviert
- Slot-Verlängerung möglich
- **Ablauf-Warnung**: 3 Tage vor Ablauf auf dem Dashboard
- **Slot-Bezahlung**:
  - Admin konfiguriert erlaubte Zahlungsmethoden (PayPal und/oder Bitcoin)
  - Automatische Zahlungsüberwachung:
    - PayPal: IPN (Instant Payment Notification) Integration
    - Bitcoin: Blockchain-Überwachung (z.B. via BlockCypher API)
  - Automatische Slot-Freischaltung nach Zahlungseingang
- **Angebots-Details**:
  - Titel
  - Beschreibung
  - Menge
  - Mengeneinheit (Stück, Kg, Meter, ohne Menge)
  - Preis pro Einheit
  - Bezahlart (PayPal / Bitcoin)
  - Versand (ja / nein)
  - Versandart (falls Versand = ja)
  - Versandkosten (falls Versand = ja)
- **Bilder**:
  - Bis zu 3 Bilder pro Angebot (direkter Upload, keine URLs)
  - Erstes Bild wird als Mini-Preview in der Übersicht angezeigt
  - Bildergalerie in der Detailansicht
  - Speicherung im Dateisystem
  - Automatische Komprimierung auf max. 300 KB
  - Erlaubte Formate: JPG, PNG, WebP, GIF

### Kategorien
- Hierarchische Struktur: Kategorien und Subkategorien
- Verwaltung durch Admin im Admin-Panel

### Handelsablauf
- Verkäufer markiert Handel als "Gesendet"
- Käufer markiert Handel als "Erhalten" → Handel abgeschlossen
- **Automatischer Abschluss**: Nach 14 Tagen ohne Reklamation
- Reklamation möglich innerhalb von 14 Tagen

### Bewertungssystem
- Bewertung nach abgeschlossenem Handel
- Käufer und Verkäufer können sich gegenseitig bewerten
- Bewertungsoptionen:
  - Gut (positiv)
  - Neutral
  - Schlecht (negativ)
- **Automatische Bewertung**: Positive Bewertung nach 14 Tagen ohne Abgabe

### Dashboard / Startseite
- News vom Admin
- Neueste Angebote
- (Weitere Inhalte können später ergänzt werden)

### Navigation / Menü
- Dashboard / Startseite
- Nachrichten
- Suchen
- Verkaufen
- Einstellungen
- News (nur für Admin sichtbar)
- Admin-Panel (nur für Admin sichtbar)

### Benachrichtigungen
- Neue Nachrichten
- Ungelesene Nachrichten werden kenntlich gemacht

### Benutzerprofil (öffentlich)
- Username
- Bewertung (Durchschnitt)
- Anzahl der Bewertungen
- Aktive Angebote des Users
- "Nachricht senden" Button

### Kontaktaufnahme
- Über "Nachricht senden" Button im Angebot
- Über "Nachricht senden" Button im Benutzerprofil

### Einstellungen
- Account-Löschung möglich (mit Sicherheitsabfrage)
- Zahlungsinformationen verwalten
- Pagination-Einstellung
- Private Key Management

### Benutzerrollen
- **User** (Standard)
- **Moderator**: Kann bei Streitigkeiten schlichtend eingreifen
- **Admin**: Vollzugriff, kann User zu Moderator ernennen

### Account-Sperre
- Angebote werden bei Sperre ebenfalls gesperrt
- Offene Transaktionen werden noch abgeschlossen

### Melden-Funktion
- User können Angebote melden
- User können andere User melden
- Moderatoren/Admins bearbeiten Meldungen

### Suchfunktion
- Volltextsuche
- Filter:
  - Kategorie
  - Subkategorie
  - Bezahlart (PayPal, Bitcoin)
- **Pagination**:
  - Einstellbar: 10, 25, 50, 100, alle
  - Standard: 10

### Favoriten / Merkliste
- User können Angebote speichern
- Übersicht in eigenem Bereich

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
- **Währung**:
  - Bei PayPal: Verkäufer gibt Währung vor
  - Bei Bitcoin: Automatisch BTC
  - User kann Anzeigewährung in Einstellungen wählen (Standard: USD)
  - Automatische Umrechnung zur Anzeige

### Admin-Panel
- Slot-Verwaltung:
  - Slot-Varianten erstellen/bearbeiten/löschen
  - Preis und Laufzeit festlegen
  - Erlaubte Zahlungsmethoden für Slots konfigurieren (PayPal/Bitcoin)
- Zahlungseinstellungen:
  - PayPal-Konto für Slot-Zahlungen hinterlegen
  - Bitcoin-Wallet für Slot-Zahlungen hinterlegen
- Kategorie-Verwaltung:
  - Kategorien erstellen/bearbeiten/löschen
  - Subkategorien erstellen/bearbeiten/löschen
- Benutzer-Verwaltung:
  - User zu Moderator ernennen
  - User sperren/entsperren
- News-Verwaltung:
  - News für Dashboard erstellen/bearbeiten/löschen
  - Lebenszeit pro News (Tage bis automatische Löschung)
  - Standardwert für Lebenszeit konfigurierbar (Default: 14 Tage)
  - Automatische Löschung abgelaufener News

### Moderator-Panel
- Übersicht gemeldeter Angebote
- Übersicht gemeldeter User
- Streitschlichtung zwischen Käufer und Verkäufer
- Angebote entfernen bei Verstoß

## Offene Punkte
(Weitere Anforderungen folgen)

---
*Erstellt am: 2025-12-09*
