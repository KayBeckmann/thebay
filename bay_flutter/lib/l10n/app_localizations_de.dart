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
}
