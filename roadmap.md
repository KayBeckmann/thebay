# Roadmap - Anzeigenplattform

## Meilenstein 1: Projekt-Setup & Grundstruktur ✅

### 1.1 Entwicklungsumgebung
- [x] Flutter SDK installieren und konfigurieren
- [x] Serverpod CLI installieren
- [x] Projekt-Struktur mit Serverpod erstellen (Server, Client, Flutter)
- [x] Git Repository initialisieren (falls nicht vorhanden)

### 1.2 Docker & Infrastructure
- [x] Docker-Compose Konfiguration erstellen
- [x] PostgreSQL Container einrichten
- [x] Serverpod Backend Container einrichten
- [x] Flutter Web Container einrichten (optional für Web-Deployment)
- [x] .env Datei mit Konfigurationsvariablen erstellen
  - Container-Ports
  - Frontend-URL
  - Admin-Zugangsdaten
  - Datenbank-Credentials

### 1.3 Datenbank-Schema (Grundstruktur)
- [x] User-Tabelle (id, username, password_hash, role, created_at)
- [x] Settings-Tabelle für globale Einstellungen
- [x] Migrations einrichten

---

## Meilenstein 2: Authentifizierung & Benutzerverwaltung ✅

### 2.1 Backend - Auth-System
- [x] Argon2id Passwort-Hashing implementieren
- [x] Passwort-Validierung (min. 8 Zeichen, Groß-/Kleinbuchstaben, Ziffern)
- [x] Registrierung-Endpoint (ohne Email)
- [x] Login-Endpoint
- [x] Rate Limiting implementieren (3 Versuche → 60s, dann 10min Sperre)
- [x] Session-Management (5 Min Timeout, "Eingeloggt bleiben" Option)
- [x] Admin-Account aus .env beim ersten Start erstellen

### 2.2 Frontend - Auth-Screens
- [x] Login Screen (Material Design)
- [x] Registrierung Screen
- [x] AGB/Nutzungsbedingungen Anzeige & Akzeptierung
- [x] Session-Handling im Frontend
- [x] Logout-Funktion

### 2.3 Benutzerrollen
- [x] Rollen-System implementieren (User, Moderator, Admin)
- [x] Middleware für Rollen-basierte Zugriffskontrolle

---

## Meilenstein 3: Navigation & Grundlegende UI ✅

### 3.1 App-Struktur
- [x] Material Design Theme konfigurieren
- [x] Haupt-Navigation implementieren:
  - Dashboard / Startseite
  - Nachrichten
  - Suchen
  - Verkaufen
  - Einstellungen
  - News (nur für Admin sichtbar)
  - Admin-Panel (nur für Admin sichtbar)
- [x] Rollen-basierte Menü-Sichtbarkeit

### 3.2 Dashboard
- [x] News-Bereich (vom Admin)
- [x] Neueste Angebote Übersicht
- [x] Slot-Ablauf-Warnungen (3 Tage vor Ablauf)

### 3.3 Einstellungen-Screen
- [x] Zahlungsinformationen verwalten (PayPal, Bitcoin)
- [x] Pagination-Einstellung (10, 25, 50, 100, alle)
- [x] Anzeigewährung wählen (Standard: USD)
- [x] Account-Löschung (mit Sicherheitsabfrage)

---

## Meilenstein 4: Kategorien & Admin-Panel (Basis) ✅

### 4.1 Datenbank-Erweiterung
- [x] Kategorien-Tabelle (id, name, parent_id)
- [x] News-Tabelle (id, title, content, created_at)
- [x] Slot-Varianten-Tabelle (id, name, price, duration_days)

### 4.2 Admin-Panel - Kategorien
- [x] Kategorien erstellen/bearbeiten/löschen
- [x] Subkategorien erstellen/bearbeiten/löschen
- [x] Hierarchische Anzeige

### 4.3 Admin-Panel - Slots
- [x] Slot-Varianten erstellen/bearbeiten/löschen
- [x] Preis und Laufzeit festlegen
- [x] Erlaubte Zahlungsmethoden für Slots konfigurieren (PayPal/Bitcoin)

### 4.4 Admin-Panel - Zahlungseinstellungen
- [x] PayPal-Konto für Slot-Zahlungen hinterlegen
- [x] Bitcoin-Wallet für Slot-Zahlungen hinterlegen

### 4.5 Admin-Panel - News
- [x] News erstellen/bearbeiten/löschen
- [x] Lebenszeit pro News (Tage bis automatische Löschung)
- [x] Standardwert für Lebenszeit konfigurierbar (Default: 14 Tage)
- [x] Cron-Job für automatische Löschung abgelaufener News
- [x] News auf Dashboard anzeigen
- [x] Menüpunkt "News" für Admin (zur News-Verwaltung)

