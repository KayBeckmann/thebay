// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Bay';

  @override
  String get loginTitle => 'Willkommen zurück';

  @override
  String get loginSubtitle => 'Melde dich an um fortzufahren';

  @override
  String get username => 'Benutzername';

  @override
  String get usernameRequired => 'Bitte gib deinen Benutzernamen ein';

  @override
  String get password => 'Passwort';

  @override
  String get passwordRequired => 'Bitte gib dein Passwort ein';

  @override
  String get stayLoggedIn => 'Angemeldet bleiben';

  @override
  String get signIn => 'Anmelden';

  @override
  String get dontHaveAccount => 'Noch kein Konto? ';

  @override
  String get signUp => 'Registrieren';

  @override
  String get loginFailed => 'Anmeldung fehlgeschlagen';

  @override
  String get connectionError => 'Verbindungsfehler. Bitte versuche es erneut.';

  @override
  String tryAgainInSeconds(int seconds) {
    return 'Versuche es in $seconds Sekunden erneut';
  }

  @override
  String get registerTitle => 'Konto erstellen';

  @override
  String get registerSubtitle => 'Registriere dich um loszulegen';

  @override
  String get usernameHelper => '3-20 Zeichen, Buchstaben, Zahlen, Unterstriche';

  @override
  String get usernameMinLength =>
      'Benutzername muss mindestens 3 Zeichen lang sein';

  @override
  String get usernameMaxLength =>
      'Benutzername darf maximal 20 Zeichen lang sein';

  @override
  String get usernameInvalidChars =>
      'Nur Buchstaben, Zahlen und Unterstriche erlaubt';

  @override
  String get passwordHelper =>
      'Mind. 8 Zeichen, Großbuchst., Kleinbuchst., Ziffer';

  @override
  String get passwordMinLength =>
      'Passwort muss mindestens 8 Zeichen lang sein';

  @override
  String get passwordNeedsUppercase =>
      'Passwort muss einen Großbuchstaben enthalten';

  @override
  String get passwordNeedsLowercase =>
      'Passwort muss einen Kleinbuchstaben enthalten';

  @override
  String get passwordNeedsDigit => 'Passwort muss eine Ziffer enthalten';

  @override
  String get confirmPassword => 'Passwort bestätigen';

  @override
  String get passwordsDoNotMatch => 'Passwörter stimmen nicht überein';

  @override
  String get agreeToTerms => 'Ich stimme den ';

  @override
  String get termsOfService => 'Nutzungsbedingungen';

  @override
  String get close => 'Schließen';

  @override
  String get createAccount => 'Konto erstellen';

  @override
  String get alreadyHaveAccount => 'Bereits ein Konto? ';

  @override
  String get mustAcceptTerms => 'Du musst die Nutzungsbedingungen akzeptieren';

  @override
  String get registrationFailed => 'Registrierung fehlgeschlagen';

  @override
  String get generatingKey => 'Sicherheitsschlüssel wird erstellt...';

  @override
  String get generatingKeyMessage =>
      'Dein persönlicher Verschlüsselungsschlüssel wird generiert.\nDies dauert nur wenige Sekunden.';

  @override
  String keyGenerationFailed(String error) {
    return 'Schlüssel konnte nicht generiert werden: $error\nDu kannst ihn später in den Einstellungen erstellen.';
  }

  @override
  String elapsedTime(String time) {
    return 'Verstrichene Zeit: $time';
  }

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navMessages => 'Nachrichten';

  @override
  String get navSearch => 'Suchen';

  @override
  String get navSell => 'Verkaufen';

  @override
  String get navTransactions => 'Transaktionen';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get navModeration => 'Moderation';

  @override
  String get navNews => 'News';

  @override
  String get navAdmin => 'Admin';

  @override
  String get drawerUserFallback => 'Benutzer';

  @override
  String get drawerModerationSection => 'Moderation';

  @override
  String get drawerAdminSection => 'Administration';

  @override
  String get roleAdmin => 'Administrator';

  @override
  String get roleModerator => 'Moderator';

  @override
  String get roleUser => 'Benutzer';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get sectionPaymentInfo => 'Zahlungsinformationen';

  @override
  String get sectionDisplay => 'Anzeige';

  @override
  String get sectionSecurity => 'Sicherheit';

  @override
  String get sectionAccount => 'Konto';

  @override
  String get paypalAddress => 'PayPal-Adresse';

  @override
  String get bitcoinWallet => 'Bitcoin-Wallet';

  @override
  String get notSpecified => 'Nicht angegeben';

  @override
  String get emailAddress => 'E-Mail-Adresse';

  @override
  String get emailHint => 'deine@email.com';

  @override
  String get walletAddress => 'Wallet-Adresse';

  @override
  String get walletHint => 'bc1q...';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get save => 'Speichern';

  @override
  String get paypalAddressSaved => 'PayPal-Adresse gespeichert';

  @override
  String get bitcoinWalletSaved => 'Bitcoin-Wallet gespeichert';

  @override
  String errorSaving(String error) {
    return 'Fehler beim Speichern: $error';
  }

  @override
  String get itemsPerPage => 'Elemente pro Seite';

  @override
  String itemsCount(int count) {
    return '$count Elemente';
  }

  @override
  String get displayCurrency => 'Anzeigewährung';

  @override
  String get language => 'Sprache';

  @override
  String get languageChanged =>
      'Sprache geändert. Bitte starte die App neu, um die Änderung zu übernehmen.';

  @override
  String get langEnglish => 'English';

  @override
  String get langGerman => 'Deutsch';

  @override
  String get langFrench => 'Français';

  @override
  String get langSpanish => 'Español';

  @override
  String get pgpKey => 'PGP-Schlüssel';

  @override
  String get configured => 'Eingerichtet';

  @override
  String get notConfigured => 'Noch nicht eingerichtet';

  @override
  String get changePassword => 'Passwort ändern';

  @override
  String get currentPassword => 'Aktuelles Passwort';

  @override
  String get newPassword => 'Neues Passwort';

  @override
  String get passwordsMismatch => 'Passwörter stimmen nicht überein';

  @override
  String get passwordChangeSuccess => 'Passwort erfolgreich geändert';

  @override
  String get passwordChangeError => 'Fehler beim Ändern des Passworts';

  @override
  String get changeButton => 'Ändern';

  @override
  String get logout => 'Abmelden';

  @override
  String get logoutConfirm => 'Möchtest du dich wirklich abmelden?';

  @override
  String get deleteAccount => 'Konto löschen';

  @override
  String get deleteAccountWarning =>
      'Diese Aktion kann nicht rückgängig gemacht werden. Alle deine Daten werden unwiderruflich gelöscht.';

  @override
  String get passwordConfirmation => 'Passwort zur Bestätigung';

  @override
  String get pleaseEnterPassword => 'Bitte gib dein Passwort ein';

  @override
  String get deleteAccountError => 'Fehler beim Löschen des Kontos';

  @override
  String genericError(String error) {
    return 'Fehler: $error';
  }

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String welcomeUser(String username) {
    return 'Willkommen, $username!';
  }

  @override
  String get userFallback => 'Benutzer';

  @override
  String get whatTodayQuestion => 'Was möchtest du heute tun?';

  @override
  String get sectionPendingRatings => 'Ausstehende Bewertungen';

  @override
  String get sectionNews => 'Neuigkeiten';

  @override
  String get sectionSlotWarnings => 'Slot-Warnungen';

  @override
  String get sectionRecentListings => 'Neueste Angebote';

  @override
  String get noNews => 'Keine Neuigkeiten';

  @override
  String get noNewsMessage =>
      'Aktuell gibt es keine Neuigkeiten. Schau später wieder vorbei!';

  @override
  String pendingRatingsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Du hast $count ausstehende Bewertungen',
      one: 'Du hast 1 ausstehende Bewertung',
    );
    return '$_temp0';
  }

  @override
  String transactionNumber(int id) {
    return 'Transaktion #$id';
  }

  @override
  String viewAllPendingRatings(int count) {
    return 'Alle $count ausstehenden Bewertungen anzeigen';
  }

  @override
  String get noSlotsExpiring =>
      'Keine Slots laufen in den nächsten 3 Tagen ab.';

  @override
  String slotsExpiringSoon(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Slots laufen bald ab',
      one: '1 Slot läuft bald ab',
    );
    return '$_temp0';
  }

  @override
  String slotNumber(int id) {
    return 'Slot #$id';
  }

  @override
  String listingNumber(int id) {
    return 'Listing #$id';
  }

  @override
  String get noListingLinked => 'Kein Listing verknüpft';

  @override
  String moreCount(int count) {
    return '+$count weitere';
  }

  @override
  String get noListingsYet => 'Noch keine Angebote';

  @override
  String get noListingsMessage =>
      'Hier werden die neuesten Angebote angezeigt.';

  @override
  String get unitPiece => 'Stück';

  @override
  String get unitKg => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitMeter => 'm';

  @override
  String get unitLiter => 'L';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get delete => 'Löschen';

  @override
  String get create => 'Erstellen';

  @override
  String get active => 'Aktiv';

  @override
  String get inactive => 'Inaktiv';

  @override
  String get required => 'Erforderlich';

  @override
  String get invalidInput => 'Ungültige Eingabe';

  @override
  String get shipping => 'Versand';

  @override
  String get shippingMethod => 'Versandart';

  @override
  String get shippingCost => 'Versandkosten';

  @override
  String get searchTitle => 'Suchen';

  @override
  String get favorites => 'Favoriten';

  @override
  String get searchListingsHint => 'Angebote suchen...';

  @override
  String get category => 'Kategorie';

  @override
  String get subcategory => 'Subkategorie';

  @override
  String get paymentMethod => 'Bezahlart';

  @override
  String get clearFilters => 'Filter löschen';

  @override
  String get noResults => 'Keine Ergebnisse';

  @override
  String get browseListings => 'Angebote durchsuchen';

  @override
  String get paypal => 'PayPal';

  @override
  String get bitcoin => 'Bitcoin';

  @override
  String get listingDetailTitle => 'Angebotsdetails';

  @override
  String get description => 'Beschreibung';

  @override
  String get details => 'Details';

  @override
  String get acceptedPaymentMethods => 'Akzeptierte Zahlungsmethoden';

  @override
  String get quantity => 'Menge';

  @override
  String get pricePerUnit => 'Preis pro Einheit';

  @override
  String get createdAt => 'Erstellt am';

  @override
  String get expiresAt => 'Läuft ab am';

  @override
  String get listingNotFound => 'Angebot nicht gefunden';

  @override
  String get tryAgain => 'Erneut versuchen';

  @override
  String get buyNow => 'Jetzt kaufen';

  @override
  String get contactSeller => 'Verkäufer kontaktieren';

  @override
  String get createListingTitle => 'Neues Angebot';

  @override
  String get editListingTitle => 'Angebot bearbeiten';

  @override
  String get title => 'Titel';

  @override
  String get titleHint => 'Gib einen Titel ein';

  @override
  String get titleRequired => 'Titel ist erforderlich';

  @override
  String get descriptionHint => 'Beschreibe dein Angebot...';

  @override
  String get descriptionRequired => 'Beschreibung ist erforderlich';

  @override
  String get price => 'Preis';

  @override
  String get priceHint => '0.00';

  @override
  String get priceRequired => 'Preis ist erforderlich';

  @override
  String get priceInvalid => 'Preis muss größer als 0 sein';

  @override
  String get quantityHint => '1';

  @override
  String get quantityRequired => 'Menge ist erforderlich';

  @override
  String get quantityInvalid => 'Menge muss größer als 0 sein';

  @override
  String get unit => 'Einheit';

  @override
  String get selectCategory => 'Kategorie wählen';

  @override
  String get selectSubcategory => 'Subkategorie wählen';

  @override
  String get categoryRequired => 'Kategorie ist erforderlich';

  @override
  String get images => 'Bilder';

  @override
  String get addImages => 'Bilder hinzufügen';

  @override
  String get selectPaymentMethods => 'Zahlungsmethoden wählen';

  @override
  String get atLeastOnePaymentMethod =>
      'Mindestens eine Zahlungsmethode erforderlich';

  @override
  String get shippingOptions => 'Versandoptionen';

  @override
  String get shippingAvailable => 'Versand verfügbar';

  @override
  String get shippingCostHint => '5.00';

  @override
  String get listingCreated => 'Angebot erstellt';

  @override
  String get listingUpdated => 'Angebot aktualisiert';

  @override
  String get errorCreatingListing => 'Fehler beim Erstellen des Angebots';

  @override
  String get errorUpdatingListing => 'Fehler beim Aktualisieren des Angebots';

  @override
  String get deleteListing => 'Angebot löschen';

  @override
  String get deleteListingConfirm =>
      'Möchtest du dieses Angebot wirklich löschen?';

  @override
  String get listingDeleted => 'Angebot gelöscht';

  @override
  String get errorDeletingListing => 'Fehler beim Löschen des Angebots';

  @override
  String get slot => 'Slot';

  @override
  String get selectSlot => 'Slot wählen';

  @override
  String get slotRequired => 'Slot ist erforderlich';

  @override
  String get noSlotsAvailable => 'Keine Slots verfügbar';

  @override
  String get loading => 'Lädt...';

  @override
  String get retry => 'Wiederholen';

  @override
  String get searchEmptyStateMessage =>
      'Gib einen Suchbegriff ein oder wähle Filter aus, um Angebote zu finden.';

  @override
  String get noResultsMessage =>
      'Versuche andere Suchbegriffe oder passe die Filter an.';

  @override
  String get resetFilters => 'Filter zurücksetzen';

  @override
  String get noCategory => 'Keine Kategorie';

  @override
  String get allSubcategories => 'Alle Subkategorien';

  @override
  String get allPaymentMethods => 'Alle Bezahlarten';

  @override
  String searchError(String error) {
    return 'Fehler bei der Suche: $error';
  }

  @override
  String resultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Ergebnisse',
      one: '1 Ergebnis',
    );
    return '$_temp0';
  }
}
