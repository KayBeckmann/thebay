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
}