---

## Meilenstein 5a: Datenbank & Backend für Angebote ✅

### 5a.1 Datenbank-Erweiterung
- [x] Angebote-Tabelle (Listing)
- [x] Bilder-Tabelle (ListingImage)
- [x] User-Slots-Tabelle (UserSlot)
- [x] Slot-Bestellungen-Tabelle (SlotOrder)

### 5a.2 Backend - Angebote CRUD
- [x] Listing-Endpoint: erstellen, bearbeiten, löschen, abrufen
- [x] Slot-Verbrauch bei Angebotserstellung
- [x] Eigene Angebote abrufen

---

## Meilenstein 5b: Bild-Upload & Dateisystem ✅

### 5b.1 Backend - Bilder
- [x] Bild-Upload Endpoint
- [x] Automatische Komprimierung (max. 300 KB)
- [x] Erlaubte Formate: JPG, PNG, WebP, GIF
- [x] Bilder im Dateisystem speichern
- [x] Bilder abrufen/löschen

---

## Meilenstein 5c: Frontend - Angebote ✅

### 5c.1 Angebot erstellen/bearbeiten
- [x] Angebot erstellen Screen:
  - Titel, Beschreibung
  - Menge, Mengeneinheit (Stück, Kg, Meter, ohne)
  - Preis pro Einheit
  - Bezahlart (PayPal / Bitcoin)
  - Versand (ja/nein), Versandart, Versandkosten
  - Kategorie / Subkategorie Auswahl
  - Bild-Upload (bis zu 3 Bilder)
- [x] Angebot bearbeiten Screen

### 5c.2 Angebots-Ansichten
- [x] Angebots-Detailansicht mit Bildergalerie
- [x] Angebots-Übersicht (Liste mit Mini-Preview)
- [x] Eigene Angebote verwalten

---

## Meilenstein 5d: Slot-Kauf & Verwaltung ✅

### 5d.1 User-Slots
- [x] Verfügbare Slots anzeigen
- [x] Slot-Ablauf-Warnungen
- [x] Automatische Deaktivierung bei Slot-Ablauf
- [x] Slot-Verlängerung

### 5d.2 Slot-Kauf Screen
- [x] Slot-Varianten Auswahl
- [x] Zahlungsmethode wählen
- [x] Bestellung erstellen

---

## Meilenstein 5e: Zahlungsintegration ✅

### 5e.1 PayPal Integration
- [x] PayPal IPN (Instant Payment Notification) Endpoint
- [x] Zahlungsverifizierung
- [x] Automatische Slot-Freischaltung nach Zahlungseingang

### 5e.2 Bitcoin Integration
- [x] Einzigartige Zahlungsadresse pro Transaktion (oder Memo/Reference)
- [x] Blockchain-Überwachung (z.B. BlockCypher API)
- [x] Bestätigungen abwarten (1-3 Confirmations)
- [x] Automatische Slot-Freischaltung nach Zahlungseingang

### 5e.3 Ausstehende Zahlungen
- [x] Ausstehende Zahlungen im Dashboard anzeigen
- [x] Zahlungsstatus aktualisieren

---

## Meilenstein 6: Suche & Favoriten ✅

### 6.1 Backend - Suche
- [x] Volltextsuche implementieren
- [x] Filter: Kategorie, Subkategorie, Bezahlart
- [x] Pagination (konfigurierbar)

### 6.2 Frontend - Suche
- [x] Such-Screen mit Eingabefeld
- [x] Filter-Optionen
- [x] Ergebnisliste mit Pagination

### 6.3 Favoriten
- [x] Favoriten-Tabelle (user_id, listing_id)
- [x] Favoriten hinzufügen/entfernen
- [x] Favoriten-Übersicht Screen

---

## Meilenstein 7a: Datenbank & PGP Key Management ✅

### 7a.1 Datenbank-Erweiterung
- [x] Public Keys Tabelle (user_id, public_key_armored, fingerprint, algorithm, key_size, is_active)
- [x] Nachrichten-Tabelle (sender_id, recipient_id, encrypted_subject, encrypted_content, is_read, deleted_by_sender, deleted_by_recipient)
- [x] Entwürfe-Tabelle (user_id, recipient_id, encrypted_subject, encrypted_content, expires_at)
- [x] Verschlüsseltes Key-Backup Tabelle (optional)

