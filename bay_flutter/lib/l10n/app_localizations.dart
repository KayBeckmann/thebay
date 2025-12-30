import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr')
  ];

  /// Der Anwendungstitel
  ///
  /// In de, this message translates to:
  /// **'Bay'**
  String get appTitle;

  /// Login-Bildschirm Titel
  ///
  /// In de, this message translates to:
  /// **'Willkommen zurück'**
  String get loginTitle;

  /// Login-Bildschirm Untertitel
  ///
  /// In de, this message translates to:
  /// **'Melde dich an um fortzufahren'**
  String get loginSubtitle;

  /// Benutzername Label
  ///
  /// In de, this message translates to:
  /// **'Benutzername'**
  String get username;

  /// Benutzername erforderlich Validierung
  ///
  /// In de, this message translates to:
  /// **'Bitte gib deinen Benutzernamen ein'**
  String get usernameRequired;

  /// Passwort Label
  ///
  /// In de, this message translates to:
  /// **'Passwort'**
  String get password;

  /// Passwort erforderlich Validierung
  ///
  /// In de, this message translates to:
  /// **'Bitte gib dein Passwort ein'**
  String get passwordRequired;

  /// Angemeldet bleiben Checkbox
  ///
  /// In de, this message translates to:
  /// **'Angemeldet bleiben'**
  String get stayLoggedIn;

  /// Anmelden Button
  ///
  /// In de, this message translates to:
  /// **'Anmelden'**
  String get signIn;

  /// Registrierung Link Text
  ///
  /// In de, this message translates to:
  /// **'Noch kein Konto? '**
  String get dontHaveAccount;

  /// Registrieren Link
  ///
  /// In de, this message translates to:
  /// **'Registrieren'**
  String get signUp;

  /// Login fehlgeschlagen Fehler
  ///
  /// In de, this message translates to:
  /// **'Anmeldung fehlgeschlagen'**
  String get loginFailed;

  /// Verbindungsfehler Nachricht
  ///
  /// In de, this message translates to:
  /// **'Verbindungsfehler. Bitte versuche es erneut.'**
  String get connectionError;

  /// Rate-Limit Fehlermeldung
  ///
  /// In de, this message translates to:
  /// **'Versuche es in {seconds} Sekunden erneut'**
  String tryAgainInSeconds(int seconds);

  /// Registrierung Titel
  ///
  /// In de, this message translates to:
  /// **'Konto erstellen'**
  String get registerTitle;

  /// Registrierung Untertitel
  ///
  /// In de, this message translates to:
  /// **'Registriere dich um loszulegen'**
  String get registerSubtitle;

  /// Benutzername Hilfetext
  ///
  /// In de, this message translates to:
  /// **'3-20 Zeichen, Buchstaben, Zahlen, Unterstriche'**
  String get usernameHelper;

  /// Benutzername zu kurz Validierung
  ///
  /// In de, this message translates to:
  /// **'Benutzername muss mindestens 3 Zeichen lang sein'**
  String get usernameMinLength;

  /// Benutzername zu lang Validierung
  ///
  /// In de, this message translates to:
  /// **'Benutzername darf maximal 20 Zeichen lang sein'**
  String get usernameMaxLength;

  /// Ungültige Zeichen im Benutzernamen
  ///
  /// In de, this message translates to:
  /// **'Nur Buchstaben, Zahlen und Unterstriche erlaubt'**
  String get usernameInvalidChars;

  /// Passwort Hilfetext
  ///
  /// In de, this message translates to:
  /// **'Mind. 8 Zeichen, Großbuchst., Kleinbuchst., Ziffer'**
  String get passwordHelper;

  /// Passwort zu kurz Validierung
  ///
  /// In de, this message translates to:
  /// **'Passwort muss mindestens 8 Zeichen lang sein'**
  String get passwordMinLength;

  /// Passwort benötigt Großbuchstaben
  ///
  /// In de, this message translates to:
  /// **'Passwort muss einen Großbuchstaben enthalten'**
  String get passwordNeedsUppercase;

  /// Passwort benötigt Kleinbuchstaben
  ///
  /// In de, this message translates to:
  /// **'Passwort muss einen Kleinbuchstaben enthalten'**
  String get passwordNeedsLowercase;

  /// Passwort benötigt Ziffer
  ///
  /// In de, this message translates to:
  /// **'Passwort muss eine Ziffer enthalten'**
  String get passwordNeedsDigit;

  /// Passwort bestätigen Label
  ///
  /// In de, this message translates to:
  /// **'Passwort bestätigen'**
  String get confirmPassword;

  /// Passwörter stimmen nicht überein Validierung
  ///
  /// In de, this message translates to:
  /// **'Passwörter stimmen nicht überein'**
  String get passwordsDoNotMatch;

  /// AGBs akzeptieren Text
  ///
  /// In de, this message translates to:
  /// **'Ich stimme den '**
  String get agreeToTerms;

  /// Nutzungsbedingungen Link
  ///
  /// In de, this message translates to:
  /// **'Nutzungsbedingungen'**
  String get termsOfService;

  /// Schließen Button
  ///
  /// In de, this message translates to:
  /// **'Schließen'**
  String get close;

  /// Konto erstellen Button
  ///
  /// In de, this message translates to:
  /// **'Konto erstellen'**
  String get createAccount;

  /// Login Link Text
  ///
  /// In de, this message translates to:
  /// **'Bereits ein Konto? '**
  String get alreadyHaveAccount;

  /// AGBs müssen akzeptiert werden Fehler
  ///
  /// In de, this message translates to:
  /// **'Du musst die Nutzungsbedingungen akzeptieren'**
  String get mustAcceptTerms;

  /// Registrierung fehlgeschlagen Fehler
  ///
  /// In de, this message translates to:
  /// **'Registrierung fehlgeschlagen'**
  String get registrationFailed;

  /// Schlüsselgenerierung Dialog Titel
  ///
  /// In de, this message translates to:
  /// **'Sicherheitsschlüssel wird erstellt...'**
  String get generatingKey;

  /// Schlüsselgenerierung Dialog Nachricht
  ///
  /// In de, this message translates to:
  /// **'Dein persönlicher Verschlüsselungsschlüssel wird generiert.\nDies dauert nur wenige Sekunden.'**
  String get generatingKeyMessage;

  /// Schlüsselgenerierung fehlgeschlagen Nachricht
  ///
  /// In de, this message translates to:
  /// **'Schlüssel konnte nicht generiert werden: {error}\nDu kannst ihn später in den Einstellungen erstellen.'**
  String keyGenerationFailed(String error);

  /// Verstrichene Zeit Label
  ///
  /// In de, this message translates to:
  /// **'Verstrichene Zeit: {time}'**
  String elapsedTime(String time);

  /// Dashboard Navigation Label
  ///
  /// In de, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// Nachrichten Navigation Label
  ///
  /// In de, this message translates to:
  /// **'Nachrichten'**
  String get navMessages;

  /// Suchen Navigation Label
  ///
  /// In de, this message translates to:
  /// **'Suchen'**
  String get navSearch;

  /// Verkaufen Navigation Label
  ///
  /// In de, this message translates to:
  /// **'Verkaufen'**
  String get navSell;

  /// Transaktionen Navigation Label
  ///
  /// In de, this message translates to:
  /// **'Transaktionen'**
  String get navTransactions;

  /// Einstellungen Navigation Label
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get navSettings;

  /// Moderation Navigation Label
  ///
  /// In de, this message translates to:
  /// **'Moderation'**
  String get navModeration;

  /// News Navigation Label
  ///
  /// In de, this message translates to:
  /// **'News'**
  String get navNews;

  /// Admin Navigation Label
  ///
  /// In de, this message translates to:
  /// **'Admin'**
  String get navAdmin;

  /// Drawer Benutzer Fallback Name
  ///
  /// In de, this message translates to:
  /// **'Benutzer'**
  String get drawerUserFallback;

  /// Drawer Moderation Section Header
  ///
  /// In de, this message translates to:
  /// **'Moderation'**
  String get drawerModerationSection;

  /// Drawer Administration Section Header
  ///
  /// In de, this message translates to:
  /// **'Administration'**
  String get drawerAdminSection;

  /// Administrator Rolle
  ///
  /// In de, this message translates to:
  /// **'Administrator'**
  String get roleAdmin;

  /// Moderator Rolle
  ///
  /// In de, this message translates to:
  /// **'Moderator'**
  String get roleModerator;

  /// Benutzer Rolle
  ///
  /// In de, this message translates to:
  /// **'Benutzer'**
  String get roleUser;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
