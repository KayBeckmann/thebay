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
  String get passwordMinLength => 'Passwort muss mindestens 8 Zeichen haben';

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
  String get generatingKey => 'Schlüssel wird generiert...';

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
  String get pleaseEnterPassword => 'Bitte gib das Passwort ein';

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
  String get details => 'Details:';

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
  String get shareYourExperience => 'Teile deine Erfahrung...';

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
  String get errorLoadingTitle => 'Fehler beim Laden';

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
  String get decryptionFailed => '[Entschlüsselung fehlgeschlagen]';

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

  @override
  String get pgpKeys => 'PGP-Schlüssel';

  @override
  String get keyInformation => 'Schlüssel-Informationen';

  @override
  String get generateNewKey => 'Neuen Schlüssel generieren';

  @override
  String get exportKey => 'Schlüssel exportieren';

  @override
  String get importKey => 'Schlüssel importieren';

  @override
  String get serverBackup => 'Server-Backup';

  @override
  String get securityNotices => 'Sicherheitshinweise';

  @override
  String get setBackupPassword => 'Backup-Passwort festlegen';

  @override
  String get generateKey => 'Schlüssel generieren';

  @override
  String get privateKeyExport => 'Private Key Export';

  @override
  String get importPrivateKey => 'Private Key importieren';

  @override
  String get keyConfigured => 'Schlüssel eingerichtet';

  @override
  String get keyIncomplete => 'Schlüssel nicht vollständig';

  @override
  String get canSendEncryptedMessages =>
      'Du kannst verschlüsselte Nachrichten senden und empfangen.';

  @override
  String get generateOrImportKey =>
      'Generiere einen neuen Schlüssel oder importiere einen vorhandenen.';

  @override
  String get privateKeyLocalPublicKeyMissing =>
      'Private Key vorhanden, aber Public Key nicht auf dem Server.';

  @override
  String get publicKeyOnServerPrivateKeyMissing =>
      'Public Key auf Server, aber Private Key fehlt lokal.';

  @override
  String get keysMismatch => 'Schlüssel stimmen nicht überein.';

  @override
  String get exportPrivateKeyForBackup =>
      'Exportiere deinen Private Key für ein Backup. Bewahre ihn sicher auf!';

  @override
  String get importExistingPrivateKey =>
      'Importiere einen vorhandenen Private Key (z.B. von einem Backup oder anderem Gerät).';

  @override
  String get storePrivateKeyEncryptedOnServer =>
      'Speichere deinen Private Key verschlüsselt auf dem Server. So kannst du ihn auf einem anderen Gerät wiederherstellen.';

  @override
  String get securityWarning => 'Sicherheitshinweis';

  @override
  String get aboutToStorePrivateKeyOnServer =>
      'Du bist dabei, deinen Private Key auf dem Server zu speichern.';

  @override
  String get keyWillBeEncryptedBeforeUpload =>
      'Der Key wird mit einem Passwort verschlüsselt, bevor er hochgeladen wird. Trotzdem solltest du folgendes beachten:';

  @override
  String get chooseStrongUniquePassword =>
      'Wähle ein starkes, einzigartiges Passwort';

  @override
  String get passwordCannotBeReset =>
      'Dieses Passwort kann NICHT zurückgesetzt werden';

  @override
  String get backupWorthlessWithoutPassword =>
      'Ohne Passwort ist das Backup wertlos';

  @override
  String get serverOperatorMightGuessPassword =>
      'Der Server-Betreiber könnte versuchen, das Passwort zu erraten';

  @override
  String get chooseStrongPasswordForBackup =>
      'Wähle ein starkes Passwort für dein Backup. Du brauchst es, um den Key wiederherzustellen.';

  @override
  String get passwordsDontMatch => 'Passwörter stimmen nicht überein';

  @override
  String get pleaseEnterName => 'Bitte gib einen Namen ein';

  @override
  String get enterPasswordForBackup =>
      'Gib das Passwort ein, mit dem du das Backup verschlüsselt hast:';

  @override
  String get decryptingAndImporting => 'Entschlüssele und importiere...';

  @override
  String get decryptionFailedWrongPassword =>
      'Entschlüsselung fehlgeschlagen. Falsches Passwort?';

  @override
  String get understandProceed => 'Ich verstehe, fortfahren';

  @override
  String get uploadPublicKey => 'Public Key hochladen';

  @override
  String get generating => 'Generiere...';

  @override
  String get exportPrivateKey => 'Private Key exportieren';

  @override
  String get pastePrivateKey => 'Private Key einfügen';

  @override
  String get loadFromServerBackup => 'Vom Server-Backup laden';

  @override
  String get createEncryptedBackup => 'Verschlüsseltes Backup erstellen';

  @override
  String get copyFingerprint => 'Fingerprint kopieren';

  @override
  String get createBackup => 'Backup erstellen';

  @override
  String get restore => 'Wiederherstellen';

  @override
  String get errorLoading => 'Fehler beim Laden';

  @override
  String get existingKeyWillBeReplaced =>
      'Der vorhandene Schlüssel wird ersetzt!';

  @override
  String get invalidKeyAfterDecryption => 'Ungültiger Key nach Entschlüsselung';

  @override
  String get noPrivateKey => 'Kein Private Key vorhanden';

  @override
  String get noFingerprint => 'Kein Fingerprint vorhanden';

  @override
  String get backupSuccessfullySaved =>
      'Backup erfolgreich auf Server gespeichert!';

  @override
  String errorBackup(String error) {
    return 'Fehler beim Backup: $error';
  }

  @override
  String get noBackupOnServer => 'Kein Backup auf dem Server gefunden.';

  @override
  String errorGeneration(String error) {
    return 'Fehler bei der Generierung: $error';
  }

  @override
  String get keySuccessfullyGenerated =>
      'Schlüssel erfolgreich generiert und hochgeladen!';

  @override
  String errorUploading(String error) {
    return 'Fehler beim Hochladen: $error';
  }

  @override
  String get privateKeyNeverLeavesDevice =>
      'Dein Private Key verlässt niemals dieses Gerät';

  @override
  String get onlyPublicKeyStoredOnServer =>
      'Nur der Public Key wird auf dem Server gespeichert';

  @override
  String get regularBackupsRecommended =>
      'Erstelle regelmäßig Backups deines Private Keys';

  @override
  String get lostKeyCannotDecryptOldMessages =>
      'Bei Verlust des Keys können alte Nachrichten nicht entschlüsselt werden';

  @override
  String get createsNewEd25519Key =>
      'Erstellt einen neuen Ed25519/Curve25519 Schlüssel. Dies dauert nur wenige Sekunden.';

  @override
  String get generatingEd25519Key =>
      'Ed25519/Curve25519 Schlüssel wird erstellt. Dies dauert nur wenige Sekunden.';

  @override
  String get keySuccessfullyRestored =>
      'Schlüssel erfolgreich wiederhergestellt!';

  @override
  String get protectWithPassphrase => 'Mit Passphrase schützen';

  @override
  String get recommendedForSecurity => 'Empfohlen für zusätzliche Sicherheit';

  @override
  String get passphrase => 'Passphrase';

  @override
  String get enterSecurePassphrase => 'Sichere Passphrase eingeben';

  @override
  String get name => 'Name';

  @override
  String get yourName => 'Dein Name';

  @override
  String get emailOptional => 'E-Mail (optional)';

  @override
  String get yourEmailCom => 'deine@email.com';

  @override
  String get fingerprint => 'Fingerprint';

  @override
  String get algorithm => 'Algorithmus';

  @override
  String get keySize => 'Schlüsselgröße';

  @override
  String get identity => 'Identität';

  @override
  String get keepKeySafe =>
      'Bewahre diesen Schlüssel sicher auf! Teile ihn niemals mit anderen.';

  @override
  String get pastePrivateKeyInPgpFormat =>
      'Füge deinen Private Key im PGP-Armor Format ein:';

  @override
  String get beginPgpPrivateKeyBlock => '-----BEGIN PGP PRIVATE KEY BLOCK-----';

  @override
  String get pleasePasteKey => 'Bitte füge einen Key ein';

  @override
  String get invalidKeyFormat => 'Ungültiges Key-Format';

  @override
  String get privateKeySuccessfullyImported =>
      'Private Key erfolgreich importiert!';

  @override
  String get selectBackupToRestore =>
      'Wähle das Backup aus, das du wiederherstellen möchtest:';

  @override
  String get selectBackup => 'Backup auswählen';

  @override
  String get decryptBackup => 'Backup entschlüsseln';

  @override
  String copiedToClipboard(String label) {
    return '$label in die Zwischenablage kopiert';
  }

  @override
  String get publicKeySuccessfullyUploaded =>
      'Public Key erfolgreich hochgeladen!';

  @override
  String get backupPassword => 'Backup-Passwort';

  @override
  String get keyGenerationTooLong =>
      'Schlüsselgenerierung dauert zu lange. Bitte versuche es erneut oder starte die App neu.';

  @override
  String get noOwnPgpKey =>
      'Kein eigener PGP-Schlüssel vorhanden. Bitte lade deinen Public Key hoch.';

  @override
  String get recipientHasNoPgpKey => 'Empfänger hat keinen PGP-Schlüssel';

  @override
  String get adminPanel => 'Admin-Panel';

  @override
  String get adminPanelWelcome => 'Willkommen im Admin-Bereich';

  @override
  String get userManagement => 'Benutzerverwaltung';

  @override
  String get categoryManagement => 'Kategorienverwaltung';

  @override
  String get newsManagement => 'News-Verwaltung';

  @override
  String get paymentSettings => 'Zahlungseinstellungen';

  @override
  String get pendingPayments => 'Ausstehende Zahlungen';

  @override
  String get slotVariants => 'Slot-Varianten';

  @override
  String get moderatorPanel => 'Moderator-Panel';

  @override
  String get moderatorPanelWelcome => 'Willkommen im Moderations-Bereich';

  @override
  String get reports => 'Meldungen';

  @override
  String get disputes => 'Streitfälle';

  @override
  String get allReports => 'Alle';

  @override
  String get openReports => 'Offen';

  @override
  String get inReviewReports => 'In Prüfung';

  @override
  String get resolvedReports => 'Gelöst';

  @override
  String get dismissedReports => 'Abgewiesen';

  @override
  String get statusReportOpen => 'OFFEN';

  @override
  String get statusReportInReview => 'IN PRÜFUNG';

  @override
  String get statusReportResolved => 'GELÖST';

  @override
  String get statusReportDismissed => 'ABGEWIESEN';

  @override
  String get reportedBy => 'Gemeldet von';

  @override
  String get reportedUser => 'Gemeldeter Benutzer';

  @override
  String get reportedListing => 'Gemeldetes Angebot';

  @override
  String get reportReason => 'Grund';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonInappropriate => 'Unangemessener Inhalt';

  @override
  String get reportReasonScam => 'Betrug/Scam';

  @override
  String get reportReasonHarassment => 'Belästigung';

  @override
  String get reportReasonFakeInfo => 'Falsche Informationen';

  @override
  String get reportReasonOther => 'Sonstiges';

  @override
  String get noReports => 'Keine Meldungen';

  @override
  String get noReportsMessage => 'Es gibt aktuell keine Meldungen zu prüfen.';

  @override
  String get viewReport => 'Meldung ansehen';

  @override
  String get reportDetail => 'Meldungsdetails';

  @override
  String reportId(int id) {
    return 'Meldung #$id';
  }

  @override
  String get reportType => 'Typ';

  @override
  String get reportTypeUser => 'Benutzer';

  @override
  String get reportTypeListing => 'Angebot';

  @override
  String get reportedAt => 'Gemeldet am';

  @override
  String get reportDescription => 'Beschreibung';

  @override
  String get moderatorNotes => 'Moderator-Notizen';

  @override
  String get addNote => 'Notiz hinzufügen';

  @override
  String get internalNotesOnly => 'Nur für Moderatoren sichtbar';

  @override
  String get enterNote => 'Notiz eingeben...';

  @override
  String get noteSaved => 'Notiz wurde gespeichert';

  @override
  String get takeAction => 'Maßnahme ergreifen';

  @override
  String get markAsInReview => 'Als in Prüfung markieren';

  @override
  String get resolveReport => 'Meldung lösen';

  @override
  String get dismissReport => 'Meldung abweisen';

  @override
  String get viewReportedUser => 'Gemeldeten Benutzer ansehen';

  @override
  String get viewReportedListing => 'Gemeldetes Angebot ansehen';

  @override
  String get warnUser => 'Benutzer verwarnen';

  @override
  String get banUser => 'Benutzer sperren';

  @override
  String get reportMarkedInReview => 'Meldung als in Prüfung markiert';

  @override
  String get reportResolved => 'Meldung gelöst';

  @override
  String get reportDismissed => 'Meldung abgewiesen';

  @override
  String get confirmResolveReport =>
      'Möchtest du diese Meldung als gelöst markieren?';

  @override
  String get confirmDismissReport => 'Möchtest du diese Meldung abweisen?';

  @override
  String get resolve => 'Lösen';

  @override
  String get dismiss => 'Abweisen';

  @override
  String get userDetail => 'Benutzerdetails';

  @override
  String userId(int id) {
    return 'ID: $id';
  }

  @override
  String get registeredAt => 'Registriert am';

  @override
  String get lastActive => 'Zuletzt aktiv';

  @override
  String get totalListings => 'Angebote gesamt';

  @override
  String get totalTransactions => 'Transaktionen gesamt';

  @override
  String get userRating => 'Bewertung';

  @override
  String get userStatus => 'Status';

  @override
  String get userStatusActive => 'Aktiv';

  @override
  String get userStatusBanned => 'Gesperrt';

  @override
  String get userStatusWarned => 'Verwarnt';

  @override
  String get banUserDialog => 'Benutzer sperren';

  @override
  String banReason(String reason) {
    return 'Grund: $reason';
  }

  @override
  String get selectBanReason => 'Sperrgrund wählen';

  @override
  String get banReasonSpam => 'Spam';

  @override
  String get banReasonScam => 'Betrug';

  @override
  String get banReasonHarassment => 'Belästigung anderer Nutzer';

  @override
  String get banReasonIllegalContent => 'Illegaler Inhalt';

  @override
  String get banReasonMultipleViolations => 'Mehrfache Verstöße';

  @override
  String get banReasonOther => 'Sonstiges';

  @override
  String get banDuration => 'Sperrdauer';

  @override
  String get banDuration24h => '24 Stunden';

  @override
  String get banDuration7d => '7 Tage';

  @override
  String get banDuration30d => '30 Tage';

  @override
  String get banDurationPermanent => 'Permanent';

  @override
  String get additionalNotes => 'Zusätzliche Notizen';

  @override
  String get optionalNotes => 'Optional: Zusätzliche Informationen...';

  @override
  String get confirmBanUser => 'Möchtest du diesen Benutzer wirklich sperren?';

  @override
  String get ban => 'Sperren';

  @override
  String get userBanned => 'Benutzer wurde gesperrt';

  @override
  String get userWarned => 'Benutzer verwarnt';

  @override
  String get newsManagementScreen => 'News-Verwaltung';

  @override
  String get allNews => 'Alle News';

  @override
  String get publishedNews => 'Veröffentlicht';

  @override
  String get draftNews => 'Entwürfe';

  @override
  String get createNews => 'News erstellen';

  @override
  String get noNewsItems => 'Keine News vorhanden';

  @override
  String get noNewsItemsMessage => 'Es wurden noch keine News erstellt.';

  @override
  String get newsTitle => 'Titel';

  @override
  String get newsContent => 'Inhalt';

  @override
  String get newsStatus => 'Status';

  @override
  String get newsStatusPublished => 'Veröffentlicht';

  @override
  String get newsStatusDraft => 'Entwurf';

  @override
  String get publishedAt => 'Veröffentlicht am';

  @override
  String get editNews => 'News bearbeiten';

  @override
  String get deleteNews => 'News löschen';

  @override
  String get createNewsItem => 'News erstellen';

  @override
  String get editNewsItem => 'News bearbeiten';

  @override
  String get enterNewsTitle => 'News-Titel eingeben';

  @override
  String get enterNewsContent => 'News-Inhalt eingeben...';

  @override
  String get newsTitleRequired => 'Titel ist erforderlich';

  @override
  String get newsContentRequired => 'Inhalt ist erforderlich';

  @override
  String get publish => 'Veröffentlichen';

  @override
  String get saveAsDraft => 'Als Entwurf speichern';

  @override
  String get newsCreated => 'News erstellt';

  @override
  String get newsUpdated => 'News aktualisiert';

  @override
  String get newsDeleted => 'News gelöscht';

  @override
  String get confirmDeleteNews => 'Möchtest du diese News wirklich löschen?';

  @override
  String confirmDeleteNewsWithTitle(String title) {
    return 'Möchtest du \"$title\" wirklich löschen?';
  }

  @override
  String get deleteExpired => 'Abgelaufene löschen';

  @override
  String get deleteExpiredNews => 'Abgelaufene News löschen';

  @override
  String get confirmDeleteExpiredNews =>
      'Möchtest du alle abgelaufenen News löschen?';

  @override
  String expiredNewsDeleted(int count) {
    return '$count abgelaufene News gelöscht';
  }

  @override
  String get newsStatusExpired => 'Abgelaufen';

  @override
  String createdLabel(String date) {
    return 'Erstellt: $date';
  }

  @override
  String expiresLabel(String date) {
    return 'Läuft ab: $date';
  }

  @override
  String get markdownSupported => 'Markdown wird unterstützt';

  @override
  String get lifetimeDays => 'Lebenszeit (Tage)';

  @override
  String get defaultLifetimeDays => 'Standard: 14 Tage';

  @override
  String get expiryDate => 'Ablaufdatum';

  @override
  String get noExpiryDate => 'Kein Ablaufdatum';

  @override
  String get publishNewsMessage => 'News wird auf dem Dashboard angezeigt';

  @override
  String get titleContentRequired => 'Titel und Inhalt dürfen nicht leer sein';

  @override
  String get createFirstNews => 'Erstelle die erste News mit dem + Button.';

  @override
  String errorDeleting(String error) {
    return 'Fehler beim Löschen: $error';
  }

  @override
  String get categoryManagementScreen => 'Kategorienverwaltung';

  @override
  String get categories => 'Kategorien';

  @override
  String get subcategories => 'Subkategorien';

  @override
  String get createCategory => 'Kategorie erstellen';

  @override
  String get createSubcategory => 'Subkategorie erstellen';

  @override
  String get noCategories => 'Keine Kategorien';

  @override
  String get noCategoriesMessage => 'Es wurden noch keine Kategorien erstellt.';

  @override
  String get noSubcategories => 'Keine Subkategorien';

  @override
  String get noSubcategoriesMessage =>
      'Es wurden noch keine Subkategorien erstellt.';

  @override
  String get categoryName => 'Name';

  @override
  String get categoryDescription => 'Beschreibung';

  @override
  String get parentCategory => 'Übergeordnete Kategorie';

  @override
  String get listingsCount => 'Angebote';

  @override
  String get editCategory => 'Kategorie bearbeiten';

  @override
  String get deleteCategory => 'Kategorie löschen';

  @override
  String get createCategoryDialog => 'Kategorie erstellen';

  @override
  String get editCategoryDialog => 'Kategorie bearbeiten';

  @override
  String get enterCategoryName => 'Kategoriename eingeben';

  @override
  String get enterCategoryDescription => 'Beschreibung eingeben (optional)';

  @override
  String get categoryNameRequired => 'Name ist erforderlich';

  @override
  String get categoryCreated => 'Kategorie erstellt';

  @override
  String get categoryUpdated => 'Kategorie aktualisiert';

  @override
  String get categoryDeleted => 'Kategorie gelöscht';

  @override
  String get confirmDeleteCategory =>
      'Möchtest du diese Kategorie wirklich löschen? Alle zugehörigen Subkategorien werden ebenfalls gelöscht.';

  @override
  String confirmDeleteCategoryWithName(String name) {
    return 'Möchtest du \"$name\" wirklich löschen?';
  }

  @override
  String get newCategory => 'Neue Kategorie';

  @override
  String get addSubcategory => 'Unterkategorie hinzufügen';

  @override
  String get createFirstCategory =>
      'Erstelle die erste Kategorie mit dem + Button.';

  @override
  String subcategoriesCount(int count, int sortOrder) {
    return '$count Unterkategorien • Sortierung: $sortOrder';
  }

  @override
  String get sorting => 'Sortierung';

  @override
  String sortingLabel(int sortOrder) {
    return 'Sortierung: $sortOrder';
  }

  @override
  String get sortingHint => '0';

  @override
  String get categoryShownToUsers => 'Kategorie wird Benutzern angezeigt';

  @override
  String categoryHasSubcategories(int count) {
    return 'Diese Kategorie hat $count Unterkategorien, die ebenfalls gelöscht werden!';
  }

  @override
  String get nameRequired => 'Name darf nicht leer sein';

  @override
  String get paymentSettingsScreen => 'Zahlungseinstellungen';

  @override
  String get paymentMethods => 'Zahlungsmethoden';

  @override
  String get fees => 'Gebühren';

  @override
  String get paypalEnabled => 'PayPal aktiviert';

  @override
  String get bitcoinEnabled => 'Bitcoin aktiviert';

  @override
  String get transactionFee => 'Transaktionsgebühr';

  @override
  String get platformFee => 'Plattformgebühr';

  @override
  String get feePercentage => 'Prozentsatz';

  @override
  String get minimumFee => 'Mindestgebühr';

  @override
  String get maximumFee => 'Höchstgebühr';

  @override
  String get settingsSaved => 'Einstellungen gespeichert';

  @override
  String get saveSettings => 'Einstellungen speichern';

  @override
  String get paymentSettingsInfo =>
      'Diese Einstellungen bestimmen, wie Benutzer für Slots bezahlen können.';

  @override
  String get enablePaypal => 'PayPal aktivieren';

  @override
  String get paypalPaymentDescription => 'Benutzer können mit PayPal bezahlen';

  @override
  String get paypalEmailAddress => 'PayPal E-Mail-Adresse';

  @override
  String get paypalEmailHint => 'zahlungen@beispiel.com';

  @override
  String get enableBitcoin => 'Bitcoin aktivieren';

  @override
  String get bitcoinPaymentDescription =>
      'Benutzer können mit Bitcoin bezahlen';

  @override
  String get bitcoinWalletAddress => 'Bitcoin Wallet-Adresse';

  @override
  String get bitcoinWalletHint => 'bc1q...';

  @override
  String get pendingPaymentsScreen => 'Ausstehende Zahlungen';

  @override
  String get allPendingPayments => 'Alle';

  @override
  String get paypalPayments => 'PayPal';

  @override
  String get bitcoinPayments => 'Bitcoin';

  @override
  String get noPendingPayments => 'Keine ausstehenden Zahlungen';

  @override
  String get noPendingPaymentsMessage =>
      'Es gibt aktuell keine ausstehenden Zahlungen zu bearbeiten.';

  @override
  String get paymentId => 'Zahlungs-ID';

  @override
  String get amount => 'Betrag';

  @override
  String get requestedAt => 'Angefordert am';

  @override
  String get paymentStatus => 'Status';

  @override
  String get paymentStatusPending => 'Ausstehend';

  @override
  String get paymentStatusProcessing => 'In Bearbeitung';

  @override
  String get paymentStatusCompleted => 'Abgeschlossen';

  @override
  String get paymentStatusFailed => 'Fehlgeschlagen';

  @override
  String get processPayment => 'Zahlung bearbeiten';

  @override
  String get checkBitcoinPayments => 'Bitcoin-Zahlungen prüfen';

  @override
  String get expireOldOrders => 'Alte Bestellungen ablaufen lassen';

  @override
  String get confirmPaymentTitle => 'Zahlung bestätigen';

  @override
  String confirmPaymentMessage(int orderId, String amount, String method) {
    return 'Möchten Sie die Zahlung für Bestellung #$orderId wirklich bestätigen?\n\nBetrag: $amount\nMethode: $method';
  }

  @override
  String get paymentConfirmedSlotActivated =>
      'Zahlung bestätigt und Slot aktiviert';

  @override
  String bitcoinPaymentsProcessed(int count) {
    return '$count Bitcoin-Zahlungen verarbeitet';
  }

  @override
  String get expireOldOrdersTitle => 'Alte Bestellungen ablaufen lassen';

  @override
  String get expireOldOrdersMessage =>
      'Möchten Sie alle ausstehenden Bestellungen, die älter als 24 Stunden sind, als abgelaufen markieren?';

  @override
  String get expireAction => 'Ablaufen lassen';

  @override
  String ordersExpired(int count) {
    return '$count Bestellungen als abgelaufen markiert';
  }

  @override
  String get allPaymentsProcessed => 'Alle Zahlungen wurden verarbeitet';

  @override
  String orderNumber(int number) {
    return 'Bestellung #$number';
  }

  @override
  String get user => 'Benutzer';

  @override
  String get unknown => 'Unbekannt';

  @override
  String get variant => 'Variante';

  @override
  String get method => 'Methode';

  @override
  String get txId => 'TX-ID';

  @override
  String paymentDetailsTitle(int number) {
    return 'Zahlungsdetails #$number';
  }

  @override
  String get paypalEmail => 'PayPal E-Mail';

  @override
  String get currency => 'Währung';

  @override
  String get bitcoinAddress => 'Bitcoin-Adresse';

  @override
  String get amountUsd => 'Betrag (USD)';

  @override
  String get amountBtc => 'Betrag (BTC)';

  @override
  String get memo => 'Memo';

  @override
  String get markAsProcessing => 'Als in Bearbeitung markieren';

  @override
  String get markAsCompleted => 'Als abgeschlossen markieren';

  @override
  String get markAsFailed => 'Als fehlgeschlagen markieren';

  @override
  String get paymentMarkedProcessing => 'Zahlung als in Bearbeitung markiert';

  @override
  String get paymentMarkedCompleted => 'Zahlung als abgeschlossen markiert';

  @override
  String get paymentMarkedFailed => 'Zahlung als fehlgeschlagen markiert';

  @override
  String get slotVariantsScreen => 'Slot-Varianten';

  @override
  String get activeSlotVariants => 'Aktiv';

  @override
  String get inactiveSlotVariants => 'Inaktiv';

  @override
  String get createSlotVariant => 'Slot-Variante erstellen';

  @override
  String get noSlotVariants => 'Keine Slot-Varianten';

  @override
  String get noSlotVariantsMessage =>
      'Es wurden noch keine Slot-Varianten erstellt.';

  @override
  String get variantName => 'Name';

  @override
  String get duration => 'Laufzeit';

  @override
  String durationDays(int days) {
    return '$days Tage';
  }

  @override
  String get priceUSD => 'Preis (USD)';

  @override
  String get priceBTC => 'Preis (BTC)';

  @override
  String get maxListings => 'Max. Angebote';

  @override
  String get variantStatus => 'Status';

  @override
  String get editSlotVariant => 'Slot-Variante bearbeiten';

  @override
  String get deleteSlotVariant => 'Slot-Variante löschen';

  @override
  String get createSlotVariantDialog => 'Slot-Variante erstellen';

  @override
  String get editSlotVariantDialog => 'Slot-Variante bearbeiten';

  @override
  String get enterVariantName => 'Variantenname eingeben';

  @override
  String get enterDuration => 'Laufzeit (Tage)';

  @override
  String get enterPriceUSD => 'Preis in USD';

  @override
  String get enterPriceBTC => 'Preis in BTC';

  @override
  String get enterMaxListings => 'Max. Angebote';

  @override
  String get variantNameRequired => 'Name ist erforderlich';

  @override
  String get durationRequired => 'Laufzeit ist erforderlich';

  @override
  String get priceUSDRequired => 'USD-Preis ist erforderlich';

  @override
  String get priceBTCRequired => 'BTC-Preis ist erforderlich';

  @override
  String get maxListingsRequired => 'Max. Angebote ist erforderlich';

  @override
  String get slotVariantCreated => 'Slot-Variante erstellt';

  @override
  String get slotVariantUpdated => 'Slot-Variante aktualisiert';

  @override
  String get slotVariantDeleted => 'Slot-Variante gelöscht';

  @override
  String get confirmDeleteSlotVariant =>
      'Möchtest du diese Slot-Variante wirklich löschen?';

  @override
  String confirmDeleteSlotVariantWithName(String name) {
    return 'Möchtest du \"$name\" wirklich löschen?';
  }

  @override
  String get manageSlotVariants => 'Slot-Varianten verwalten';

  @override
  String get createFirstSlotVariant =>
      'Erstelle die erste Slot-Variante mit dem + Button.';

  @override
  String get newSlotVariant => 'Neue Slot-Variante';

  @override
  String get freeLabel => 'KOSTENLOS';

  @override
  String get free => 'Kostenlos';

  @override
  String get nameHint => 'z.B. Standard, Premium';

  @override
  String get descriptionOptional => 'Beschreibung (optional)';

  @override
  String get priceUsd => 'Preis (USD)';

  @override
  String get durationDaysLabel => 'Laufzeit (Tage)';

  @override
  String get freeVariantDescription =>
      'Variante ist gratis (für Promotion-Slots)';

  @override
  String get activeVariantDescription => 'Variante kann gekauft werden';

  @override
  String get atLeastOnePaymentMethodRequired =>
      'Mindestens eine Zahlungsmethode muss aktiviert sein';

  @override
  String get userManagementScreen => 'Benutzerverwaltung';

  @override
  String get allUsers => 'Alle Benutzer';

  @override
  String get activeUsers => 'Aktiv';

  @override
  String get bannedUsers => 'Gesperrt';

  @override
  String get searchUsers => 'Benutzer suchen...';

  @override
  String get noUsers => 'Keine Benutzer';

  @override
  String get noUsersMessage => 'Keine Benutzer gefunden.';

  @override
  String get role => 'Rolle';

  @override
  String get viewUser => 'Benutzer ansehen';

  @override
  String get unbanUser => 'Sperre aufheben';

  @override
  String get userUnbanned => 'Sperre wurde aufgehoben';

  @override
  String get confirmUnbanUser =>
      'Möchtest du diesen Benutzer wirklich entsperren?';

  @override
  String get unban => 'Entsperren';

  @override
  String get administration => 'Administration';

  @override
  String get systemUserManagement => 'System- und Benutzerverwaltung';

  @override
  String get manageCategories => 'Kategorien verwalten';

  @override
  String get createCategoriesSubcategories =>
      'Kategorien und Subkategorien erstellen';

  @override
  String get configureSlotTypes => 'Slot-Typen und Preise konfigurieren';

  @override
  String get paypalBitcoinSlots => 'PayPal und Bitcoin für Slot-Käufe';

  @override
  String get reviewPendingOrders => 'Offene Bestellungen prüfen und bestätigen';

  @override
  String get manageUsersRoles => 'Benutzer verwalten und Rollen zuweisen';

  @override
  String featureInMilestone(String title, String milestone) {
    return '$title wird in Meilenstein $milestone implementiert.';
  }

  @override
  String get slots => 'Slots';

  @override
  String get payments => 'Zahlungen';

  @override
  String get users => 'Benutzer';

  @override
  String get moderatorPanelScreen => 'Moderator Panel';

  @override
  String openReportsCount(int count) {
    return '$count offen';
  }

  @override
  String get listingReports => 'Angebote';

  @override
  String get userReports => 'Benutzer';

  @override
  String get noReportsDescription => 'Es gibt derzeit keine Meldungen';

  @override
  String get listing => 'Angebot';

  @override
  String get reportStatusOpen => 'OFFEN';

  @override
  String get reportStatusReviewing => 'IN PRÜFUNG';

  @override
  String get reportStatusResolved => 'GELÖST';

  @override
  String get reportStatusDismissed => 'ABGEWIESEN';

  @override
  String get reportReasonFraud => 'Betrügerisches Angebot';

  @override
  String get assigned => 'Zugewiesen';

  @override
  String get justNow => 'Gerade eben';

  @override
  String minutesAgo(int minutes) {
    return 'vor ${minutes}m';
  }

  @override
  String hoursAgo(int hours) {
    return 'vor ${hours}h';
  }

  @override
  String daysAgo(int days) {
    return 'vor ${days}d';
  }

  @override
  String get staff => 'Staff';

  @override
  String get banned => 'GESPERRT';

  @override
  String get noUsersFound => 'Keine Benutzer gefunden';

  @override
  String get reportAssignedToYou => 'Meldung wurde Ihnen zugewiesen';

  @override
  String get statusUpdated => 'Status wurde aktualisiert';

  @override
  String get noteCannotBeEmpty => 'Notiz darf nicht leer sein';

  @override
  String get deactivateListing => 'Angebot deaktivieren';

  @override
  String get deactivateListingConfirm =>
      'Möchten Sie dieses Angebot wirklich deaktivieren? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get deactivate => 'Deaktivieren';

  @override
  String get listingDeactivated => 'Angebot wurde deaktiviert';

  @override
  String get reportNotFound => 'Meldung nicht gefunden';

  @override
  String assignedToModerator(int id) {
    return 'Zugewiesen an Moderator #$id';
  }

  @override
  String get notYetAssigned => 'Noch nicht zugewiesen';

  @override
  String get reportDetails => 'Meldungsdetails';

  @override
  String get reportedOn => 'Gemeldet am';

  @override
  String reporterUser(int id) {
    return 'Benutzer #$id';
  }

  @override
  String get reportedUserProfile => 'Gemeldetes Benutzerprofil';

  @override
  String get addInternalNotes => 'Fügen Sie interne Notizen hinzu...';

  @override
  String get assignToMe => 'Mir zuweisen';

  @override
  String get markAsResolved => 'Als gelöst markieren';

  @override
  String fullDateTimeFormat(
      String day, String month, int year, String hour, String minute) {
    return '$day.$month.$year um $hour:$minute Uhr';
  }

  @override
  String listingId(int id) {
    return 'Angebot #$id';
  }

  @override
  String get warning => 'Warnung';

  @override
  String confirmRoleChange(String role) {
    return 'Möchten Sie diesem Benutzer wirklich die Rolle \"$role\" zuweisen? Diese Aktion gibt dem Benutzer erweiterte Berechtigungen.';
  }

  @override
  String get roleUpdated => 'Rolle wurde aktualisiert';

  @override
  String error(String error) {
    return 'Fehler: $error';
  }

  @override
  String get noFreeSlotVariantsAvailable =>
      'Keine kostenlosen Slot-Varianten verfügbar. Erstelle zuerst eine kostenlose Variante.';

  @override
  String get grantFreeSlot => 'Kostenlosen Slot vergeben';

  @override
  String selectFreeSlotVariant(String username) {
    return 'Wähle eine kostenlose Slot-Variante für $username:';
  }

  @override
  String daysRuntime(int days) {
    return '$days Tage Laufzeit';
  }

  @override
  String get freeUppercase => 'KOSTENLOS';

  @override
  String freeSlotGranted(String variantName, String username) {
    return 'Kostenloser Slot \"$variantName\" wurde an $username vergeben';
  }

  @override
  String get confirmUnban =>
      'Möchten Sie die Sperre dieses Benutzers wirklich aufheben?';

  @override
  String get unbanReason => 'Sperre durch Admin aufgehoben';

  @override
  String get information => 'Informationen';

  @override
  String get lastLogin => 'Letzter Login';

  @override
  String get never => 'Noch nie';

  @override
  String get status => 'Status';

  @override
  String get bannedSince => 'Gesperrt seit';

  @override
  String get banReasonLabel => 'Sperrgrund';

  @override
  String get cannotChangeOwnRole =>
      'Sie können Ihre eigene Rolle nicht ändern.';

  @override
  String get roleDescriptionAdmin => 'Voller Zugriff auf alle Funktionen';

  @override
  String get roleDescriptionModerator =>
      'Kann Meldungen bearbeiten und Inhalte moderieren';

  @override
  String get roleDescriptionUser =>
      'Normaler Benutzer ohne erweiterte Berechtigungen';

  @override
  String get banHistory => 'Sperr-Historie';

  @override
  String get bannedAction => 'Gesperrt';

  @override
  String get unbannedAction => 'Entsperrt';

  @override
  String get banReasonFraud => 'Betrug/Scam';

  @override
  String get banReasonInappropriate => 'Unangemessenes Verhalten';

  @override
  String get banReasonTosViolation => 'Verstoß gegen Nutzungsbedingungen';

  @override
  String get banReasonMultipleAccounts => 'Mehrfach-Accounts';

  @override
  String get banReasonIllegal => 'Illegale Aktivitäten';

  @override
  String get banReasonRequired => 'Bitte geben Sie einen Grund ein';

  @override
  String get enterBanReason => 'Bitte geben Sie einen Grund für die Sperre an:';

  @override
  String get presetReasons => 'Vordefinierte Gründe:';

  @override
  String get reasonRequired => 'Grund (erforderlich)';

  @override
  String get describeBanReason => 'Beschreiben Sie den Grund für die Sperre...';

  @override
  String get banWarning =>
      'Achtung: Beim Sperren werden alle aktiven Angebote des Benutzers deaktiviert und offene Transaktionen abgebrochen.';

  @override
  String get banAction => 'Sperren';

  @override
  String get sectionDonate => 'Entwickler unterstützen';

  @override
  String get donateTitle => 'Entwicklung unterstützen';

  @override
  String get donateDescription =>
      'Wenn dir diese App gefällt, kannst du die Entwicklung mit einer Spende unterstützen:';

  @override
  String get donateBitcoin => 'Bitcoin spenden';

  @override
  String get donateCoffee => 'Buy Me a Coffee';

  @override
  String get bitcoinAddressCopied => 'Bitcoin-Adresse kopiert!';

  @override
  String removedFromFavorites(String title) {
    return '$title aus Favoriten entfernt';
  }

  @override
  String get undo => 'Rückgängig';

  @override
  String get retryButton => 'Erneut versuchen';

  @override
  String get noFavorites => 'Keine Favoriten';

  @override
  String get noFavoritesDescription =>
      'Du hast noch keine Angebote favorisiert. Tippe auf das Herz-Symbol bei einem Angebot, um es zu deinen Favoriten hinzuzufügen.';

  @override
  String get removeFavoriteTitle => 'Favorit entfernen?';

  @override
  String removeFavoriteConfirm(String title) {
    return 'Möchtest du \"$title\" aus deinen Favoriten entfernen?';
  }

  @override
  String get remove => 'Entfernen';

  @override
  String get profile => 'Profil';

  @override
  String get reportUser => 'Benutzer melden';

  @override
  String get userNotFound => 'Benutzer nicht gefunden';

  @override
  String get listings => 'Listings';

  @override
  String listingsWithCount(int count) {
    return 'Listings ($count)';
  }

  @override
  String get ratings => 'Ratings';

  @override
  String ratingsWithCount(int count) {
    return 'Ratings ($count)';
  }

  @override
  String get noActiveListings => 'Keine aktiven Angebote';

  @override
  String memberSince(String date) {
    return 'Mitglied seit $date';
  }

  @override
  String get encryptionActive => 'Verschlüsselung aktiv';

  @override
  String get noRatings => 'Keine Ratings';

  @override
  String ratingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Ratings',
      one: '1 Rating',
    );
    return '$_temp0';
  }

  @override
  String get sendMessage => 'Nachricht senden';

  @override
  String get noPgpKeyAvailable => 'Kein PGP-Schlüssel vorhanden';

  @override
  String get monthJan => 'Jan';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mär';

  @override
  String get monthApr => 'Apr';

  @override
  String get monthMay => 'Mai';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Aug';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Okt';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dez';

  @override
  String get rateTransaction => 'Transaktion bewerten';

  @override
  String get howWasYourExperience => 'Wie war deine Erfahrung?';

  @override
  String get ratingGood => 'Gut';

  @override
  String get ratingNeutral => 'Neutral';

  @override
  String get ratingBad => 'Schlecht';

  @override
  String get commentOptional => 'Kommentar (optional)';

  @override
  String get submitRating => 'Bewertung abgeben';

  @override
  String get ratingSubmittedSuccessfully => 'Bewertung erfolgreich abgegeben';

  @override
  String get errorLoadingRatings => 'Fehler beim Laden der Bewertungen';

  @override
  String get noRatingsYet => 'Noch keine Bewertungen';

  @override
  String get noRatingsDescription =>
      'Bewertungen erscheinen hier nach abgeschlossenen Transaktionen';

  @override
  String get positive => 'positiv';

  @override
  String showAllRatings(int count) {
    return 'Alle $count Bewertungen anzeigen';
  }

  @override
  String get loadMore => 'Mehr laden';

  @override
  String get auto => 'Auto';

  @override
  String get reportSelectReason => 'Bitte wähle einen Grund aus';

  @override
  String get reportSubmittedSuccessfully => 'Meldung erfolgreich eingereicht';

  @override
  String get reportSubmitError => 'Fehler beim Einreichen der Meldung';

  @override
  String get reportAlreadyReported => 'Du hast dies bereits gemeldet';

  @override
  String get reportTargetNotFound => 'Eintrag nicht gefunden';

  @override
  String get reportTargetListing => 'Angebot';

  @override
  String get reportTargetUser => 'Benutzer';

  @override
  String reportTitle(String targetType) {
    return '$targetType melden';
  }

  @override
  String reportYouAreReporting(String targetName) {
    return 'Du meldest: \"$targetName\"';
  }

  @override
  String get reportReasonLabel => 'Grund der Meldung:';

  @override
  String get reportDetailsOptional => 'Zusätzliche Details (optional)';

  @override
  String get reportDetailsHint => 'Beschreibe das Problem...';

  @override
  String get report => 'Melden';
}