### 7a.2 PGP Key Management - Backend
- [x] PgpKeyEndpoint: Public Key Upload
- [x] PgpKeyEndpoint: Public Key abrufen (eigener, per userId, per Username)
- [x] PgpKeyEndpoint: Key deaktivieren
- [x] Optional: Verschlüsseltes Backup Upload/Download

### 7a.3 PGP Key Management - Frontend
- [x] PgpKeyService: Key-Generierung auf dem Endgerät (RSA 4096)
- [x] PgpKeyService: Private Key lokal speichern (flutter_secure_storage)
- [x] PgpKeyService: Public Key Upload zum Server
- [x] PgpKeyService: Private Key Export/Import Funktion
- [x] PgpKeyScreen: Key-Status Anzeige
- [x] PgpKeyScreen: Key generieren mit Progress-Anzeige
- [x] PgpKeyScreen: Key exportieren/importieren
- [x] Settings-Screen: Integration PGP Key Management

---

## Meilenstein 7b: Backend - Nachrichten ✅

### 7b.1 Message Endpoint
- [x] Nachricht senden (verschlüsselt speichern)
- [x] Posteingang abrufen (mit Pagination)
- [x] Gesendete Nachrichten abrufen
- [x] Nachricht als gelesen markieren
- [x] Nachricht löschen (Soft-Delete)
- [x] Ungelesene Nachrichten zählen

### 7b.2 Draft Endpoint
- [x] Entwurf speichern
- [x] Entwurf aktualisieren
- [x] Entwürfe abrufen
- [x] Entwurf löschen
- [x] Automatische Löschung nach 7 Tagen (Cron-Job)

---

## Meilenstein 7c: Frontend - Nachrichten ✅

### 7c.1 Nachrichten-Screens
- [x] Posteingang mit Nachrichtenliste
- [x] Gesendet-Ordner
- [x] Entwürfe-Ordner
- [x] Nachricht-Detail-Ansicht (Entschlüsselung)
- [x] Nachricht verfassen Dialog (Verschlüsselung vor Senden)

### 7c.2 Integration
- [x] Ungelesene Nachrichten Badge in Navigation
- [x] "Nachricht senden" Button in Angebots-Detailansicht
- [x] "Nachricht senden" Button in Profilen (Meilenstein 8)

---

## Meilenstein 8: Benutzerprofil & Kontakt ✅

### 8.1 Öffentliches Profil
- [x] Profil-Screen:
  - Username
  - Bewertung (Durchschnitt) - Platzhalter für Meilenstein 9
  - Anzahl Bewertungen - Platzhalter für Meilenstein 9
  - Aktive Angebote
  - "Nachricht senden" Button
- [x] Profil-Link in Angeboten

### 8.2 Zahlungsinformationen
- [x] Zahlungsinfos erst nach Kontaktaufnahme sichtbar
- [x] PayPal-Adresse / Bitcoin-Wallet im Profil (optional)

---

## Meilenstein 9a: Datenbank & Models für Handel ✅

### 9a.1 Datenbank-Erweiterung
- [x] Transaction-Tabelle:
  - id, buyer_id, seller_id, listing_id
  - status (enum: open, shipped, received, completed, disputed, cancelled)
  - quantity, total_price_cents
  - payment_method (paypal/bitcoin)
  - created_at, updated_at
  - shipped_at, received_at, completed_at
  - auto_complete_at (Datum für automatischen Abschluss)
  - buyer_note (optionale Nachricht vom Käufer)
- [x] TransactionStatus Enum erstellen
- [x] Rating-Tabelle:
  - id, transaction_id, from_user_id, to_user_id
  - rating (enum: positive, neutral, negative)
  - comment (optional, max 500 Zeichen)
  - created_at
  - is_automatic (für automatische Bewertungen)
- [x] RatingValue Enum erstellen (positive, neutral, negative)
- [x] Dispute-Tabelle (für Reklamationen):
  - id, transaction_id, opened_by_user_id
  - reason, status (open, resolved, closed)
  - resolution, moderator_id
  - created_at, resolved_at
- [x] DisputeStatus Enum erstellen

---

## Meilenstein 9b: Backend - Transaktionen (Handelsablauf) ✅

### 9b.1 TransactionEndpoint
- [x] Transaktion starten (Käufer initiiert bei Kaufinteresse)
- [x] Transaktion abrufen (getById, getMyTransactions)
- [x] Als Verkäufer: Status auf "shipped" setzen
- [x] Als Käufer: Status auf "received" setzen → Transaktion abgeschlossen
- [x] Transaktion abbrechen (nur wenn Status = open)
- [x] Reklamation öffnen (Dispute erstellen)

