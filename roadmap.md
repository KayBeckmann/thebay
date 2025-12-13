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

## Meilenstein 5c: Frontend - Angebote

### 5c.1 Angebot erstellen/bearbeiten
- [ ] Angebot erstellen Screen:
  - Titel, Beschreibung
  - Menge, Mengeneinheit (Stück, Kg, Meter, ohne)
  - Preis pro Einheit
  - Bezahlart (PayPal / Bitcoin)
  - Versand (ja/nein), Versandart, Versandkosten
  - Kategorie / Subkategorie Auswahl
  - Bild-Upload (bis zu 3 Bilder)
- [ ] Angebot bearbeiten Screen

### 5c.2 Angebots-Ansichten
- [ ] Angebots-Detailansicht mit Bildergalerie
- [ ] Angebots-Übersicht (Liste mit Mini-Preview)
- [ ] Eigene Angebote verwalten

---

## Meilenstein 5d: Slot-Kauf & Verwaltung

### 5d.1 User-Slots
- [ ] Verfügbare Slots anzeigen
- [ ] Slot-Ablauf-Warnungen
- [ ] Automatische Deaktivierung bei Slot-Ablauf
- [ ] Slot-Verlängerung

### 5d.2 Slot-Kauf Screen
- [ ] Slot-Varianten Auswahl
- [ ] Zahlungsmethode wählen
- [ ] Bestellung erstellen

---

## Meilenstein 5e: Zahlungsintegration

### 5e.1 PayPal Integration
- [ ] PayPal IPN (Instant Payment Notification) Endpoint
- [ ] Zahlungsverifizierung
- [ ] Automatische Slot-Freischaltung nach Zahlungseingang

### 5e.2 Bitcoin Integration
- [ ] Einzigartige Zahlungsadresse pro Transaktion (oder Memo/Reference)
- [ ] Blockchain-Überwachung (z.B. BlockCypher API)
- [ ] Bestätigungen abwarten (1-3 Confirmations)
- [ ] Automatische Slot-Freischaltung nach Zahlungseingang

### 5e.3 Ausstehende Zahlungen
- [ ] Ausstehende Zahlungen im Dashboard anzeigen
- [ ] Zahlungsstatus aktualisieren

---

## Meilenstein 6: Suche & Favoriten

### 6.1 Backend - Suche
- [ ] Volltextsuche implementieren
- [ ] Filter: Kategorie, Subkategorie, Bezahlart
- [ ] Pagination (konfigurierbar)

### 6.2 Frontend - Suche
- [ ] Such-Screen mit Eingabefeld
- [ ] Filter-Optionen
- [ ] Ergebnisliste mit Pagination

### 6.3 Favoriten
- [ ] Favoriten-Tabelle (user_id, listing_id)
- [ ] Favoriten hinzufügen/entfernen
- [ ] Favoriten-Übersicht Screen

---

## Meilenstein 7: PGP-Verschlüsselung & Nachrichten

### 7.1 PGP Key Management
- [ ] Key-Generierung auf dem Endgerät
- [ ] Public Key Upload zum Server
- [ ] Private Key Export/Import Funktion
- [ ] Optional: Verschlüsselter Private Key Upload (mit Sicherheitswarnung)
- [ ] Private Key Download auf neuen Geräten

### 7.2 Datenbank-Erweiterung
- [ ] Public Keys Tabelle
- [ ] Nachrichten-Tabelle (verschlüsselt)
- [ ] Entwürfe-Tabelle (verschlüsselt, mit Ablaufdatum)

### 7.3 Backend - Nachrichten
- [ ] Nachrichten senden (verschlüsselt speichern)
- [ ] Nachrichten abrufen
- [ ] Entwürfe speichern
- [ ] Automatische Löschung von Entwürfen nach 7 Tagen
- [ ] Ungelesen-Status verwalten

### 7.4 Frontend - Nachrichten
- [ ] Posteingang
- [ ] Gesendet-Ordner
- [ ] Entwürfe-Ordner
- [ ] Nachricht verfassen (signieren & verschlüsseln vor Senden)
- [ ] Ungelesene Nachrichten kenntlich machen
- [ ] "Nachricht senden" Button in Angeboten
- [ ] "Nachricht senden" Button in Profilen

---

## Meilenstein 8: Benutzerprofil & Kontakt

### 8.1 Öffentliches Profil
- [ ] Profil-Screen:
  - Username
  - Bewertung (Durchschnitt)
  - Anzahl Bewertungen
  - Aktive Angebote
  - "Nachricht senden" Button
- [ ] Profil-Link in Angeboten

### 8.2 Zahlungsinformationen
- [ ] Zahlungsinfos erst nach Kontaktaufnahme sichtbar
- [ ] PayPal-Adresse / Bitcoin-Wallet im Profil (optional)

---

## Meilenstein 9: Handelsablauf & Bewertungen

### 9.1 Datenbank-Erweiterung
- [ ] Transaktionen-Tabelle (buyer, seller, listing, status, timestamps)
- [ ] Bewertungen-Tabelle (transaction_id, from_user, to_user, rating)

### 9.2 Backend - Handel
- [ ] Transaktion starten (bei Kontaktaufnahme/Kauf)
- [ ] Status: Offen → Gesendet → Erhalten/Abgeschlossen
- [ ] Automatischer Abschluss nach 14 Tagen
- [ ] Reklamation-Funktion

### 9.3 Backend - Bewertungen
- [ ] Bewertung abgeben (Gut, Neutral, Schlecht)
- [ ] Automatische positive Bewertung nach 14 Tagen ohne Abgabe
- [ ] Bewertungsdurchschnitt berechnen

### 9.4 Frontend - Handel & Bewertungen
- [ ] Transaktions-Übersicht (Käufe/Verkäufe)
- [ ] Status ändern (Gesendet/Erhalten)
- [ ] Reklamation einreichen
- [ ] Bewertung abgeben Screen

---

## Meilenstein 10: Währung & Umrechnung

### 10.1 Backend
- [ ] Währungs-API Integration (z.B. für BTC/USD Kurs)
- [ ] Umrechnungs-Endpoint

### 10.2 Frontend
- [ ] Preisanzeige in User-Währung
- [ ] Währung in Angeboten (Verkäufer-Währung bei PayPal, BTC bei Bitcoin)

---

## Meilenstein 11: Melden-Funktion & Moderation

### 11.1 Datenbank-Erweiterung
- [ ] Meldungen-Tabelle (reporter, reported_user/listing, reason, status)

### 11.2 Backend
- [ ] Angebot melden
- [ ] User melden
- [ ] Meldungen abrufen (für Moderatoren)
- [ ] Meldung bearbeiten/schließen

### 11.3 Moderator-Panel
- [ ] Übersicht gemeldeter Angebote
- [ ] Übersicht gemeldeter User
- [ ] Angebot entfernen
- [ ] Streitschlichtung (Kommunikation mit beiden Parteien)

### 11.4 Admin-Panel - Benutzerverwaltung
- [ ] User zu Moderator ernennen
- [ ] User sperren/entsperren
- [ ] Bei Sperre: Angebote sperren, offene Transaktionen abschließen

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

### Mögliche Erweiterungen
- [ ] Push-Benachrichtigungen
- [ ] Mobile Apps (iOS/Android) via Flutter
- [ ] Erweiterte Statistiken im Dashboard
- [ ] API für externe Integrationen

---

*Erstellt am: 2025-12-09*
