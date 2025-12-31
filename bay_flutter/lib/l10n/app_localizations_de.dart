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

  @override
  String get transactions => 'Transaktionen';

  @override
  String purchases(int count) {
    return 'Käufe ($count)';
  }

  @override
  String sales(int count) {
    return 'Verkäufe ($count)';
  }

  @override
  String get refresh => 'Aktualisieren';

  @override
  String get noPurchasesYet => 'Noch keine Käufe';

  @override
  String get noSalesYet => 'Noch keine Verkäufe';

  @override
  String get yourPurchasesWillAppearHere => 'Deine Käufe werden hier angezeigt';

  @override
  String get yourSalesWillAppearHere => 'Deine Verkäufe werden hier angezeigt';

  @override
  String get statusOpen => 'Offen';

  @override
  String get statusPaid => 'Bezahlt';

  @override
  String get statusShipped => 'Versendet';

  @override
  String get statusReceived => 'Erhalten';

  @override
  String get statusCompleted => 'Abgeschlossen';

  @override
  String get statusDisputed => 'Umstritten';

  @override
  String get statusCancelled => 'Abgebrochen';

  @override
  String get autoCompletesToday => 'Wird heute automatisch abgeschlossen';

  @override
  String autoCompletesInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tagen',
      one: 'Tag',
    );
    return 'Wird in $count $_temp0 automatisch abgeschlossen';
  }

  @override
  String get transaction => 'Transaktion';

  @override
  String get rateThisTransaction => 'Bewerte diese Transaktion';

  @override
  String shareYourExperience(String username) {
    return 'Teile deine Erfahrung mit $username';
  }

  @override
  String get rateNow => 'Jetzt bewerten';

  @override
  String get alreadyRated => 'Du hast diese Transaktion bereits bewertet';

  @override
  String get statusOpenDesc => 'Warte auf Zahlung des Käufers';

  @override
  String get statusPaidDesc =>
      'Zahlung gesendet, warte auf Versand durch Verkäufer';

  @override
  String get statusShippedDesc =>
      'Artikel wurde versendet, warte auf Zustellung';

  @override
  String get statusReceivedDesc => 'Käufer hat den Artikel erhalten';

  @override
  String get statusCompletedDesc => 'Transaktion erfolgreich abgeschlossen';

  @override
  String get statusDisputedDesc => 'Ein Streitfall wurde eröffnet';

  @override
  String get statusCancelledDesc => 'Transaktion wurde abgebrochen';

  @override
  String get timeline => 'Zeitverlauf';

  @override
  String get created => 'Erstellt';

  @override
  String get paid => 'Bezahlt';

  @override
  String get paymentSent => 'Zahlung gesendet';

  @override
  String get waitingForBuyer => 'Warte auf Käufer';

  @override
  String get shipped => 'Versendet';

  @override
  String get waitingForSeller => 'Warte auf Verkäufer';

  @override
  String get received => 'Erhalten';

  @override
  String get completed => 'Abgeschlossen';

  @override
  String get cancelled => 'Abgebrochen';

  @override
  String get pending => 'Ausstehend';

  @override
  String get markAsShipped => 'Als versendet markieren';

  @override
  String get markAsPaid => 'Als bezahlt markieren';

  @override
  String get markAsReceived => 'Als erhalten markieren';

  @override
  String get cancelTransaction => 'Transaktion abbrechen';

  @override
  String get openDispute => 'Streitfall eröffnen';

  @override
  String get actions => 'Aktionen';

  @override
  String get confirmShipment =>
      'Bestätige, dass du den Artikel versendet hast. Der Käufer hat 14 Tage Zeit, den Erhalt zu bestätigen oder einen Streitfall zu eröffnen.';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get transactionMarkedAsShipped => 'Transaktion als versendet markiert';

  @override
  String get confirmPayment =>
      'Bestätige, dass du die Zahlung an den Verkäufer gesendet hast.';

  @override
  String get paymentMarkedAsSent => 'Zahlung als gesendet markiert';

  @override
  String get confirmReceipt =>
      'Bestätige, dass du den Artikel erhalten hast. Dies wird die Transaktion abschließen.';

  @override
  String get transactionCompleted => 'Transaktion abgeschlossen';

  @override
  String get cancelTransactionConfirm =>
      'Möchtest du diese Transaktion wirklich abbrechen? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get keep => 'Behalten';

  @override
  String get transactionCancelled => 'Transaktion abgebrochen';

  @override
  String get describeIssue =>
      'Bitte beschreibe das Problem mit dieser Transaktion. Ein Moderator wird deinen Streitfall prüfen.';

  @override
  String get reason => 'Grund';

  @override
  String get describeProblem => 'Beschreibe das Problem...';

  @override
  String get pleaseEnterReason => 'Bitte gib einen Grund an';

  @override
  String get disputeOpened => 'Streitfall eröffnet';

  @override
  String get transactionNotFound => 'Transaktion nicht gefunden';

  @override
  String get transactionId => 'Transaktions-ID';

  @override
  String get totalPrice => 'Gesamtpreis';

  @override
  String get parties => 'Parteien';

  @override
  String get buyer => 'Käufer';

  @override
  String get seller => 'Verkäufer';

  @override
  String get you => 'Du';

  @override
  String get viewListingDetails => 'Angebotsdetails anzeigen';

  @override
  String get buyerNote => 'Käufernotiz';

  @override
  String get autoCompleteWarning => 'Auto-Abschluss Warnung';

  @override
  String get autoCompleteToday =>
      'Diese Transaktion wird heute automatisch abgeschlossen, wenn kein Streitfall eröffnet wird.';

  @override
  String autoCompleteInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tagen',
      one: 'Tag',
    );
    return 'Diese Transaktion wird in $count $_temp0 automatisch abgeschlossen, wenn keine Aktion erfolgt.';
  }

  @override
  String get disputeOpen => 'Streitfall offen';

  @override
  String disputeReason(String reason) {
    return 'Grund: $reason';
  }

  @override
  String disputeOpenedDate(String date) {
    return 'Eröffnet: $date';
  }

  @override
  String get moderatorReviewing => 'Ein Moderator prüft diesen Streitfall.';

  @override
  String get paymentInformation => 'Zahlungsinformationen';

  @override
  String get sendPaymentTo =>
      'Bitte sende die Zahlung an den Verkäufer mit den folgenden Details:';

  @override
  String get includeTransactionId =>
      'Der Verkäufer wird den Artikel versenden, sobald die Zahlung eingegangen ist. Bitte gib deine Transaktions-ID in der Zahlungsnotiz an.';

  @override
  String get messages => 'Nachrichten';

  @override
  String get inbox => 'Posteingang';

  @override
  String get sent => 'Gesendet';

  @override
  String get drafts => 'Entwürfe';

  @override
  String get newMessage => 'Neue Nachricht';

  @override
  String get noMessages => 'Keine Nachrichten';

  @override
  String get inboxEmpty => 'Dein Posteingang ist leer.';

  @override
  String get noSentMessages => 'Keine gesendeten Nachrichten';

  @override
  String get noSentMessagesYet => 'Du hast noch keine Nachrichten gesendet.';

  @override
  String get noDrafts => 'Keine Entwürfe';

  @override
  String get noSavedDrafts => 'Du hast keine gespeicherten Entwürfe.';

  @override
  String get errorLoading => 'Fehler beim Laden';

  @override
  String from(String username) {
    return 'Von: $username';
  }

  @override
  String to(String username) {
    return 'An: $username';
  }

  @override
  String get yesterday => 'Gestern';

  @override
  String get monday => 'Mo';

  @override
  String get tuesday => 'Di';

  @override
  String get wednesday => 'Mi';

  @override
  String get thursday => 'Do';

  @override
  String get friday => 'Fr';

  @override
  String get saturday => 'Sa';

  @override
  String get sunday => 'So';

  @override
  String userNumber(int id) {
    return 'Benutzer #$id';
  }

  @override
  String get noRecipient => 'Kein Empfänger';

  @override
  String lastEdited(String date) {
    return 'Zuletzt bearbeitet: $date';
  }

  @override
  String get deleteMessage => 'Nachricht löschen?';

  @override
  String get actionCannotBeUndone =>
      'Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get deleteDraft => 'Entwurf löschen?';

  @override
  String get reply => 'Antworten';

  @override
  String get decryptingMessage => 'Nachricht wird entschlüsselt...';

  @override
  String get decryptionFailed => 'Entschlüsselung fehlgeschlagen';

  @override
  String get endToEndEncrypted => 'Ende-zu-Ende verschlüsselt';

  @override
  String fromUser(String username) {
    return 'Von: $username';
  }

  @override
  String dateLabel(String date) {
    return 'Datum: $date';
  }

  @override
  String get subject => 'Betreff';

  @override
  String get noSubject => '[Kein Betreff]';

  @override
  String get message => 'Nachricht';

  @override
  String get noContent => '[Kein Inhalt]';

  @override
  String get editDraft => 'Entwurf bearbeiten';

  @override
  String get draft => 'Entwurf';

  @override
  String get send => 'Senden';

  @override
  String get recipient => 'Empfänger';

  @override
  String get enterUsername => 'Benutzername eingeben';

  @override
  String get messageWillBeEncrypted => 'Nachricht wird verschlüsselt';

  @override
  String get clickToVerifyRecipient =>
      'Klicke auf das Such-Icon um den Empfänger zu prüfen';

  @override
  String userNotFoundOrNoKey(String username) {
    return 'Benutzer \"$username\" nicht gefunden oder hat keinen PGP-Schlüssel';
  }

  @override
  String get pleaseSelectRecipient => 'Bitte wähle einen Empfänger';

  @override
  String get recipientNotVerified =>
      'Empfänger nicht verifiziert oder kein PGP-Schlüssel vorhanden. Bitte Empfänger prüfen.';

  @override
  String get pleaseEnterSubject => 'Bitte gib einen Betreff ein';

  @override
  String get pleaseEnterMessage => 'Bitte gib eine Nachricht ein';

  @override
  String errorSending(String error) {
    return 'Fehler beim Senden: $error';
  }

  @override
  String get draftSaved => 'Entwurf gespeichert';

  @override
  String errorSavingDraft(String error) {
    return 'Fehler beim Speichern: $error';
  }
}