### 9b.2 Automatisierung (Cron-Jobs)
- [x] Automatischer Abschluss nach 14 Tagen ohne Reklamation
- [x] Benachrichtigung 3 Tage vor automatischem Abschluss (getUpcomingAutoComplete)

### 9b.3 Transaktions-Statistiken
- [x] Anzahl abgeschlossener Transaktionen pro User (getCompletedCount)
- [x] Offene Transaktionen zählen (getOpenCount)

### 9b.4 DisputeEndpoint (Bonus)
- [x] Reklamation abrufen (getById, getByTransaction, getMyDisputes)
- [x] Offene Reklamationen für Moderatoren (getOpenDisputes, getOpenCount)
- [x] Reklamation übernehmen (assignToMe)
- [x] Reklamation lösen/schließen (resolve, close)

---

## Meilenstein 9c: Backend - Bewertungen ✅

### 9c.1 RatingEndpoint
- [x] Bewertung abgeben (nur nach abgeschlossener Transaktion)
- [x] Bewertung abrufen (für Transaktion, für User)
- [x] Prüfung: Jeder kann nur einmal pro Transaktion bewerten
- [x] Bewertung nur innerhalb von 14 Tagen nach Abschluss möglich

### 9c.2 Automatisierung
- [x] Automatische positive Bewertung nach 14 Tagen ohne Abgabe
- [x] Cron-Job für ausstehende Bewertungen

### 9c.3 Bewertungs-Statistiken
- [x] Bewertungsdurchschnitt berechnen (für UserProfile)
- [x] Anzahl Bewertungen pro User
- [x] Aufschlüsselung (positiv/neutral/negativ)

### 9c.4 Integration mit UserProfile
- [x] ratingAverage und ratingCount im UserProfile aktualisieren
- [x] Bewertungsübersicht im Profil anzeigen

---

## Meilenstein 9d: Frontend - Transaktionen ✅

### 9d.1 Transaktions-Screens
- [x] Transaktions-Übersicht Screen (Tabs: Käufe / Verkäufe)
- [x] Transaktions-Detail Screen
- [x] Transaktion starten Dialog (aus Angebot heraus)
- [x] Navigation: Menüpunkt "Transaktionen" hinzufügen

### 9d.2 Status-Änderungen
- [x] "Als gesendet markieren" Button (Verkäufer)
- [x] "Als erhalten markieren" Button (Käufer)
- [x] "Transaktion abbrechen" Option
- [x] Status-Timeline Anzeige

### 9d.3 Reklamation
- [x] "Reklamation öffnen" Dialog
- [x] Reklamations-Status Anzeige
- [x] Hinweis auf automatischen Abschluss

---

## Meilenstein 9e: Frontend - Bewertungen ✅

### 9e.1 Bewertungs-UI
- [x] Bewertung abgeben Dialog (nach Transaktionsabschluss)
- [x] Bewertungs-Auswahl (Gut/Neutral/Schlecht mit Icons)
- [x] Optionales Kommentarfeld
- [x] Erinnerung an ausstehende Bewertungen

### 9e.2 Bewertungs-Anzeige
- [x] Bewertungen im UserProfile anzeigen
- [x] Bewertungs-Liste mit Kommentaren
- [x] Bewertungs-Badge im Profil (z.B. "95% positiv")

### 9e.3 Integration
- [x] Bewertungs-Prompt nach Transaktionsabschluss
- [x] Ausstehende Bewertungen auf Dashboard anzeigen

---

## Meilenstein 10: Währung & Umrechnung ✅

### 10.1 Backend
- [x] Währungs-API Integration (z.B. für BTC/USD Kurs)
- [x] Umrechnungs-Endpoint

### 10.2 Frontend
- [x] Preisanzeige in User-Währung
- [x] Währung in Angeboten (Verkäufer-Währung bei PayPal, BTC bei Bitcoin)

---

## Meilenstein 11a: Melden-System (Reports) ✅

### 11a.1 Datenbank-Erweiterung
- [x] Report-Tabelle (reporter_id, target_type, target_id, reason, status, created_at)
- [x] ReportTargetType Enum (listing, user)
- [x] ReportStatus Enum (open, reviewing, resolved, dismissed)
- [x] ReportReason Enum (spam, inappropriate, scam, fraud, harassment, other)

### 11a.2 Backend - Report-Endpoints
- [x] Angebot melden (createListingReport)
- [x] User melden (createUserReport)
- [x] Eigene Meldungen abrufen (getMyReports)
- [x] Meldung abrufen nach ID (getById)
- [x] Prüfung: Ein User kann dasselbe Ziel nur einmal melden
- [x] Meldung löschen (deleteReport - nur wenn status=open)

