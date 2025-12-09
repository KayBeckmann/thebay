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

## Meilenstein 2: Authentifizierung & Benutzerverwaltung

### 2.1 Backend - Auth-System
- [ ] Argon2id Passwort-Hashing implementieren
- [ ] Passwort-Validierung (min. 8 Zeichen, Groß-/Kleinbuchstaben, Ziffern)
- [ ] Registrierung-Endpoint (ohne Email)
- [ ] Login-Endpoint
- [ ] Rate Limiting implementieren (3 Versuche → 60s, dann 10min Sperre)
- [ ] Session-Management (5 Min Timeout, "Eingeloggt bleiben" Option)
- [ ] Admin-Account aus .env beim ersten Start erstellen

### 2.2 Frontend - Auth-Screens
- [ ] Login Screen (Material Design)
- [ ] Registrierung Screen
- [ ] AGB/Nutzungsbedingungen Anzeige & Akzeptierung
- [ ] Session-Handling im Frontend
- [ ] Logout-Funktion

### 2.3 Benutzerrollen
- [ ] Rollen-System implementieren (User, Moderator, Admin)
- [ ] Middleware für Rollen-basierte Zugriffskontrolle

---

## Meilenstein 3: Navigation & Grundlegende UI

### 3.1 App-Struktur
- [ ] Material Design Theme konfigurieren
- [ ] Haupt-Navigation implementieren:
  - Dashboard / Startseite
  - Nachrichten
  - Suchen
  - Verkaufen
  - Einstellungen
  - News (nur für Admin sichtbar)
  - Admin-Panel (nur für Admin sichtbar)
- [ ] Rollen-basierte Menü-Sichtbarkeit

### 3.2 Dashboard
- [ ] News-Bereich (vom Admin)
- [ ] Neueste Angebote Übersicht
- [ ] Slot-Ablauf-Warnungen (3 Tage vor Ablauf)

### 3.3 Einstellungen-Screen
- [ ] Zahlungsinformationen verwalten (PayPal, Bitcoin)
- [ ] Pagination-Einstellung (10, 25, 50, 100, alle)
- [ ] Anzeigewährung wählen (Standard: USD)
- [ ] Account-Löschung (mit Sicherheitsabfrage)

---

## Meilenstein 4: Kategorien & Admin-Panel (Basis)

### 4.1 Datenbank-Erweiterung
- [ ] Kategorien-Tabelle (id, name, parent_id)
- [ ] News-Tabelle (id, title, content, created_at)
- [ ] Slot-Varianten-Tabelle (id, name, price, duration_days)

### 4.2 Admin-Panel - Kategorien
- [ ] Kategorien erstellen/bearbeiten/löschen
- [ ] Subkategorien erstellen/bearbeiten/löschen
- [ ] Hierarchische Anzeige

### 4.3 Admin-Panel - Slots
- [ ] Slot-Varianten erstellen/bearbeiten/löschen
- [ ] Preis und Laufzeit festlegen
- [ ] Erlaubte Zahlungsmethoden für Slots konfigurieren (PayPal/Bitcoin)

### 4.4 Admin-Panel - Zahlungseinstellungen
- [ ] PayPal-Konto für Slot-Zahlungen hinterlegen
- [ ] Bitcoin-Wallet für Slot-Zahlungen hinterlegen

### 4.5 Admin-Panel - News
- [ ] News erstellen/bearbeiten/löschen
- [ ] Lebenszeit pro News (Tage bis automatische Löschung)
- [ ] Standardwert für Lebenszeit konfigurierbar (Default: 14 Tage)
- [ ] Cron-Job für automatische Löschung abgelaufener News
- [ ] News auf Dashboard anzeigen
- [ ] Menüpunkt "News" für Admin (zur News-Verwaltung)

---

## Meilenstein 5: Angebote & Slots

### 5.1 Datenbank-Erweiterung
- [ ] Angebote-Tabelle (alle Felder laut Spezifikation)
- [ ] Bilder-Tabelle (Referenz zu Angebot, Dateipfad, Sortierung)
- [ ] User-Slots-Tabelle (gekaufte Slots, Ablaufdatum)

### 5.2 Backend - Angebote
- [ ] CRUD-Endpoints für Angebote
- [ ] Bild-Upload mit automatischer Komprimierung (max. 300 KB)
- [ ] Erlaubte Formate: JPG, PNG, WebP, GIF
- [ ] Bilder im Dateisystem speichern
- [ ] Slot-Verbrauch bei Angebotserstellung
- [ ] Automatische Deaktivierung bei Slot-Ablauf
- [ ] Slot-Verlängerung

### 5.3 Frontend - Angebote
- [ ] Angebot erstellen Screen:
  - Titel, Beschreibung
  - Menge, Mengeneinheit (Stück, Kg, Meter, ohne)
  - Preis pro Einheit
  - Bezahlart (PayPal / Bitcoin)
  - Versand (ja/nein), Versandart, Versandkosten
  - Kategorie / Subkategorie Auswahl
  - Bild-Upload (bis zu 3 Bilder)
- [ ] Angebot bearbeiten Screen
- [ ] Angebots-Detailansicht mit Bildergalerie
- [ ] Angebots-Übersicht (Liste mit Mini-Preview)

### 5.4 Slot-Kauf & Zahlungsintegration
- [ ] Admin-Einstellungen für Slot-Zahlungen:
  - PayPal-Konto hinterlegen
  - Bitcoin-Wallet hinterlegen
  - Erlaubte Zahlungsmethoden aktivieren/deaktivieren
- [ ] Slot-Auswahl Screen mit verfügbaren Zahlungsmethoden
- [ ] PayPal Integration:
  - [ ] PayPal IPN (Instant Payment Notification) Endpoint
  - [ ] Zahlungsverifizierung
  - [ ] Automatische Slot-Freischaltung nach Zahlungseingang
- [ ] Bitcoin Integration:
  - [ ] Einzigartige Zahlungsadresse pro Transaktion generieren (oder Memo/Reference)
  - [ ] Blockchain-Überwachung (z.B. BlockCypher API)
  - [ ] Bestätigungen abwarten (z.B. 1-3 Confirmations)
  - [ ] Automatische Slot-Freischaltung nach Zahlungseingang
- [ ] Slot-Bestellungen Tabelle (user_id, slot_variant, payment_method, status, tx_id)
- [ ] Ausstehende Zahlungen anzeigen (User-Dashboard)

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