### 11a.3 Frontend - Melden-Funktionalität
- [x] "Melden"-Button in Angebots-Detailansicht
- [x] "Melden"-Button in User-Profilen
- [x] Melde-Dialog mit Grund-Auswahl
- [x] Bestätigungs-Feedback nach erfolgreicher Meldung

---

## Meilenstein 11b: Moderator-Panel ✅

### 11b.1 Backend - Moderator-Funktionen
- [x] Alle offenen Meldungen abrufen (getOpenReports - für Moderatoren)
- [x] Meldungen nach Typ filtern (listing/user)
- [x] Anzahl offener Meldungen (getOpenCount)
- [x] Meldung übernehmen (assignToMe)
- [x] Meldung Status ändern (updateStatus - reviewing/resolved/dismissed)
- [x] Gemeldetes Angebot deaktivieren
- [x] Notiz zu Meldung hinzufügen

### 11b.2 Frontend - Moderator-Dashboard
- [x] Moderator-Panel Menüpunkt (nur für Moderator/Admin sichtbar)
- [x] Übersicht offener Meldungen (mit Tabs: Angebote/User/Alle)
- [x] Meldungs-Detail-Ansicht
- [x] Filter- und Sortier-Optionen
- [x] Badge mit Anzahl offener Meldungen
- [x] Actions: Status ändern, Angebot deaktivieren
- [x] Notiz-Funktion für interne Kommunikation

---

## Meilenstein 11c: Admin-Benutzerverwaltung ✅

### 11c.1 Datenbank-Erweiterung
- [x] User-Tabelle erweitern: isBanned, bannedAt, bannedReason, bannedBy
- [x] UserBanLog-Tabelle (für Historie)

### 11c.2 Backend - User-Verwaltung
- [x] User-Rolle ändern (updateUserRole - nur Admin)
- [x] User sperren (banUser)
- [x] User entsperren (unbanUser)
- [x] Bei Sperre: Alle Angebote deaktivieren
- [x] Bei Sperre: Laufende Transaktionen behandeln (Auto-Cancel oder Info)
- [x] Gesperrte User auflisten
- [x] Ban-Historie abrufen

### 11c.3 Frontend - Admin-Panel Benutzerverwaltung
- [x] Benutzerverwaltungs-Screen im Admin-Panel
- [x] User-Liste mit Such- und Filter-Funktion
- [x] User-Detail mit Rollen-Auswahl
- [x] "Sperren"-Dialog mit Grund-Angabe
- [x] Gesperrte User verwalten
- [x] Ban-Historie anzeigen
- [x] Warnung bei kritischen Aktionen (Moderator ernennen, Sperren)

---

## Meilenstein 12: Backup & Wartung

### 12.1 BorgBackup Setup
- [ ] BorgBackup im Docker-Setup integrieren
- [ ] Cron-Job für automatische Backups
- [ ] Konfiguration für externes Backup-Ziel
- [ ] Backup-Rotation (täglich, wöchentlich, monatlich)

### 12.2 Wartungs-Tasks
- [ ] Cron: Abgelaufene Slots deaktivieren
- [ ] Cron: Entwürfe nach 7 Tagen löschen
- [ ] Cron: Automatischer Handelsabschluss nach 14 Tagen
- [ ] Cron: Automatische Bewertungen nach 14 Tagen

---

## Meilenstein 13: Testing & Deployment

### 13.1 Testing
- [ ] Unit Tests für Backend-Logik
- [ ] Integration Tests für API-Endpoints
- [ ] Frontend Widget Tests
- [ ] End-to-End Tests (kritische Flows)

### 13.2 Deployment
- [ ] Docker-Compose für Produktion optimieren
- [ ] SSL/TLS Zertifikate einrichten
- [ ] Reverse Proxy (nginx) konfigurieren
- [ ] Monitoring einrichten

---

## Zukünftige Erweiterungen (nach MVP)

### Geplant
- [ ] 2FA (Zwei-Faktor-Authentifizierung)
- [ ] Registrierungsgebühr (Admin-konfigurierbar)
- [ ] Kostenlose Promotion-Slots ohne Abrechnung

### Mögliche Erweiterungen
- [ ] Push-Benachrichtigungen
- [ ] Mobile Apps (iOS/Android) via Flutter
- [ ] Erweiterte Statistiken im Dashboard
- [ ] API für externe Integrationen

---

*Erstellt am: 2025-12-09*
*Aktualisiert am: 2025-12-19*
