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

  /// Passwort Mindestlänge Validierung
  ///
  /// In de, this message translates to:
  /// **'Passwort muss mindestens 8 Zeichen haben'**
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

  /// Schlüssel wird generiert Status
  ///
  /// In de, this message translates to:
  /// **'Schlüssel wird generiert...'**
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

  /// Einstellungen Screen Titel
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get settingsTitle;

  /// Zahlungsinformationen Section Header
  ///
  /// In de, this message translates to:
  /// **'Zahlungsinformationen'**
  String get sectionPaymentInfo;

  /// Anzeige Section Header
  ///
  /// In de, this message translates to:
  /// **'Anzeige'**
  String get sectionDisplay;

  /// Sicherheit Section Header
  ///
  /// In de, this message translates to:
  /// **'Sicherheit'**
  String get sectionSecurity;

  /// Konto Section Header
  ///
  /// In de, this message translates to:
  /// **'Konto'**
  String get sectionAccount;

  /// PayPal-Adresse Label
  ///
  /// In de, this message translates to:
  /// **'PayPal-Adresse'**
  String get paypalAddress;

  /// Bitcoin-Wallet Label
  ///
  /// In de, this message translates to:
  /// **'Bitcoin-Wallet'**
  String get bitcoinWallet;

  /// Nicht angegeben Text
  ///
  /// In de, this message translates to:
  /// **'Nicht angegeben'**
  String get notSpecified;

  /// E-Mail-Adresse Label
  ///
  /// In de, this message translates to:
  /// **'E-Mail-Adresse'**
  String get emailAddress;

  /// E-Mail Hint
  ///
  /// In de, this message translates to:
  /// **'deine@email.com'**
  String get emailHint;

  /// Wallet-Adresse Label
  ///
  /// In de, this message translates to:
  /// **'Wallet-Adresse'**
  String get walletAddress;

  /// Wallet Hint
  ///
  /// In de, this message translates to:
  /// **'bc1q...'**
  String get walletHint;

  /// Abbrechen Button
  ///
  /// In de, this message translates to:
  /// **'Abbrechen'**
  String get cancel;

  /// Speichern Button
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get save;

  /// PayPal-Adresse gespeichert Message
  ///
  /// In de, this message translates to:
  /// **'PayPal-Adresse gespeichert'**
  String get paypalAddressSaved;

  /// Bitcoin-Wallet gespeichert Message
  ///
  /// In de, this message translates to:
  /// **'Bitcoin-Wallet gespeichert'**
  String get bitcoinWalletSaved;

  /// Fehler beim Speichern Message
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Speichern: {error}'**
  String errorSaving(String error);

  /// Elemente pro Seite Label
  ///
  /// In de, this message translates to:
  /// **'Elemente pro Seite'**
  String get itemsPerPage;

  /// Elemente Anzahl
  ///
  /// In de, this message translates to:
  /// **'{count} Elemente'**
  String itemsCount(int count);

  /// Anzeigewährung Label
  ///
  /// In de, this message translates to:
  /// **'Anzeigewährung'**
  String get displayCurrency;

  /// Sprache Label
  ///
  /// In de, this message translates to:
  /// **'Sprache'**
  String get language;

  /// Sprache geändert Nachricht
  ///
  /// In de, this message translates to:
  /// **'Sprache geändert. Bitte starte die App neu, um die Änderung zu übernehmen.'**
  String get languageChanged;

  /// Englisch Sprach-Label
  ///
  /// In de, this message translates to:
  /// **'English'**
  String get langEnglish;

  /// Deutsch Sprach-Label
  ///
  /// In de, this message translates to:
  /// **'Deutsch'**
  String get langGerman;

  /// Französisch Sprach-Label
  ///
  /// In de, this message translates to:
  /// **'Français'**
  String get langFrench;

  /// Spanisch Sprach-Label
  ///
  /// In de, this message translates to:
  /// **'Español'**
  String get langSpanish;

  /// PGP-Schlüssel Label
  ///
  /// In de, this message translates to:
  /// **'PGP-Schlüssel'**
  String get pgpKey;

  /// Eingerichtet Status
  ///
  /// In de, this message translates to:
  /// **'Eingerichtet'**
  String get configured;

  /// Noch nicht eingerichtet Status
  ///
  /// In de, this message translates to:
  /// **'Noch nicht eingerichtet'**
  String get notConfigured;

  /// Passwort ändern Label
  ///
  /// In de, this message translates to:
  /// **'Passwort ändern'**
  String get changePassword;

  /// Aktuelles Passwort Label
  ///
  /// In de, this message translates to:
  /// **'Aktuelles Passwort'**
  String get currentPassword;

  /// Neues Passwort Label
  ///
  /// In de, this message translates to:
  /// **'Neues Passwort'**
  String get newPassword;

  /// Passwörter stimmen nicht überein Fehler
  ///
  /// In de, this message translates to:
  /// **'Passwörter stimmen nicht überein'**
  String get passwordsMismatch;

  /// Passwort erfolgreich geändert
  ///
  /// In de, this message translates to:
  /// **'Passwort erfolgreich geändert'**
  String get passwordChangeSuccess;

  /// Fehler beim Ändern des Passworts
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Ändern des Passworts'**
  String get passwordChangeError;

  /// Ändern Button
  ///
  /// In de, this message translates to:
  /// **'Ändern'**
  String get changeButton;

  /// Abmelden Label
  ///
  /// In de, this message translates to:
  /// **'Abmelden'**
  String get logout;

  /// Abmelden Bestätigungstext
  ///
  /// In de, this message translates to:
  /// **'Möchtest du dich wirklich abmelden?'**
  String get logoutConfirm;

  /// Konto löschen Label
  ///
  /// In de, this message translates to:
  /// **'Konto löschen'**
  String get deleteAccount;

  /// Konto löschen Warnung
  ///
  /// In de, this message translates to:
  /// **'Diese Aktion kann nicht rückgängig gemacht werden. Alle deine Daten werden unwiderruflich gelöscht.'**
  String get deleteAccountWarning;

  /// Passwort zur Bestätigung Label
  ///
  /// In de, this message translates to:
  /// **'Passwort zur Bestätigung'**
  String get passwordConfirmation;

  /// Passwort eingeben Validierung
  ///
  /// In de, this message translates to:
  /// **'Bitte gib das Passwort ein'**
  String get pleaseEnterPassword;

  /// Fehler beim Löschen des Kontos
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Löschen des Kontos'**
  String get deleteAccountError;

  /// Allgemeiner Fehler
  ///
  /// In de, this message translates to:
  /// **'Fehler: {error}'**
  String genericError(String error);

  /// Dashboard Screen Titel
  ///
  /// In de, this message translates to:
  /// **'Dashboard'**
  String get dashboardTitle;

  /// Willkommensgruß
  ///
  /// In de, this message translates to:
  /// **'Willkommen, {username}!'**
  String welcomeUser(String username);

  /// Benutzer Fallback Name
  ///
  /// In de, this message translates to:
  /// **'Benutzer'**
  String get userFallback;

  /// Was möchtest du heute tun Frage
  ///
  /// In de, this message translates to:
  /// **'Was möchtest du heute tun?'**
  String get whatTodayQuestion;

  /// Ausstehende Bewertungen Section
  ///
  /// In de, this message translates to:
  /// **'Ausstehende Bewertungen'**
  String get sectionPendingRatings;

  /// Neuigkeiten Section
  ///
  /// In de, this message translates to:
  /// **'Neuigkeiten'**
  String get sectionNews;

  /// Slot-Warnungen Section
  ///
  /// In de, this message translates to:
  /// **'Slot-Warnungen'**
  String get sectionSlotWarnings;

  /// Neueste Angebote Section
  ///
  /// In de, this message translates to:
  /// **'Neueste Angebote'**
  String get sectionRecentListings;

  /// Keine Neuigkeiten Titel
  ///
  /// In de, this message translates to:
  /// **'Keine Neuigkeiten'**
  String get noNews;

  /// Keine Neuigkeiten Nachricht
  ///
  /// In de, this message translates to:
  /// **'Aktuell gibt es keine Neuigkeiten. Schau später wieder vorbei!'**
  String get noNewsMessage;

  /// Ausstehende Bewertungen Anzahl
  ///
  /// In de, this message translates to:
  /// **'{count, plural, =1{Du hast 1 ausstehende Bewertung} other{Du hast {count} ausstehende Bewertungen}}'**
  String pendingRatingsCount(int count);

  /// Transaktionsnummer
  ///
  /// In de, this message translates to:
  /// **'Transaktion #{id}'**
  String transactionNumber(int id);

  /// Alle ausstehenden Bewertungen anzeigen
  ///
  /// In de, this message translates to:
  /// **'Alle {count} ausstehenden Bewertungen anzeigen'**
  String viewAllPendingRatings(int count);

  /// Keine Slots laufen ab
  ///
  /// In de, this message translates to:
  /// **'Keine Slots laufen in den nächsten 3 Tagen ab.'**
  String get noSlotsExpiring;

  /// Slots laufen bald ab
  ///
  /// In de, this message translates to:
  /// **'{count, plural, =1{1 Slot läuft bald ab} other{{count} Slots laufen bald ab}}'**
  String slotsExpiringSoon(int count);

  /// Slot-Nummer
  ///
  /// In de, this message translates to:
  /// **'Slot #{id}'**
  String slotNumber(int id);

  /// Listing-Nummer
  ///
  /// In de, this message translates to:
  /// **'Listing #{id}'**
  String listingNumber(int id);

  /// Kein Listing verknüpft
  ///
  /// In de, this message translates to:
  /// **'Kein Listing verknüpft'**
  String get noListingLinked;

  /// Weitere Anzahl
  ///
  /// In de, this message translates to:
  /// **'+{count} weitere'**
  String moreCount(int count);

  /// Noch keine Angebote Titel
  ///
  /// In de, this message translates to:
  /// **'Noch keine Angebote'**
  String get noListingsYet;

  /// Noch keine Angebote Nachricht
  ///
  /// In de, this message translates to:
  /// **'Hier werden die neuesten Angebote angezeigt.'**
  String get noListingsMessage;

  /// Mengeneinheit Stück
  ///
  /// In de, this message translates to:
  /// **'Stück'**
  String get unitPiece;

  /// Mengeneinheit Kilogramm
  ///
  /// In de, this message translates to:
  /// **'kg'**
  String get unitKg;

  /// Mengeneinheit Gramm
  ///
  /// In de, this message translates to:
  /// **'g'**
  String get unitGram;

  /// Mengeneinheit Meter
  ///
  /// In de, this message translates to:
  /// **'m'**
  String get unitMeter;

  /// Mengeneinheit Liter
  ///
  /// In de, this message translates to:
  /// **'L'**
  String get unitLiter;

  /// Bearbeiten Button
  ///
  /// In de, this message translates to:
  /// **'Bearbeiten'**
  String get edit;

  /// Löschen Button
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get delete;

  /// Erstellen Button
  ///
  /// In de, this message translates to:
  /// **'Erstellen'**
  String get create;

  /// Aktiv Status
  ///
  /// In de, this message translates to:
  /// **'Aktiv'**
  String get active;

  /// Inaktiv Status
  ///
  /// In de, this message translates to:
  /// **'Inaktiv'**
  String get inactive;

  /// Erforderliches Feld Validierung
  ///
  /// In de, this message translates to:
  /// **'Erforderlich'**
  String get required;

  /// Ungültige Eingabe Validierung
  ///
  /// In de, this message translates to:
  /// **'Ungültige Eingabe'**
  String get invalidInput;

  /// Versand Label
  ///
  /// In de, this message translates to:
  /// **'Versand'**
  String get shipping;

  /// Versandart Label
  ///
  /// In de, this message translates to:
  /// **'Versandart'**
  String get shippingMethod;

  /// Versandkosten Label
  ///
  /// In de, this message translates to:
  /// **'Versandkosten'**
  String get shippingCost;

  /// Suchen Screen Titel
  ///
  /// In de, this message translates to:
  /// **'Suchen'**
  String get searchTitle;

  /// Favoriten Label
  ///
  /// In de, this message translates to:
  /// **'Favoriten'**
  String get favorites;

  /// Angebote suchen Hinweistext
  ///
  /// In de, this message translates to:
  /// **'Angebote suchen...'**
  String get searchListingsHint;

  /// Kategorie Label
  ///
  /// In de, this message translates to:
  /// **'Kategorie'**
  String get category;

  /// Subkategorie Label
  ///
  /// In de, this message translates to:
  /// **'Subkategorie'**
  String get subcategory;

  /// Bezahlart Label
  ///
  /// In de, this message translates to:
  /// **'Bezahlart'**
  String get paymentMethod;

  /// Filter löschen Button
  ///
  /// In de, this message translates to:
  /// **'Filter löschen'**
  String get clearFilters;

  /// Keine Ergebnisse Titel
  ///
  /// In de, this message translates to:
  /// **'Keine Ergebnisse'**
  String get noResults;

  /// Angebote durchsuchen Text
  ///
  /// In de, this message translates to:
  /// **'Angebote durchsuchen'**
  String get browseListings;

  /// PayPal Zahlungsmethode
  ///
  /// In de, this message translates to:
  /// **'PayPal'**
  String get paypal;

  /// Bitcoin Zahlungsmethode
  ///
  /// In de, this message translates to:
  /// **'Bitcoin'**
  String get bitcoin;

  /// Angebotsdetails Screen Titel
  ///
  /// In de, this message translates to:
  /// **'Angebotsdetails'**
  String get listingDetailTitle;

  /// Beschreibung Label
  ///
  /// In de, this message translates to:
  /// **'Beschreibung'**
  String get description;

  /// Details Label
  ///
  /// In de, this message translates to:
  /// **'Details:'**
  String get details;

  /// Akzeptierte Zahlungsmethoden Label
  ///
  /// In de, this message translates to:
  /// **'Akzeptierte Zahlungsmethoden'**
  String get acceptedPaymentMethods;

  /// Menge Label
  ///
  /// In de, this message translates to:
  /// **'Menge'**
  String get quantity;

  /// Preis pro Einheit Label
  ///
  /// In de, this message translates to:
  /// **'Preis pro Einheit'**
  String get pricePerUnit;

  /// Erstellt am Label
  ///
  /// In de, this message translates to:
  /// **'Erstellt am'**
  String get createdAt;

  /// Läuft ab am Label
  ///
  /// In de, this message translates to:
  /// **'Läuft ab am'**
  String get expiresAt;

  /// Angebot nicht gefunden Fehler
  ///
  /// In de, this message translates to:
  /// **'Angebot nicht gefunden'**
  String get listingNotFound;

  /// Erneut versuchen Button
  ///
  /// In de, this message translates to:
  /// **'Erneut versuchen'**
  String get tryAgain;

  /// Jetzt kaufen Button
  ///
  /// In de, this message translates to:
  /// **'Jetzt kaufen'**
  String get buyNow;

  /// Verkäufer kontaktieren Button
  ///
  /// In de, this message translates to:
  /// **'Verkäufer kontaktieren'**
  String get contactSeller;

  /// Neues Angebot Screen Titel
  ///
  /// In de, this message translates to:
  /// **'Neues Angebot'**
  String get createListingTitle;

  /// Angebot bearbeiten Screen Titel
  ///
  /// In de, this message translates to:
  /// **'Angebot bearbeiten'**
  String get editListingTitle;

  /// Titel Label
  ///
  /// In de, this message translates to:
  /// **'Titel'**
  String get title;

  /// Titel Hinweistext
  ///
  /// In de, this message translates to:
  /// **'Gib einen Titel ein'**
  String get titleHint;

  /// Titel erforderlich Validierung
  ///
  /// In de, this message translates to:
  /// **'Titel ist erforderlich'**
  String get titleRequired;

  /// Beschreibung Hinweistext
  ///
  /// In de, this message translates to:
  /// **'Beschreibe dein Angebot...'**
  String get descriptionHint;

  /// Beschreibung erforderlich Validierung
  ///
  /// In de, this message translates to:
  /// **'Beschreibung ist erforderlich'**
  String get descriptionRequired;

  /// Preis Label
  ///
  /// In de, this message translates to:
  /// **'Preis'**
  String get price;

  /// Preis Hinweistext
  ///
  /// In de, this message translates to:
  /// **'0.00'**
  String get priceHint;

  /// Preis erforderlich Validierung
  ///
  /// In de, this message translates to:
  /// **'Preis ist erforderlich'**
  String get priceRequired;

  /// Ungültiger Preis Validierung
  ///
  /// In de, this message translates to:
  /// **'Preis muss größer als 0 sein'**
  String get priceInvalid;

  /// Menge Hinweistext
  ///
  /// In de, this message translates to:
  /// **'1'**
  String get quantityHint;

  /// Menge erforderlich Validierung
  ///
  /// In de, this message translates to:
  /// **'Menge ist erforderlich'**
  String get quantityRequired;

  /// Ungültige Menge Validierung
  ///
  /// In de, this message translates to:
  /// **'Menge muss größer als 0 sein'**
  String get quantityInvalid;

  /// Einheit Label
  ///
  /// In de, this message translates to:
  /// **'Einheit'**
  String get unit;

  /// Kategorie wählen Text
  ///
  /// In de, this message translates to:
  /// **'Kategorie wählen'**
  String get selectCategory;

  /// Subkategorie wählen Text
  ///
  /// In de, this message translates to:
  /// **'Subkategorie wählen'**
  String get selectSubcategory;

  /// Kategorie erforderlich Validierung
  ///
  /// In de, this message translates to:
  /// **'Kategorie ist erforderlich'**
  String get categoryRequired;

  /// Bilder Label
  ///
  /// In de, this message translates to:
  /// **'Bilder'**
  String get images;

  /// Bilder hinzufügen Button
  ///
  /// In de, this message translates to:
  /// **'Bilder hinzufügen'**
  String get addImages;

  /// Zahlungsmethoden wählen Label
  ///
  /// In de, this message translates to:
  /// **'Zahlungsmethoden wählen'**
  String get selectPaymentMethods;

  /// Mindestens eine Zahlungsmethode Validierung
  ///
  /// In de, this message translates to:
  /// **'Mindestens eine Zahlungsmethode erforderlich'**
  String get atLeastOnePaymentMethod;

  /// Versandoptionen Label
  ///
  /// In de, this message translates to:
  /// **'Versandoptionen'**
  String get shippingOptions;

  /// Versand verfügbar Checkbox
  ///
  /// In de, this message translates to:
  /// **'Versand verfügbar'**
  String get shippingAvailable;

  /// Versandkosten Hinweistext
  ///
  /// In de, this message translates to:
  /// **'5.00'**
  String get shippingCostHint;

  /// Angebot erstellt Nachricht
  ///
  /// In de, this message translates to:
  /// **'Angebot erstellt'**
  String get listingCreated;

  /// Angebot aktualisiert Nachricht
  ///
  /// In de, this message translates to:
  /// **'Angebot aktualisiert'**
  String get listingUpdated;

  /// Fehler beim Erstellen des Angebots
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Erstellen des Angebots'**
  String get errorCreatingListing;

  /// Fehler beim Aktualisieren des Angebots
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Aktualisieren des Angebots'**
  String get errorUpdatingListing;

  /// Angebot löschen Button
  ///
  /// In de, this message translates to:
  /// **'Angebot löschen'**
  String get deleteListing;

  /// Angebot löschen Bestätigung
  ///
  /// In de, this message translates to:
  /// **'Möchtest du dieses Angebot wirklich löschen?'**
  String get deleteListingConfirm;

  /// Angebot gelöscht Nachricht
  ///
  /// In de, this message translates to:
  /// **'Angebot gelöscht'**
  String get listingDeleted;

  /// Fehler beim Löschen des Angebots
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Löschen des Angebots'**
  String get errorDeletingListing;

  /// Slot Label
  ///
  /// In de, this message translates to:
  /// **'Slot'**
  String get slot;

  /// Slot wählen Label
  ///
  /// In de, this message translates to:
  /// **'Slot wählen'**
  String get selectSlot;

  /// Slot erforderlich Validierung
  ///
  /// In de, this message translates to:
  /// **'Slot ist erforderlich'**
  String get slotRequired;

  /// Keine Slots verfügbar Nachricht
  ///
  /// In de, this message translates to:
  /// **'Keine Slots verfügbar'**
  String get noSlotsAvailable;

  /// Lädt Status
  ///
  /// In de, this message translates to:
  /// **'Lädt...'**
  String get loading;

  /// Wiederholen Button
  ///
  /// In de, this message translates to:
  /// **'Wiederholen'**
  String get retry;

  /// Suchleer-Status Nachricht
  ///
  /// In de, this message translates to:
  /// **'Gib einen Suchbegriff ein oder wähle Filter aus, um Angebote zu finden.'**
  String get searchEmptyStateMessage;

  /// Keine Ergebnisse Nachricht
  ///
  /// In de, this message translates to:
  /// **'Versuche andere Suchbegriffe oder passe die Filter an.'**
  String get noResultsMessage;

  /// Filter zurücksetzen Button
  ///
  /// In de, this message translates to:
  /// **'Filter zurücksetzen'**
  String get resetFilters;

  /// Keine Kategorie Auswahl
  ///
  /// In de, this message translates to:
  /// **'Keine Kategorie'**
  String get noCategory;

  /// Alle Subkategorien Auswahl
  ///
  /// In de, this message translates to:
  /// **'Alle Subkategorien'**
  String get allSubcategories;

  /// Alle Bezahlarten Auswahl
  ///
  /// In de, this message translates to:
  /// **'Alle Bezahlarten'**
  String get allPaymentMethods;

  /// Suchfehler
  ///
  /// In de, this message translates to:
  /// **'Fehler bei der Suche: {error}'**
  String searchError(String error);

  /// Anzahl der Suchergebnisse
  ///
  /// In de, this message translates to:
  /// **'{count, plural, =1{1 Ergebnis} other{{count} Ergebnisse}}'**
  String resultsCount(int count);

  /// Transaktionen Screen Titel
  ///
  /// In de, this message translates to:
  /// **'Transaktionen'**
  String get transactions;

  /// Käufe Tab mit Anzahl
  ///
  /// In de, this message translates to:
  /// **'Käufe ({count})'**
  String purchases(int count);

  /// Verkäufe Tab mit Anzahl
  ///
  /// In de, this message translates to:
  /// **'Verkäufe ({count})'**
  String sales(int count);

  /// Aktualisieren Tooltip
  ///
  /// In de, this message translates to:
  /// **'Aktualisieren'**
  String get refresh;

  /// Leerzustand für Käufe Titel
  ///
  /// In de, this message translates to:
  /// **'Noch keine Käufe'**
  String get noPurchasesYet;

  /// Leerzustand für Verkäufe Titel
  ///
  /// In de, this message translates to:
  /// **'Noch keine Verkäufe'**
  String get noSalesYet;

  /// Leerzustand für Käufe Nachricht
  ///
  /// In de, this message translates to:
  /// **'Deine Käufe werden hier angezeigt'**
  String get yourPurchasesWillAppearHere;

  /// Leerzustand für Verkäufe Nachricht
  ///
  /// In de, this message translates to:
  /// **'Deine Verkäufe werden hier angezeigt'**
  String get yourSalesWillAppearHere;

  /// Transaktionsstatus Offen
  ///
  /// In de, this message translates to:
  /// **'Offen'**
  String get statusOpen;

  /// Transaktionsstatus Bezahlt
  ///
  /// In de, this message translates to:
  /// **'Bezahlt'**
  String get statusPaid;

  /// Transaktionsstatus Versendet
  ///
  /// In de, this message translates to:
  /// **'Versendet'**
  String get statusShipped;

  /// Transaktionsstatus Erhalten
  ///
  /// In de, this message translates to:
  /// **'Erhalten'**
  String get statusReceived;

  /// Transaktionsstatus Abgeschlossen
  ///
  /// In de, this message translates to:
  /// **'Abgeschlossen'**
  String get statusCompleted;

  /// Transaktionsstatus Umstritten
  ///
  /// In de, this message translates to:
  /// **'Umstritten'**
  String get statusDisputed;

  /// Transaktionsstatus Abgebrochen
  ///
  /// In de, this message translates to:
  /// **'Abgebrochen'**
  String get statusCancelled;

  /// Auto-Abschluss heute Warnung
  ///
  /// In de, this message translates to:
  /// **'Wird heute automatisch abgeschlossen'**
  String get autoCompletesToday;

  /// Auto-Abschluss in X Tagen
  ///
  /// In de, this message translates to:
  /// **'Wird in {count} {count, plural, =1{Tag} other{Tagen}} automatisch abgeschlossen'**
  String autoCompletesInDays(int count);

  /// Transaktion Label
  ///
  /// In de, this message translates to:
  /// **'Transaktion'**
  String get transaction;

  /// Bewertungsaufforderung Titel
  ///
  /// In de, this message translates to:
  /// **'Bewerte diese Transaktion'**
  String get rateThisTransaction;

  /// Bewertungsaufforderung Text
  ///
  /// In de, this message translates to:
  /// **'Teile deine Erfahrung mit {username}'**
  String shareYourExperience(String username);

  /// Jetzt bewerten Button
  ///
  /// In de, this message translates to:
  /// **'Jetzt bewerten'**
  String get rateNow;

  /// Bereits bewertet Nachricht
  ///
  /// In de, this message translates to:
  /// **'Du hast diese Transaktion bereits bewertet'**
  String get alreadyRated;

  /// Status Offen Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Warte auf Zahlung des Käufers'**
  String get statusOpenDesc;

  /// Status Bezahlt Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Zahlung gesendet, warte auf Versand durch Verkäufer'**
  String get statusPaidDesc;

  /// Status Versendet Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Artikel wurde versendet, warte auf Zustellung'**
  String get statusShippedDesc;

  /// Status Erhalten Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Käufer hat den Artikel erhalten'**
  String get statusReceivedDesc;

  /// Status Abgeschlossen Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Transaktion erfolgreich abgeschlossen'**
  String get statusCompletedDesc;

  /// Status Umstritten Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Ein Streitfall wurde eröffnet'**
  String get statusDisputedDesc;

  /// Status Abgebrochen Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Transaktion wurde abgebrochen'**
  String get statusCancelledDesc;

  /// Zeitverlauf Titel
  ///
  /// In de, this message translates to:
  /// **'Zeitverlauf'**
  String get timeline;

  /// Erstellt Label
  ///
  /// In de, this message translates to:
  /// **'Erstellt'**
  String get created;

  /// Bezahlt Label
  ///
  /// In de, this message translates to:
  /// **'Bezahlt'**
  String get paid;

  /// Zahlung gesendet Label
  ///
  /// In de, this message translates to:
  /// **'Zahlung gesendet'**
  String get paymentSent;

  /// Warte auf Käufer Status
  ///
  /// In de, this message translates to:
  /// **'Warte auf Käufer'**
  String get waitingForBuyer;

  /// Versendet Label
  ///
  /// In de, this message translates to:
  /// **'Versendet'**
  String get shipped;

  /// Warte auf Verkäufer Status
  ///
  /// In de, this message translates to:
  /// **'Warte auf Verkäufer'**
  String get waitingForSeller;

  /// Erhalten Label
  ///
  /// In de, this message translates to:
  /// **'Erhalten'**
  String get received;

  /// Abgeschlossen Label
  ///
  /// In de, this message translates to:
  /// **'Abgeschlossen'**
  String get completed;

  /// Abgebrochen Label
  ///
  /// In de, this message translates to:
  /// **'Abgebrochen'**
  String get cancelled;

  /// Ausstehend Label
  ///
  /// In de, this message translates to:
  /// **'Ausstehend'**
  String get pending;

  /// Als versendet markieren Button
  ///
  /// In de, this message translates to:
  /// **'Als versendet markieren'**
  String get markAsShipped;

  /// Als bezahlt markieren Button
  ///
  /// In de, this message translates to:
  /// **'Als bezahlt markieren'**
  String get markAsPaid;

  /// Als erhalten markieren Button
  ///
  /// In de, this message translates to:
  /// **'Als erhalten markieren'**
  String get markAsReceived;

  /// Transaktion abbrechen Button
  ///
  /// In de, this message translates to:
  /// **'Transaktion abbrechen'**
  String get cancelTransaction;

  /// Streitfall eröffnen Button
  ///
  /// In de, this message translates to:
  /// **'Streitfall eröffnen'**
  String get openDispute;

  /// Aktionen Titel
  ///
  /// In de, this message translates to:
  /// **'Aktionen'**
  String get actions;

  /// Versandbestätigung Dialog Text
  ///
  /// In de, this message translates to:
  /// **'Bestätige, dass du den Artikel versendet hast. Der Käufer hat 14 Tage Zeit, den Erhalt zu bestätigen oder einen Streitfall zu eröffnen.'**
  String get confirmShipment;

  /// Bestätigen Button
  ///
  /// In de, this message translates to:
  /// **'Bestätigen'**
  String get confirm;

  /// Als versendet markiert Nachricht
  ///
  /// In de, this message translates to:
  /// **'Transaktion als versendet markiert'**
  String get transactionMarkedAsShipped;

  /// Zahlungsbestätigung Dialog Text
  ///
  /// In de, this message translates to:
  /// **'Bestätige, dass du die Zahlung an den Verkäufer gesendet hast.'**
  String get confirmPayment;

  /// Zahlung als gesendet markiert Nachricht
  ///
  /// In de, this message translates to:
  /// **'Zahlung als gesendet markiert'**
  String get paymentMarkedAsSent;

  /// Erhaltbestätigung Dialog Text
  ///
  /// In de, this message translates to:
  /// **'Bestätige, dass du den Artikel erhalten hast. Dies wird die Transaktion abschließen.'**
  String get confirmReceipt;

  /// Transaktion abgeschlossen Nachricht
  ///
  /// In de, this message translates to:
  /// **'Transaktion abgeschlossen'**
  String get transactionCompleted;

  /// Transaktionsabbruch Bestätigung
  ///
  /// In de, this message translates to:
  /// **'Möchtest du diese Transaktion wirklich abbrechen? Diese Aktion kann nicht rückgängig gemacht werden.'**
  String get cancelTransactionConfirm;

  /// Behalten Button
  ///
  /// In de, this message translates to:
  /// **'Behalten'**
  String get keep;

  /// Transaktion abgebrochen Nachricht
  ///
  /// In de, this message translates to:
  /// **'Transaktion abgebrochen'**
  String get transactionCancelled;

  /// Streitfall-Beschreibung Aufforderung
  ///
  /// In de, this message translates to:
  /// **'Bitte beschreibe das Problem mit dieser Transaktion. Ein Moderator wird deinen Streitfall prüfen.'**
  String get describeIssue;

  /// Grund Label
  ///
  /// In de, this message translates to:
  /// **'Grund'**
  String get reason;

  /// Problem beschreiben Hinweis
  ///
  /// In de, this message translates to:
  /// **'Beschreibe das Problem...'**
  String get describeProblem;

  /// Grund erforderlich Validierung
  ///
  /// In de, this message translates to:
  /// **'Bitte gib einen Grund an'**
  String get pleaseEnterReason;

  /// Streitfall eröffnet Nachricht
  ///
  /// In de, this message translates to:
  /// **'Streitfall eröffnet'**
  String get disputeOpened;

  /// Transaktion nicht gefunden Fehler
  ///
  /// In de, this message translates to:
  /// **'Transaktion nicht gefunden'**
  String get transactionNotFound;

  /// Transaktions-ID Label
  ///
  /// In de, this message translates to:
  /// **'Transaktions-ID'**
  String get transactionId;

  /// Gesamtpreis Label
  ///
  /// In de, this message translates to:
  /// **'Gesamtpreis'**
  String get totalPrice;

  /// Parteien Titel
  ///
  /// In de, this message translates to:
  /// **'Parteien'**
  String get parties;

  /// Käufer Label
  ///
  /// In de, this message translates to:
  /// **'Käufer'**
  String get buyer;

  /// Verkäufer Label
  ///
  /// In de, this message translates to:
  /// **'Verkäufer'**
  String get seller;

  /// Du Label
  ///
  /// In de, this message translates to:
  /// **'Du'**
  String get you;

  /// Angebotsdetails anzeigen Link
  ///
  /// In de, this message translates to:
  /// **'Angebotsdetails anzeigen'**
  String get viewListingDetails;

  /// Käufernotiz Titel
  ///
  /// In de, this message translates to:
  /// **'Käufernotiz'**
  String get buyerNote;

  /// Auto-Abschluss Warnung Titel
  ///
  /// In de, this message translates to:
  /// **'Auto-Abschluss Warnung'**
  String get autoCompleteWarning;

  /// Auto-Abschluss heute Nachricht
  ///
  /// In de, this message translates to:
  /// **'Diese Transaktion wird heute automatisch abgeschlossen, wenn kein Streitfall eröffnet wird.'**
  String get autoCompleteToday;

  /// Auto-Abschluss in X Tagen Nachricht
  ///
  /// In de, this message translates to:
  /// **'Diese Transaktion wird in {count} {count, plural, =1{Tag} other{Tagen}} automatisch abgeschlossen, wenn keine Aktion erfolgt.'**
  String autoCompleteInDays(int count);

  /// Streitfall offen Titel
  ///
  /// In de, this message translates to:
  /// **'Streitfall offen'**
  String get disputeOpen;

  /// Streitfall-Grund
  ///
  /// In de, this message translates to:
  /// **'Grund: {reason}'**
  String disputeReason(String reason);

  /// Streitfall eröffnet am
  ///
  /// In de, this message translates to:
  /// **'Eröffnet: {date}'**
  String disputeOpenedDate(String date);

  /// Moderator prüft Nachricht
  ///
  /// In de, this message translates to:
  /// **'Ein Moderator prüft diesen Streitfall.'**
  String get moderatorReviewing;

  /// Zahlungsinformationen Titel
  ///
  /// In de, this message translates to:
  /// **'Zahlungsinformationen'**
  String get paymentInformation;

  /// Zahlungsanweisung
  ///
  /// In de, this message translates to:
  /// **'Bitte sende die Zahlung an den Verkäufer mit den folgenden Details:'**
  String get sendPaymentTo;

  /// Transaktions-ID in Zahlung Hinweis
  ///
  /// In de, this message translates to:
  /// **'Der Verkäufer wird den Artikel versenden, sobald die Zahlung eingegangen ist. Bitte gib deine Transaktions-ID in der Zahlungsnotiz an.'**
  String get includeTransactionId;

  /// Nachrichten Screen Titel
  ///
  /// In de, this message translates to:
  /// **'Nachrichten'**
  String get messages;

  /// Posteingang Tab
  ///
  /// In de, this message translates to:
  /// **'Posteingang'**
  String get inbox;

  /// Gesendet Tab
  ///
  /// In de, this message translates to:
  /// **'Gesendet'**
  String get sent;

  /// Entwürfe Tab
  ///
  /// In de, this message translates to:
  /// **'Entwürfe'**
  String get drafts;

  /// Neue Nachricht Button
  ///
  /// In de, this message translates to:
  /// **'Neue Nachricht'**
  String get newMessage;

  /// Keine Nachrichten Titel
  ///
  /// In de, this message translates to:
  /// **'Keine Nachrichten'**
  String get noMessages;

  /// Posteingang leer Nachricht
  ///
  /// In de, this message translates to:
  /// **'Dein Posteingang ist leer.'**
  String get inboxEmpty;

  /// Keine gesendeten Nachrichten Titel
  ///
  /// In de, this message translates to:
  /// **'Keine gesendeten Nachrichten'**
  String get noSentMessages;

  /// Noch keine gesendeten Nachrichten Nachricht
  ///
  /// In de, this message translates to:
  /// **'Du hast noch keine Nachrichten gesendet.'**
  String get noSentMessagesYet;

  /// Keine Entwürfe Titel
  ///
  /// In de, this message translates to:
  /// **'Keine Entwürfe'**
  String get noDrafts;

  /// Keine gespeicherten Entwürfe Nachricht
  ///
  /// In de, this message translates to:
  /// **'Du hast keine gespeicherten Entwürfe.'**
  String get noSavedDrafts;

  /// Fehler beim Laden Titel
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Laden'**
  String get errorLoadingTitle;

  /// Von Label
  ///
  /// In de, this message translates to:
  /// **'Von: {username}'**
  String from(String username);

  /// An Label
  ///
  /// In de, this message translates to:
  /// **'An: {username}'**
  String to(String username);

  /// Gestern Label
  ///
  /// In de, this message translates to:
  /// **'Gestern'**
  String get yesterday;

  /// Montag Abkürzung
  ///
  /// In de, this message translates to:
  /// **'Mo'**
  String get monday;

  /// Dienstag Abkürzung
  ///
  /// In de, this message translates to:
  /// **'Di'**
  String get tuesday;

  /// Mittwoch Abkürzung
  ///
  /// In de, this message translates to:
  /// **'Mi'**
  String get wednesday;

  /// Donnerstag Abkürzung
  ///
  /// In de, this message translates to:
  /// **'Do'**
  String get thursday;

  /// Freitag Abkürzung
  ///
  /// In de, this message translates to:
  /// **'Fr'**
  String get friday;

  /// Samstag Abkürzung
  ///
  /// In de, this message translates to:
  /// **'Sa'**
  String get saturday;

  /// Sonntag Abkürzung
  ///
  /// In de, this message translates to:
  /// **'So'**
  String get sunday;

  /// Benutzer Nummer
  ///
  /// In de, this message translates to:
  /// **'Benutzer #{id}'**
  String userNumber(int id);

  /// Kein Empfänger Label
  ///
  /// In de, this message translates to:
  /// **'Kein Empfänger'**
  String get noRecipient;

  /// Zuletzt bearbeitet
  ///
  /// In de, this message translates to:
  /// **'Zuletzt bearbeitet: {date}'**
  String lastEdited(String date);

  /// Nachricht löschen Bestätigung Titel
  ///
  /// In de, this message translates to:
  /// **'Nachricht löschen?'**
  String get deleteMessage;

  /// Aktion nicht rückgängig machbar Warnung
  ///
  /// In de, this message translates to:
  /// **'Diese Aktion kann nicht rückgängig gemacht werden.'**
  String get actionCannotBeUndone;

  /// Entwurf löschen Bestätigung Titel
  ///
  /// In de, this message translates to:
  /// **'Entwurf löschen?'**
  String get deleteDraft;

  /// Antworten Button
  ///
  /// In de, this message translates to:
  /// **'Antworten'**
  String get reply;

  /// Entschlüsselung läuft Nachricht
  ///
  /// In de, this message translates to:
  /// **'Nachricht wird entschlüsselt...'**
  String get decryptingMessage;

  /// Entschlüsselung fehlgeschlagen Fallback
  ///
  /// In de, this message translates to:
  /// **'[Entschlüsselung fehlgeschlagen]'**
  String get decryptionFailed;

  /// Ende-zu-Ende verschlüsselt Label
  ///
  /// In de, this message translates to:
  /// **'Ende-zu-Ende verschlüsselt'**
  String get endToEndEncrypted;

  /// Von Benutzer Label
  ///
  /// In de, this message translates to:
  /// **'Von: {username}'**
  String fromUser(String username);

  /// Datum Label
  ///
  /// In de, this message translates to:
  /// **'Datum: {date}'**
  String dateLabel(String date);

  /// Betreff Label
  ///
  /// In de, this message translates to:
  /// **'Betreff'**
  String get subject;

  /// Kein Betreff Platzhalter
  ///
  /// In de, this message translates to:
  /// **'[Kein Betreff]'**
  String get noSubject;

  /// Nachricht Label
  ///
  /// In de, this message translates to:
  /// **'Nachricht'**
  String get message;

  /// Kein Inhalt Platzhalter
  ///
  /// In de, this message translates to:
  /// **'[Kein Inhalt]'**
  String get noContent;

  /// Entwurf bearbeiten Titel
  ///
  /// In de, this message translates to:
  /// **'Entwurf bearbeiten'**
  String get editDraft;

  /// Entwurf Button
  ///
  /// In de, this message translates to:
  /// **'Entwurf'**
  String get draft;

  /// Senden Button
  ///
  /// In de, this message translates to:
  /// **'Senden'**
  String get send;

  /// Empfänger Label
  ///
  /// In de, this message translates to:
  /// **'Empfänger'**
  String get recipient;

  /// Benutzername eingeben Hinweis
  ///
  /// In de, this message translates to:
  /// **'Benutzername eingeben'**
  String get enterUsername;

  /// Nachricht wird verschlüsselt Hinweis
  ///
  /// In de, this message translates to:
  /// **'Nachricht wird verschlüsselt'**
  String get messageWillBeEncrypted;

  /// Empfänger prüfen Hinweis
  ///
  /// In de, this message translates to:
  /// **'Klicke auf das Such-Icon um den Empfänger zu prüfen'**
  String get clickToVerifyRecipient;

  /// Benutzer nicht gefunden Fehler
  ///
  /// In de, this message translates to:
  /// **'Benutzer \"{username}\" nicht gefunden oder hat keinen PGP-Schlüssel'**
  String userNotFoundOrNoKey(String username);

  /// Empfänger wählen Validierung
  ///
  /// In de, this message translates to:
  /// **'Bitte wähle einen Empfänger'**
  String get pleaseSelectRecipient;

  /// Empfänger nicht verifiziert Fehler
  ///
  /// In de, this message translates to:
  /// **'Empfänger nicht verifiziert oder kein PGP-Schlüssel vorhanden. Bitte Empfänger prüfen.'**
  String get recipientNotVerified;

  /// Betreff eingeben Validierung
  ///
  /// In de, this message translates to:
  /// **'Bitte gib einen Betreff ein'**
  String get pleaseEnterSubject;

  /// Nachricht eingeben Validierung
  ///
  /// In de, this message translates to:
  /// **'Bitte gib eine Nachricht ein'**
  String get pleaseEnterMessage;

  /// Sendefehler
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Senden: {error}'**
  String errorSending(String error);

  /// Entwurf gespeichert Nachricht
  ///
  /// In de, this message translates to:
  /// **'Entwurf gespeichert'**
  String get draftSaved;

  /// Entwurf speichern Fehler
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Speichern: {error}'**
  String errorSavingDraft(String error);

  /// PGP-Schlüssel Titel
  ///
  /// In de, this message translates to:
  /// **'PGP-Schlüssel'**
  String get pgpKeys;

  /// Schlüsselinformationen Titel
  ///
  /// In de, this message translates to:
  /// **'Schlüssel-Informationen'**
  String get keyInformation;

  /// Schlüssel generieren Titel
  ///
  /// In de, this message translates to:
  /// **'Neuen Schlüssel generieren'**
  String get generateNewKey;

  /// Schlüssel exportieren Titel
  ///
  /// In de, this message translates to:
  /// **'Schlüssel exportieren'**
  String get exportKey;

  /// Schlüssel importieren Titel
  ///
  /// In de, this message translates to:
  /// **'Schlüssel importieren'**
  String get importKey;

  /// Server-Backup Titel
  ///
  /// In de, this message translates to:
  /// **'Server-Backup'**
  String get serverBackup;

  /// Sicherheitshinweise Titel
  ///
  /// In de, this message translates to:
  /// **'Sicherheitshinweise'**
  String get securityNotices;

  /// Backup-Passwort Dialog Titel
  ///
  /// In de, this message translates to:
  /// **'Backup-Passwort festlegen'**
  String get setBackupPassword;

  /// Schlüssel generieren Aktion
  ///
  /// In de, this message translates to:
  /// **'Schlüssel generieren'**
  String get generateKey;

  /// Private Key Export Titel
  ///
  /// In de, this message translates to:
  /// **'Private Key Export'**
  String get privateKeyExport;

  /// Private Key importieren Titel
  ///
  /// In de, this message translates to:
  /// **'Private Key importieren'**
  String get importPrivateKey;

  /// Schlüssel eingerichtet Status
  ///
  /// In de, this message translates to:
  /// **'Schlüssel eingerichtet'**
  String get keyConfigured;

  /// Schlüssel nicht vollständig Status
  ///
  /// In de, this message translates to:
  /// **'Schlüssel nicht vollständig'**
  String get keyIncomplete;

  /// Kann Nachrichten senden
  ///
  /// In de, this message translates to:
  /// **'Du kannst verschlüsselte Nachrichten senden und empfangen.'**
  String get canSendEncryptedMessages;

  /// Schlüssel generieren oder importieren
  ///
  /// In de, this message translates to:
  /// **'Generiere einen neuen Schlüssel oder importiere einen vorhandenen.'**
  String get generateOrImportKey;

  /// Private Key lokal, Public Key fehlt
  ///
  /// In de, this message translates to:
  /// **'Private Key vorhanden, aber Public Key nicht auf dem Server.'**
  String get privateKeyLocalPublicKeyMissing;

  /// Public Key auf Server, Private Key fehlt
  ///
  /// In de, this message translates to:
  /// **'Public Key auf Server, aber Private Key fehlt lokal.'**
  String get publicKeyOnServerPrivateKeyMissing;

  /// Schlüssel stimmen nicht überein
  ///
  /// In de, this message translates to:
  /// **'Schlüssel stimmen nicht überein.'**
  String get keysMismatch;

  /// Private Key exportieren Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Exportiere deinen Private Key für ein Backup. Bewahre ihn sicher auf!'**
  String get exportPrivateKeyForBackup;

  /// Private Key importieren Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Importiere einen vorhandenen Private Key (z.B. von einem Backup oder anderem Gerät).'**
  String get importExistingPrivateKey;

  /// Server-Backup Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Speichere deinen Private Key verschlüsselt auf dem Server. So kannst du ihn auf einem anderen Gerät wiederherstellen.'**
  String get storePrivateKeyEncryptedOnServer;

  /// Sicherheitshinweis Dialog Titel
  ///
  /// In de, this message translates to:
  /// **'Sicherheitshinweis'**
  String get securityWarning;

  /// Private Key auf Server speichern Warnung
  ///
  /// In de, this message translates to:
  /// **'Du bist dabei, deinen Private Key auf dem Server zu speichern.'**
  String get aboutToStorePrivateKeyOnServer;

  /// Verschlüsselung vor Upload Hinweis
  ///
  /// In de, this message translates to:
  /// **'Der Key wird mit einem Passwort verschlüsselt, bevor er hochgeladen wird. Trotzdem solltest du folgendes beachten:'**
  String get keyWillBeEncryptedBeforeUpload;

  /// Starkes Passwort wählen
  ///
  /// In de, this message translates to:
  /// **'Wähle ein starkes, einzigartiges Passwort'**
  String get chooseStrongUniquePassword;

  /// Passwort kann nicht zurückgesetzt werden
  ///
  /// In de, this message translates to:
  /// **'Dieses Passwort kann NICHT zurückgesetzt werden'**
  String get passwordCannotBeReset;

  /// Backup ohne Passwort wertlos
  ///
  /// In de, this message translates to:
  /// **'Ohne Passwort ist das Backup wertlos'**
  String get backupWorthlessWithoutPassword;

  /// Server-Betreiber könnte Passwort erraten
  ///
  /// In de, this message translates to:
  /// **'Der Server-Betreiber könnte versuchen, das Passwort zu erraten'**
  String get serverOperatorMightGuessPassword;

  /// Starkes Passwort für Backup
  ///
  /// In de, this message translates to:
  /// **'Wähle ein starkes Passwort für dein Backup. Du brauchst es, um den Key wiederherzustellen.'**
  String get chooseStrongPasswordForBackup;

  /// Passwörter stimmen nicht überein Fehler
  ///
  /// In de, this message translates to:
  /// **'Passwörter stimmen nicht überein'**
  String get passwordsDontMatch;

  /// Namen eingeben Validierung
  ///
  /// In de, this message translates to:
  /// **'Bitte gib einen Namen ein'**
  String get pleaseEnterName;

  /// Backup-Passwort eingeben
  ///
  /// In de, this message translates to:
  /// **'Gib das Passwort ein, mit dem du das Backup verschlüsselt hast:'**
  String get enterPasswordForBackup;

  /// Entschlüsselung und Import läuft
  ///
  /// In de, this message translates to:
  /// **'Entschlüssele und importiere...'**
  String get decryptingAndImporting;

  /// Entschlüsselung fehlgeschlagen Fehler
  ///
  /// In de, this message translates to:
  /// **'Entschlüsselung fehlgeschlagen. Falsches Passwort?'**
  String get decryptionFailedWrongPassword;

  /// Ich verstehe, fortfahren Button
  ///
  /// In de, this message translates to:
  /// **'Ich verstehe, fortfahren'**
  String get understandProceed;

  /// Public Key hochladen Button
  ///
  /// In de, this message translates to:
  /// **'Public Key hochladen'**
  String get uploadPublicKey;

  /// Generiere läuft
  ///
  /// In de, this message translates to:
  /// **'Generiere...'**
  String get generating;

  /// Private Key exportieren Button
  ///
  /// In de, this message translates to:
  /// **'Private Key exportieren'**
  String get exportPrivateKey;

  /// Private Key einfügen Button
  ///
  /// In de, this message translates to:
  /// **'Private Key einfügen'**
  String get pastePrivateKey;

  /// Vom Server-Backup laden Button
  ///
  /// In de, this message translates to:
  /// **'Vom Server-Backup laden'**
  String get loadFromServerBackup;

  /// Verschlüsseltes Backup erstellen Button
  ///
  /// In de, this message translates to:
  /// **'Verschlüsseltes Backup erstellen'**
  String get createEncryptedBackup;

  /// Fingerprint kopieren Button
  ///
  /// In de, this message translates to:
  /// **'Fingerprint kopieren'**
  String get copyFingerprint;

  /// Backup erstellen Button
  ///
  /// In de, this message translates to:
  /// **'Backup erstellen'**
  String get createBackup;

  /// Wiederherstellen Button
  ///
  /// In de, this message translates to:
  /// **'Wiederherstellen'**
  String get restore;

  /// Fehler beim Laden
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Laden: {error}'**
  String errorLoading(String error);

  /// Schlüssel wird ersetzt Warnung
  ///
  /// In de, this message translates to:
  /// **'Der vorhandene Schlüssel wird ersetzt!'**
  String get existingKeyWillBeReplaced;

  /// Ungültiger Key Fehler
  ///
  /// In de, this message translates to:
  /// **'Ungültiger Key nach Entschlüsselung'**
  String get invalidKeyAfterDecryption;

  /// Kein Private Key Fehler
  ///
  /// In de, this message translates to:
  /// **'Kein Private Key vorhanden'**
  String get noPrivateKey;

  /// Kein Fingerprint Fehler
  ///
  /// In de, this message translates to:
  /// **'Kein Fingerprint vorhanden'**
  String get noFingerprint;

  /// Backup gespeichert Erfolg
  ///
  /// In de, this message translates to:
  /// **'Backup erfolgreich auf Server gespeichert!'**
  String get backupSuccessfullySaved;

  /// Backup Fehler
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Backup: {error}'**
  String errorBackup(String error);

  /// Kein Backup gefunden
  ///
  /// In de, this message translates to:
  /// **'Kein Backup auf dem Server gefunden.'**
  String get noBackupOnServer;

  /// Generierung Fehler
  ///
  /// In de, this message translates to:
  /// **'Fehler bei der Generierung: {error}'**
  String errorGeneration(String error);

  /// Schlüssel generiert Erfolg
  ///
  /// In de, this message translates to:
  /// **'Schlüssel erfolgreich generiert und hochgeladen!'**
  String get keySuccessfullyGenerated;

  /// Upload Fehler
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Hochladen: {error}'**
  String errorUploading(String error);

  /// Private Key verlässt Gerät nie
  ///
  /// In de, this message translates to:
  /// **'Dein Private Key verlässt niemals dieses Gerät'**
  String get privateKeyNeverLeavesDevice;

  /// Nur Public Key auf Server
  ///
  /// In de, this message translates to:
  /// **'Nur der Public Key wird auf dem Server gespeichert'**
  String get onlyPublicKeyStoredOnServer;

  /// Regelmäßige Backups empfohlen
  ///
  /// In de, this message translates to:
  /// **'Erstelle regelmäßig Backups deines Private Keys'**
  String get regularBackupsRecommended;

  /// Verlorener Key kann Nachrichten nicht entschlüsseln
  ///
  /// In de, this message translates to:
  /// **'Bei Verlust des Keys können alte Nachrichten nicht entschlüsselt werden'**
  String get lostKeyCannotDecryptOldMessages;

  /// Ed25519 Schlüssel erstellen Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Erstellt einen neuen Ed25519/Curve25519 Schlüssel. Dies dauert nur wenige Sekunden.'**
  String get createsNewEd25519Key;

  /// Ed25519 Schlüssel wird erstellt
  ///
  /// In de, this message translates to:
  /// **'Ed25519/Curve25519 Schlüssel wird erstellt. Dies dauert nur wenige Sekunden.'**
  String get generatingEd25519Key;

  /// Schlüssel wiederhergestellt Erfolg
  ///
  /// In de, this message translates to:
  /// **'Schlüssel erfolgreich wiederhergestellt!'**
  String get keySuccessfullyRestored;

  /// Mit Passphrase schützen Checkbox
  ///
  /// In de, this message translates to:
  /// **'Mit Passphrase schützen'**
  String get protectWithPassphrase;

  /// Empfohlen für Sicherheit
  ///
  /// In de, this message translates to:
  /// **'Empfohlen für zusätzliche Sicherheit'**
  String get recommendedForSecurity;

  /// Passphrase Label
  ///
  /// In de, this message translates to:
  /// **'Passphrase'**
  String get passphrase;

  /// Sichere Passphrase eingeben Hint
  ///
  /// In de, this message translates to:
  /// **'Sichere Passphrase eingeben'**
  String get enterSecurePassphrase;

  /// Name Label
  ///
  /// In de, this message translates to:
  /// **'Name'**
  String get name;

  /// Dein Name Hint
  ///
  /// In de, this message translates to:
  /// **'Dein Name'**
  String get yourName;

  /// E-Mail optional Label
  ///
  /// In de, this message translates to:
  /// **'E-Mail (optional)'**
  String get emailOptional;

  /// E-Mail Hint
  ///
  /// In de, this message translates to:
  /// **'deine@email.com'**
  String get yourEmailCom;

  /// Fingerprint Label
  ///
  /// In de, this message translates to:
  /// **'Fingerprint'**
  String get fingerprint;

  /// Algorithmus Label
  ///
  /// In de, this message translates to:
  /// **'Algorithmus'**
  String get algorithm;

  /// Schlüsselgröße Label
  ///
  /// In de, this message translates to:
  /// **'Schlüsselgröße'**
  String get keySize;

  /// Identität Label
  ///
  /// In de, this message translates to:
  /// **'Identität'**
  String get identity;

  /// Schlüssel sicher aufbewahren Warnung
  ///
  /// In de, this message translates to:
  /// **'Bewahre diesen Schlüssel sicher auf! Teile ihn niemals mit anderen.'**
  String get keepKeySafe;

  /// Private Key einfügen Anleitung
  ///
  /// In de, this message translates to:
  /// **'Füge deinen Private Key im PGP-Armor Format ein:'**
  String get pastePrivateKeyInPgpFormat;

  /// PGP Private Key Block Anfang
  ///
  /// In de, this message translates to:
  /// **'-----BEGIN PGP PRIVATE KEY BLOCK-----'**
  String get beginPgpPrivateKeyBlock;

  /// Key einfügen Validierung
  ///
  /// In de, this message translates to:
  /// **'Bitte füge einen Key ein'**
  String get pleasePasteKey;

  /// Ungültiges Key-Format Fehler
  ///
  /// In de, this message translates to:
  /// **'Ungültiges Key-Format'**
  String get invalidKeyFormat;

  /// Private Key importiert Erfolg
  ///
  /// In de, this message translates to:
  /// **'Private Key erfolgreich importiert!'**
  String get privateKeySuccessfullyImported;

  /// Backup auswählen Anleitung
  ///
  /// In de, this message translates to:
  /// **'Wähle das Backup aus, das du wiederherstellen möchtest:'**
  String get selectBackupToRestore;

  /// Backup auswählen Titel
  ///
  /// In de, this message translates to:
  /// **'Backup auswählen'**
  String get selectBackup;

  /// Backup entschlüsseln Titel
  ///
  /// In de, this message translates to:
  /// **'Backup entschlüsseln'**
  String get decryptBackup;

  /// In Zwischenablage kopiert Nachricht
  ///
  /// In de, this message translates to:
  /// **'{label} in die Zwischenablage kopiert'**
  String copiedToClipboard(String label);

  /// Public Key hochgeladen Erfolg
  ///
  /// In de, this message translates to:
  /// **'Public Key erfolgreich hochgeladen!'**
  String get publicKeySuccessfullyUploaded;

  /// Backup-Passwort Label
  ///
  /// In de, this message translates to:
  /// **'Backup-Passwort'**
  String get backupPassword;

  /// Schlüsselgenerierung Timeout Fehler
  ///
  /// In de, this message translates to:
  /// **'Schlüsselgenerierung dauert zu lange. Bitte versuche es erneut oder starte die App neu.'**
  String get keyGenerationTooLong;

  /// Kein eigener PGP-Schlüssel Fehler
  ///
  /// In de, this message translates to:
  /// **'Kein eigener PGP-Schlüssel vorhanden. Bitte lade deinen Public Key hoch.'**
  String get noOwnPgpKey;

  /// Empfänger hat keinen PGP-Schlüssel Fehler
  ///
  /// In de, this message translates to:
  /// **'Empfänger hat keinen PGP-Schlüssel'**
  String get recipientHasNoPgpKey;

  /// Admin-Panel Titel
  ///
  /// In de, this message translates to:
  /// **'Admin-Panel'**
  String get adminPanel;

  /// Admin-Panel Willkommensnachricht
  ///
  /// In de, this message translates to:
  /// **'Willkommen im Admin-Bereich'**
  String get adminPanelWelcome;

  /// Benutzerverwaltung Label
  ///
  /// In de, this message translates to:
  /// **'Benutzerverwaltung'**
  String get userManagement;

  /// Kategorienverwaltung Label
  ///
  /// In de, this message translates to:
  /// **'Kategorienverwaltung'**
  String get categoryManagement;

  /// News-Verwaltung Label
  ///
  /// In de, this message translates to:
  /// **'News-Verwaltung'**
  String get newsManagement;

  /// Zahlungseinstellungen Label
  ///
  /// In de, this message translates to:
  /// **'Zahlungseinstellungen'**
  String get paymentSettings;

  /// Ausstehende Zahlungen Label
  ///
  /// In de, this message translates to:
  /// **'Ausstehende Zahlungen'**
  String get pendingPayments;

  /// Slot-Varianten Label
  ///
  /// In de, this message translates to:
  /// **'Slot-Varianten'**
  String get slotVariants;

  /// Moderator-Panel Titel
  ///
  /// In de, this message translates to:
  /// **'Moderator-Panel'**
  String get moderatorPanel;

  /// Moderator-Panel Willkommensnachricht
  ///
  /// In de, this message translates to:
  /// **'Willkommen im Moderations-Bereich'**
  String get moderatorPanelWelcome;

  /// Meldungen Label
  ///
  /// In de, this message translates to:
  /// **'Meldungen'**
  String get reports;

  /// Streitfälle Label
  ///
  /// In de, this message translates to:
  /// **'Streitfälle'**
  String get disputes;

  /// Alle Meldungen Tab
  ///
  /// In de, this message translates to:
  /// **'Alle'**
  String get allReports;

  /// Offene Meldungen Tab
  ///
  /// In de, this message translates to:
  /// **'Offen'**
  String get openReports;

  /// In Prüfung Meldungen Tab
  ///
  /// In de, this message translates to:
  /// **'In Prüfung'**
  String get inReviewReports;

  /// Gelöste Meldungen Tab
  ///
  /// In de, this message translates to:
  /// **'Gelöst'**
  String get resolvedReports;

  /// Abgewiesene Meldungen Tab
  ///
  /// In de, this message translates to:
  /// **'Abgewiesen'**
  String get dismissedReports;

  /// Meldungsstatus Offen
  ///
  /// In de, this message translates to:
  /// **'OFFEN'**
  String get statusReportOpen;

  /// Meldungsstatus In Prüfung
  ///
  /// In de, this message translates to:
  /// **'IN PRÜFUNG'**
  String get statusReportInReview;

  /// Meldungsstatus Gelöst
  ///
  /// In de, this message translates to:
  /// **'GELÖST'**
  String get statusReportResolved;

  /// Meldungsstatus Abgewiesen
  ///
  /// In de, this message translates to:
  /// **'ABGEWIESEN'**
  String get statusReportDismissed;

  /// Gemeldet von Label
  ///
  /// In de, this message translates to:
  /// **'Gemeldet von'**
  String get reportedBy;

  /// Gemeldeter Benutzer Label
  ///
  /// In de, this message translates to:
  /// **'Gemeldeter Benutzer'**
  String get reportedUser;

  /// Gemeldetes Angebot
  ///
  /// In de, this message translates to:
  /// **'Gemeldetes Angebot'**
  String get reportedListing;

  /// Meldegrund Label
  ///
  /// In de, this message translates to:
  /// **'Grund'**
  String get reportReason;

  /// Meldegrund: Spam
  ///
  /// In de, this message translates to:
  /// **'Spam'**
  String get reportReasonSpam;

  /// Meldegrund: Unangemessen
  ///
  /// In de, this message translates to:
  /// **'Unangemessener Inhalt'**
  String get reportReasonInappropriate;

  /// Meldegrund: Scam
  ///
  /// In de, this message translates to:
  /// **'Betrug/Scam'**
  String get reportReasonScam;

  /// Meldegrund: Belästigung
  ///
  /// In de, this message translates to:
  /// **'Belästigung'**
  String get reportReasonHarassment;

  /// Meldegrund Falsche Informationen
  ///
  /// In de, this message translates to:
  /// **'Falsche Informationen'**
  String get reportReasonFakeInfo;

  /// Meldegrund: Sonstiges
  ///
  /// In de, this message translates to:
  /// **'Sonstiges'**
  String get reportReasonOther;

  /// Keine Meldungen Titel
  ///
  /// In de, this message translates to:
  /// **'Keine Meldungen'**
  String get noReports;

  /// Keine Meldungen Nachricht
  ///
  /// In de, this message translates to:
  /// **'Es gibt aktuell keine Meldungen zu prüfen.'**
  String get noReportsMessage;

  /// Meldung ansehen Button
  ///
  /// In de, this message translates to:
  /// **'Meldung ansehen'**
  String get viewReport;

  /// Meldungsdetails Titel
  ///
  /// In de, this message translates to:
  /// **'Meldungsdetails'**
  String get reportDetail;

  /// Meldung ID
  ///
  /// In de, this message translates to:
  /// **'Meldung #{id}'**
  String reportId(int id);

  /// Meldungstyp Label
  ///
  /// In de, this message translates to:
  /// **'Typ'**
  String get reportType;

  /// Meldungstyp Benutzer
  ///
  /// In de, this message translates to:
  /// **'Benutzer'**
  String get reportTypeUser;

  /// Meldungstyp Angebot
  ///
  /// In de, this message translates to:
  /// **'Angebot'**
  String get reportTypeListing;

  /// Gemeldet am Label
  ///
  /// In de, this message translates to:
  /// **'Gemeldet am'**
  String get reportedAt;

  /// Meldungsbeschreibung Label
  ///
  /// In de, this message translates to:
  /// **'Beschreibung'**
  String get reportDescription;

  /// Moderator-Notizen Titel
  ///
  /// In de, this message translates to:
  /// **'Moderator-Notizen'**
  String get moderatorNotes;

  /// Notiz hinzufügen Button
  ///
  /// In de, this message translates to:
  /// **'Notiz hinzufügen'**
  String get addNote;

  /// Interne Notizen Hinweis
  ///
  /// In de, this message translates to:
  /// **'Nur für Moderatoren sichtbar'**
  String get internalNotesOnly;

  /// Notiz eingeben Hint
  ///
  /// In de, this message translates to:
  /// **'Notiz eingeben...'**
  String get enterNote;

  /// Notiz gespeichert Bestätigung
  ///
  /// In de, this message translates to:
  /// **'Notiz wurde gespeichert'**
  String get noteSaved;

  /// Maßnahme ergreifen Button
  ///
  /// In de, this message translates to:
  /// **'Maßnahme ergreifen'**
  String get takeAction;

  /// Als in Prüfung markieren Button
  ///
  /// In de, this message translates to:
  /// **'Als in Prüfung markieren'**
  String get markAsInReview;

  /// Meldung lösen Button
  ///
  /// In de, this message translates to:
  /// **'Meldung lösen'**
  String get resolveReport;

  /// Meldung abweisen Button
  ///
  /// In de, this message translates to:
  /// **'Meldung abweisen'**
  String get dismissReport;

  /// Gemeldeten Benutzer ansehen Button
  ///
  /// In de, this message translates to:
  /// **'Gemeldeten Benutzer ansehen'**
  String get viewReportedUser;

  /// Gemeldetes Angebot ansehen Button
  ///
  /// In de, this message translates to:
  /// **'Gemeldetes Angebot ansehen'**
  String get viewReportedListing;

  /// Benutzer verwarnen Button
  ///
  /// In de, this message translates to:
  /// **'Benutzer verwarnen'**
  String get warnUser;

  /// Benutzer sperren
  ///
  /// In de, this message translates to:
  /// **'Benutzer sperren'**
  String get banUser;

  /// Als in Prüfung markiert Nachricht
  ///
  /// In de, this message translates to:
  /// **'Meldung als in Prüfung markiert'**
  String get reportMarkedInReview;

  /// Meldung gelöst Nachricht
  ///
  /// In de, this message translates to:
  /// **'Meldung gelöst'**
  String get reportResolved;

  /// Meldung abgewiesen Nachricht
  ///
  /// In de, this message translates to:
  /// **'Meldung abgewiesen'**
  String get reportDismissed;

  /// Meldung lösen Bestätigung
  ///
  /// In de, this message translates to:
  /// **'Möchtest du diese Meldung als gelöst markieren?'**
  String get confirmResolveReport;

  /// Meldung abweisen Bestätigung
  ///
  /// In de, this message translates to:
  /// **'Möchtest du diese Meldung abweisen?'**
  String get confirmDismissReport;

  /// Lösen Button
  ///
  /// In de, this message translates to:
  /// **'Lösen'**
  String get resolve;

  /// Abweisen Button
  ///
  /// In de, this message translates to:
  /// **'Abweisen'**
  String get dismiss;

  /// Benutzerdetails Titel
  ///
  /// In de, this message translates to:
  /// **'Benutzerdetails'**
  String get userDetail;

  /// Benutzer ID
  ///
  /// In de, this message translates to:
  /// **'ID: {id}'**
  String userId(int id);

  /// Registriert am Label
  ///
  /// In de, this message translates to:
  /// **'Registriert am'**
  String get registeredAt;

  /// Zuletzt aktiv Label
  ///
  /// In de, this message translates to:
  /// **'Zuletzt aktiv'**
  String get lastActive;

  /// Angebote gesamt Label
  ///
  /// In de, this message translates to:
  /// **'Angebote gesamt'**
  String get totalListings;

  /// Transaktionen gesamt Label
  ///
  /// In de, this message translates to:
  /// **'Transaktionen gesamt'**
  String get totalTransactions;

  /// Bewertung Label
  ///
  /// In de, this message translates to:
  /// **'Bewertung'**
  String get userRating;

  /// Benutzerstatus Label
  ///
  /// In de, this message translates to:
  /// **'Status'**
  String get userStatus;

  /// Benutzerstatus Aktiv
  ///
  /// In de, this message translates to:
  /// **'Aktiv'**
  String get userStatusActive;

  /// Benutzerstatus Gesperrt
  ///
  /// In de, this message translates to:
  /// **'Gesperrt'**
  String get userStatusBanned;

  /// Benutzerstatus Verwarnt
  ///
  /// In de, this message translates to:
  /// **'Verwarnt'**
  String get userStatusWarned;

  /// Benutzer sperren Dialog Titel
  ///
  /// In de, this message translates to:
  /// **'Benutzer sperren'**
  String get banUserDialog;

  /// Sperrgrund
  ///
  /// In de, this message translates to:
  /// **'Grund: {reason}'**
  String banReason(String reason);

  /// Sperrgrund wählen Label
  ///
  /// In de, this message translates to:
  /// **'Sperrgrund wählen'**
  String get selectBanReason;

  /// Ban-Grund: Spam
  ///
  /// In de, this message translates to:
  /// **'Spam'**
  String get banReasonSpam;

  /// Sperrgrund Betrug
  ///
  /// In de, this message translates to:
  /// **'Betrug'**
  String get banReasonScam;

  /// Ban-Grund: Belästigung
  ///
  /// In de, this message translates to:
  /// **'Belästigung anderer Nutzer'**
  String get banReasonHarassment;

  /// Sperrgrund Illegaler Inhalt
  ///
  /// In de, this message translates to:
  /// **'Illegaler Inhalt'**
  String get banReasonIllegalContent;

  /// Sperrgrund Mehrfache Verstöße
  ///
  /// In de, this message translates to:
  /// **'Mehrfache Verstöße'**
  String get banReasonMultipleViolations;

  /// Sperrgrund Sonstiges
  ///
  /// In de, this message translates to:
  /// **'Sonstiges'**
  String get banReasonOther;

  /// Sperrdauer Label
  ///
  /// In de, this message translates to:
  /// **'Sperrdauer'**
  String get banDuration;

  /// Sperrdauer 24 Stunden
  ///
  /// In de, this message translates to:
  /// **'24 Stunden'**
  String get banDuration24h;

  /// Sperrdauer 7 Tage
  ///
  /// In de, this message translates to:
  /// **'7 Tage'**
  String get banDuration7d;

  /// Sperrdauer 30 Tage
  ///
  /// In de, this message translates to:
  /// **'30 Tage'**
  String get banDuration30d;

  /// Sperrdauer Permanent
  ///
  /// In de, this message translates to:
  /// **'Permanent'**
  String get banDurationPermanent;

  /// Zusätzliche Notizen Label
  ///
  /// In de, this message translates to:
  /// **'Zusätzliche Notizen'**
  String get additionalNotes;

  /// Optionale Notizen Hint
  ///
  /// In de, this message translates to:
  /// **'Optional: Zusätzliche Informationen...'**
  String get optionalNotes;

  /// Benutzer sperren Bestätigung
  ///
  /// In de, this message translates to:
  /// **'Möchtest du diesen Benutzer wirklich sperren?'**
  String get confirmBanUser;

  /// Sperren Button
  ///
  /// In de, this message translates to:
  /// **'Sperren'**
  String get ban;

  /// Benutzer gesperrt Bestätigung
  ///
  /// In de, this message translates to:
  /// **'Benutzer wurde gesperrt'**
  String get userBanned;

  /// Benutzer verwarnt Nachricht
  ///
  /// In de, this message translates to:
  /// **'Benutzer verwarnt'**
  String get userWarned;

  /// News-Verwaltung Screen Titel
  ///
  /// In de, this message translates to:
  /// **'News-Verwaltung'**
  String get newsManagementScreen;

  /// Alle News Tab
  ///
  /// In de, this message translates to:
  /// **'Alle News'**
  String get allNews;

  /// Veröffentlichte News Tab
  ///
  /// In de, this message translates to:
  /// **'Veröffentlicht'**
  String get publishedNews;

  /// News-Entwürfe Tab
  ///
  /// In de, this message translates to:
  /// **'Entwürfe'**
  String get draftNews;

  /// News erstellen Button
  ///
  /// In de, this message translates to:
  /// **'News erstellen'**
  String get createNews;

  /// Keine News Titel
  ///
  /// In de, this message translates to:
  /// **'Keine News vorhanden'**
  String get noNewsItems;

  /// Keine News Nachricht
  ///
  /// In de, this message translates to:
  /// **'Es wurden noch keine News erstellt.'**
  String get noNewsItemsMessage;

  /// News-Titel Label
  ///
  /// In de, this message translates to:
  /// **'Titel'**
  String get newsTitle;

  /// News-Inhalt Label
  ///
  /// In de, this message translates to:
  /// **'Inhalt'**
  String get newsContent;

  /// News-Status Label
  ///
  /// In de, this message translates to:
  /// **'Status'**
  String get newsStatus;

  /// News-Status Veröffentlicht
  ///
  /// In de, this message translates to:
  /// **'Veröffentlicht'**
  String get newsStatusPublished;

  /// News-Status Entwurf
  ///
  /// In de, this message translates to:
  /// **'Entwurf'**
  String get newsStatusDraft;

  /// Veröffentlicht am Label
  ///
  /// In de, this message translates to:
  /// **'Veröffentlicht am'**
  String get publishedAt;

  /// News bearbeiten Button
  ///
  /// In de, this message translates to:
  /// **'News bearbeiten'**
  String get editNews;

  /// News löschen Button
  ///
  /// In de, this message translates to:
  /// **'News löschen'**
  String get deleteNews;

  /// News erstellen Dialog Titel
  ///
  /// In de, this message translates to:
  /// **'News erstellen'**
  String get createNewsItem;

  /// News bearbeiten Dialog Titel
  ///
  /// In de, this message translates to:
  /// **'News bearbeiten'**
  String get editNewsItem;

  /// News-Titel Hint
  ///
  /// In de, this message translates to:
  /// **'News-Titel eingeben'**
  String get enterNewsTitle;

  /// News-Inhalt Hint
  ///
  /// In de, this message translates to:
  /// **'News-Inhalt eingeben...'**
  String get enterNewsContent;

  /// News-Titel erforderlich Validierung
  ///
  /// In de, this message translates to:
  /// **'Titel ist erforderlich'**
  String get newsTitleRequired;

  /// News-Inhalt erforderlich Validierung
  ///
  /// In de, this message translates to:
  /// **'Inhalt ist erforderlich'**
  String get newsContentRequired;

  /// Veröffentlichen Button
  ///
  /// In de, this message translates to:
  /// **'Veröffentlichen'**
  String get publish;

  /// Als Entwurf speichern Button
  ///
  /// In de, this message translates to:
  /// **'Als Entwurf speichern'**
  String get saveAsDraft;

  /// News erstellt Nachricht
  ///
  /// In de, this message translates to:
  /// **'News erstellt'**
  String get newsCreated;

  /// News aktualisiert Nachricht
  ///
  /// In de, this message translates to:
  /// **'News aktualisiert'**
  String get newsUpdated;

  /// News gelöscht Nachricht
  ///
  /// In de, this message translates to:
  /// **'News gelöscht'**
  String get newsDeleted;

  /// News löschen Bestätigung
  ///
  /// In de, this message translates to:
  /// **'Möchtest du diese News wirklich löschen?'**
  String get confirmDeleteNews;

  /// News löschen Bestätigung mit Titel
  ///
  /// In de, this message translates to:
  /// **'Möchtest du \"{title}\" wirklich löschen?'**
  String confirmDeleteNewsWithTitle(String title);

  /// Abgelaufene löschen Button
  ///
  /// In de, this message translates to:
  /// **'Abgelaufene löschen'**
  String get deleteExpired;

  /// Abgelaufene News löschen Dialog Titel
  ///
  /// In de, this message translates to:
  /// **'Abgelaufene News löschen'**
  String get deleteExpiredNews;

  /// Abgelaufene News löschen Bestätigung
  ///
  /// In de, this message translates to:
  /// **'Möchtest du alle abgelaufenen News löschen?'**
  String get confirmDeleteExpiredNews;

  /// Abgelaufene News gelöscht Nachricht
  ///
  /// In de, this message translates to:
  /// **'{count} abgelaufene News gelöscht'**
  String expiredNewsDeleted(int count);

  /// News-Status Abgelaufen
  ///
  /// In de, this message translates to:
  /// **'Abgelaufen'**
  String get newsStatusExpired;

  /// Erstellt Label mit Datum
  ///
  /// In de, this message translates to:
  /// **'Erstellt: {date}'**
  String createdLabel(String date);

  /// Läuft ab Label mit Datum
  ///
  /// In de, this message translates to:
  /// **'Läuft ab: {date}'**
  String expiresLabel(String date);

  /// Markdown wird unterstützt Hinweis
  ///
  /// In de, this message translates to:
  /// **'Markdown wird unterstützt'**
  String get markdownSupported;

  /// Lebenszeit in Tagen Label
  ///
  /// In de, this message translates to:
  /// **'Lebenszeit (Tage)'**
  String get lifetimeDays;

  /// Standard Lebenszeit Hinweis
  ///
  /// In de, this message translates to:
  /// **'Standard: 14 Tage'**
  String get defaultLifetimeDays;

  /// Ablaufdatum Label
  ///
  /// In de, this message translates to:
  /// **'Ablaufdatum'**
  String get expiryDate;

  /// Kein Ablaufdatum Text
  ///
  /// In de, this message translates to:
  /// **'Kein Ablaufdatum'**
  String get noExpiryDate;

  /// Veröffentlichen News Nachricht
  ///
  /// In de, this message translates to:
  /// **'News wird auf dem Dashboard angezeigt'**
  String get publishNewsMessage;

  /// Titel und Inhalt erforderlich Validierung
  ///
  /// In de, this message translates to:
  /// **'Titel und Inhalt dürfen nicht leer sein'**
  String get titleContentRequired;

  /// Erstelle erste News Nachricht
  ///
  /// In de, this message translates to:
  /// **'Erstelle die erste News mit dem + Button.'**
  String get createFirstNews;

  /// Fehler beim Löschen Nachricht
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Löschen: {error}'**
  String errorDeleting(String error);

  /// Kategorienverwaltung Screen Titel
  ///
  /// In de, this message translates to:
  /// **'Kategorienverwaltung'**
  String get categoryManagementScreen;

  /// Kategorien Tab
  ///
  /// In de, this message translates to:
  /// **'Kategorien'**
  String get categories;

  /// Subkategorien Tab
  ///
  /// In de, this message translates to:
  /// **'Subkategorien'**
  String get subcategories;

  /// Kategorie erstellen Button
  ///
  /// In de, this message translates to:
  /// **'Kategorie erstellen'**
  String get createCategory;

  /// Subkategorie erstellen Button
  ///
  /// In de, this message translates to:
  /// **'Subkategorie erstellen'**
  String get createSubcategory;

  /// Keine Kategorien Titel
  ///
  /// In de, this message translates to:
  /// **'Keine Kategorien'**
  String get noCategories;

  /// Keine Kategorien Nachricht
  ///
  /// In de, this message translates to:
  /// **'Es wurden noch keine Kategorien erstellt.'**
  String get noCategoriesMessage;

  /// Keine Subkategorien Titel
  ///
  /// In de, this message translates to:
  /// **'Keine Subkategorien'**
  String get noSubcategories;

  /// Keine Subkategorien Nachricht
  ///
  /// In de, this message translates to:
  /// **'Es wurden noch keine Subkategorien erstellt.'**
  String get noSubcategoriesMessage;

  /// Kategoriename Label
  ///
  /// In de, this message translates to:
  /// **'Name'**
  String get categoryName;

  /// Kategoriebeschreibung Label
  ///
  /// In de, this message translates to:
  /// **'Beschreibung'**
  String get categoryDescription;

  /// Übergeordnete Kategorie Label
  ///
  /// In de, this message translates to:
  /// **'Übergeordnete Kategorie'**
  String get parentCategory;

  /// Anzahl Angebote Label
  ///
  /// In de, this message translates to:
  /// **'Angebote'**
  String get listingsCount;

  /// Kategorie bearbeiten Button
  ///
  /// In de, this message translates to:
  /// **'Kategorie bearbeiten'**
  String get editCategory;

  /// Kategorie löschen Button
  ///
  /// In de, this message translates to:
  /// **'Kategorie löschen'**
  String get deleteCategory;

  /// Kategorie erstellen Dialog Titel
  ///
  /// In de, this message translates to:
  /// **'Kategorie erstellen'**
  String get createCategoryDialog;

  /// Kategorie bearbeiten Dialog Titel
  ///
  /// In de, this message translates to:
  /// **'Kategorie bearbeiten'**
  String get editCategoryDialog;

  /// Kategoriename Hint
  ///
  /// In de, this message translates to:
  /// **'Kategoriename eingeben'**
  String get enterCategoryName;

  /// Kategoriebeschreibung Hint
  ///
  /// In de, this message translates to:
  /// **'Beschreibung eingeben (optional)'**
  String get enterCategoryDescription;

  /// Kategoriename erforderlich Validierung
  ///
  /// In de, this message translates to:
  /// **'Name ist erforderlich'**
  String get categoryNameRequired;

  /// Kategorie erstellt Nachricht
  ///
  /// In de, this message translates to:
  /// **'Kategorie erstellt'**
  String get categoryCreated;

  /// Kategorie aktualisiert Nachricht
  ///
  /// In de, this message translates to:
  /// **'Kategorie aktualisiert'**
  String get categoryUpdated;

  /// Kategorie gelöscht Nachricht
  ///
  /// In de, this message translates to:
  /// **'Kategorie gelöscht'**
  String get categoryDeleted;

  /// Kategorie löschen Bestätigung
  ///
  /// In de, this message translates to:
  /// **'Möchtest du diese Kategorie wirklich löschen? Alle zugehörigen Subkategorien werden ebenfalls gelöscht.'**
  String get confirmDeleteCategory;

  /// Kategorie löschen Bestätigung mit Name
  ///
  /// In de, this message translates to:
  /// **'Möchtest du \"{name}\" wirklich löschen?'**
  String confirmDeleteCategoryWithName(String name);

  /// Neue Kategorie Dialog Titel
  ///
  /// In de, this message translates to:
  /// **'Neue Kategorie'**
  String get newCategory;

  /// Unterkategorie hinzufügen Tooltip
  ///
  /// In de, this message translates to:
  /// **'Unterkategorie hinzufügen'**
  String get addSubcategory;

  /// Erstelle erste Kategorie Nachricht
  ///
  /// In de, this message translates to:
  /// **'Erstelle die erste Kategorie mit dem + Button.'**
  String get createFirstCategory;

  /// Unterkategorien Anzahl mit Sortierung
  ///
  /// In de, this message translates to:
  /// **'{count} Unterkategorien • Sortierung: {sortOrder}'**
  String subcategoriesCount(int count, int sortOrder);

  /// Sortierung
  ///
  /// In de, this message translates to:
  /// **'Sortierung'**
  String get sorting;

  /// Sortierung Label
  ///
  /// In de, this message translates to:
  /// **'Sortierung: {sortOrder}'**
  String sortingLabel(int sortOrder);

  /// Sortierung Hinweis
  ///
  /// In de, this message translates to:
  /// **'0'**
  String get sortingHint;

  /// Kategorie aktiv Nachricht
  ///
  /// In de, this message translates to:
  /// **'Kategorie wird Benutzern angezeigt'**
  String get categoryShownToUsers;

  /// Kategorie hat Unterkategorien Warnung
  ///
  /// In de, this message translates to:
  /// **'Diese Kategorie hat {count} Unterkategorien, die ebenfalls gelöscht werden!'**
  String categoryHasSubcategories(int count);

  /// Name erforderlich Validierung
  ///
  /// In de, this message translates to:
  /// **'Name darf nicht leer sein'**
  String get nameRequired;

  /// Zahlungseinstellungen Screen Titel
  ///
  /// In de, this message translates to:
  /// **'Zahlungseinstellungen'**
  String get paymentSettingsScreen;

  /// Zahlungsmethoden Label
  ///
  /// In de, this message translates to:
  /// **'Zahlungsmethoden'**
  String get paymentMethods;

  /// Gebühren Label
  ///
  /// In de, this message translates to:
  /// **'Gebühren'**
  String get fees;

  /// PayPal aktiviert Label
  ///
  /// In de, this message translates to:
  /// **'PayPal aktiviert'**
  String get paypalEnabled;

  /// Bitcoin aktiviert Label
  ///
  /// In de, this message translates to:
  /// **'Bitcoin aktiviert'**
  String get bitcoinEnabled;

  /// Transaktionsgebühr Label
  ///
  /// In de, this message translates to:
  /// **'Transaktionsgebühr'**
  String get transactionFee;

  /// Plattformgebühr Label
  ///
  /// In de, this message translates to:
  /// **'Plattformgebühr'**
  String get platformFee;

  /// Gebührenprozentsatz Label
  ///
  /// In de, this message translates to:
  /// **'Prozentsatz'**
  String get feePercentage;

  /// Mindestgebühr Label
  ///
  /// In de, this message translates to:
  /// **'Mindestgebühr'**
  String get minimumFee;

  /// Höchstgebühr Label
  ///
  /// In de, this message translates to:
  /// **'Höchstgebühr'**
  String get maximumFee;

  /// Einstellungen gespeichert Nachricht
  ///
  /// In de, this message translates to:
  /// **'Einstellungen gespeichert'**
  String get settingsSaved;

  /// Einstellungen speichern Button
  ///
  /// In de, this message translates to:
  /// **'Einstellungen speichern'**
  String get saveSettings;

  /// Zahlungseinstellungen Info
  ///
  /// In de, this message translates to:
  /// **'Diese Einstellungen bestimmen, wie Benutzer für Slots bezahlen können.'**
  String get paymentSettingsInfo;

  /// PayPal aktivieren
  ///
  /// In de, this message translates to:
  /// **'PayPal aktivieren'**
  String get enablePaypal;

  /// PayPal Bezahlung Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Benutzer können mit PayPal bezahlen'**
  String get paypalPaymentDescription;

  /// PayPal E-Mail-Adresse Label
  ///
  /// In de, this message translates to:
  /// **'PayPal E-Mail-Adresse'**
  String get paypalEmailAddress;

  /// PayPal E-Mail Hinweis
  ///
  /// In de, this message translates to:
  /// **'zahlungen@beispiel.com'**
  String get paypalEmailHint;

  /// Bitcoin aktivieren
  ///
  /// In de, this message translates to:
  /// **'Bitcoin aktivieren'**
  String get enableBitcoin;

  /// Bitcoin Bezahlung Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Benutzer können mit Bitcoin bezahlen'**
  String get bitcoinPaymentDescription;

  /// Bitcoin Wallet-Adresse Label
  ///
  /// In de, this message translates to:
  /// **'Bitcoin Wallet-Adresse'**
  String get bitcoinWalletAddress;

  /// Bitcoin Wallet Hinweis
  ///
  /// In de, this message translates to:
  /// **'bc1q...'**
  String get bitcoinWalletHint;

  /// Ausstehende Zahlungen Screen Titel
  ///
  /// In de, this message translates to:
  /// **'Ausstehende Zahlungen'**
  String get pendingPaymentsScreen;

  /// Alle ausstehenden Zahlungen Tab
  ///
  /// In de, this message translates to:
  /// **'Alle'**
  String get allPendingPayments;

  /// PayPal-Zahlungen Tab
  ///
  /// In de, this message translates to:
  /// **'PayPal'**
  String get paypalPayments;

  /// Bitcoin-Zahlungen Tab
  ///
  /// In de, this message translates to:
  /// **'Bitcoin'**
  String get bitcoinPayments;

  /// Keine ausstehenden Zahlungen Titel
  ///
  /// In de, this message translates to:
  /// **'Keine ausstehenden Zahlungen'**
  String get noPendingPayments;

  /// Keine ausstehenden Zahlungen Nachricht
  ///
  /// In de, this message translates to:
  /// **'Es gibt aktuell keine ausstehenden Zahlungen zu bearbeiten.'**
  String get noPendingPaymentsMessage;

  /// Zahlungs-ID Label
  ///
  /// In de, this message translates to:
  /// **'Zahlungs-ID'**
  String get paymentId;

  /// Betrag Label
  ///
  /// In de, this message translates to:
  /// **'Betrag'**
  String get amount;

  /// Angefordert am Label
  ///
  /// In de, this message translates to:
  /// **'Angefordert am'**
  String get requestedAt;

  /// Zahlungsstatus Label
  ///
  /// In de, this message translates to:
  /// **'Status'**
  String get paymentStatus;

  /// Zahlungsstatus Ausstehend
  ///
  /// In de, this message translates to:
  /// **'Ausstehend'**
  String get paymentStatusPending;

  /// Zahlungsstatus In Bearbeitung
  ///
  /// In de, this message translates to:
  /// **'In Bearbeitung'**
  String get paymentStatusProcessing;

  /// Zahlungsstatus Abgeschlossen
  ///
  /// In de, this message translates to:
  /// **'Abgeschlossen'**
  String get paymentStatusCompleted;

  /// Zahlungsstatus Fehlgeschlagen
  ///
  /// In de, this message translates to:
  /// **'Fehlgeschlagen'**
  String get paymentStatusFailed;

  /// Zahlung bearbeiten Button
  ///
  /// In de, this message translates to:
  /// **'Zahlung bearbeiten'**
  String get processPayment;

  /// Bitcoin-Zahlungen prüfen Tooltip
  ///
  /// In de, this message translates to:
  /// **'Bitcoin-Zahlungen prüfen'**
  String get checkBitcoinPayments;

  /// Alte Bestellungen ablaufen lassen Tooltip
  ///
  /// In de, this message translates to:
  /// **'Alte Bestellungen ablaufen lassen'**
  String get expireOldOrders;

  /// Zahlung bestätigen Dialog Titel
  ///
  /// In de, this message translates to:
  /// **'Zahlung bestätigen'**
  String get confirmPaymentTitle;

  /// Zahlung bestätigen Dialog Nachricht
  ///
  /// In de, this message translates to:
  /// **'Möchten Sie die Zahlung für Bestellung #{orderId} wirklich bestätigen?\n\nBetrag: {amount}\nMethode: {method}'**
  String confirmPaymentMessage(int orderId, String amount, String method);

  /// Zahlung bestätigt Nachricht
  ///
  /// In de, this message translates to:
  /// **'Zahlung bestätigt und Slot aktiviert'**
  String get paymentConfirmedSlotActivated;

  /// Bitcoin-Zahlungen verarbeitet Nachricht
  ///
  /// In de, this message translates to:
  /// **'{count} Bitcoin-Zahlungen verarbeitet'**
  String bitcoinPaymentsProcessed(int count);

  /// Alte Bestellungen ablaufen Dialog Titel
  ///
  /// In de, this message translates to:
  /// **'Alte Bestellungen ablaufen lassen'**
  String get expireOldOrdersTitle;

  /// Alte Bestellungen ablaufen Dialog Nachricht
  ///
  /// In de, this message translates to:
  /// **'Möchten Sie alle ausstehenden Bestellungen, die älter als 24 Stunden sind, als abgelaufen markieren?'**
  String get expireOldOrdersMessage;

  /// Ablaufen lassen Button
  ///
  /// In de, this message translates to:
  /// **'Ablaufen lassen'**
  String get expireAction;

  /// Bestellungen abgelaufen Nachricht
  ///
  /// In de, this message translates to:
  /// **'{count} Bestellungen als abgelaufen markiert'**
  String ordersExpired(int count);

  /// Alle Zahlungen verarbeitet Nachricht
  ///
  /// In de, this message translates to:
  /// **'Alle Zahlungen wurden verarbeitet'**
  String get allPaymentsProcessed;

  /// Bestellungsnummer
  ///
  /// In de, this message translates to:
  /// **'Bestellung #{number}'**
  String orderNumber(int number);

  /// Benutzer Label
  ///
  /// In de, this message translates to:
  /// **'Benutzer'**
  String get user;

  /// Unbekannt Text
  ///
  /// In de, this message translates to:
  /// **'Unbekannt'**
  String get unknown;

  /// Variante Label
  ///
  /// In de, this message translates to:
  /// **'Variante'**
  String get variant;

  /// Methode Label
  ///
  /// In de, this message translates to:
  /// **'Methode'**
  String get method;

  /// Transaktions-ID Label
  ///
  /// In de, this message translates to:
  /// **'TX-ID'**
  String get txId;

  /// Zahlungsdetails Dialog Titel
  ///
  /// In de, this message translates to:
  /// **'Zahlungsdetails #{number}'**
  String paymentDetailsTitle(int number);

  /// PayPal E-Mail Label
  ///
  /// In de, this message translates to:
  /// **'PayPal E-Mail'**
  String get paypalEmail;

  /// Währung Label
  ///
  /// In de, this message translates to:
  /// **'Währung'**
  String get currency;

  /// Bitcoin-Adresse Label
  ///
  /// In de, this message translates to:
  /// **'Bitcoin-Adresse'**
  String get bitcoinAddress;

  /// Betrag in USD Label
  ///
  /// In de, this message translates to:
  /// **'Betrag (USD)'**
  String get amountUsd;

  /// Betrag in BTC Label
  ///
  /// In de, this message translates to:
  /// **'Betrag (BTC)'**
  String get amountBtc;

  /// Memo Label
  ///
  /// In de, this message translates to:
  /// **'Memo'**
  String get memo;

  /// Als in Bearbeitung markieren Button
  ///
  /// In de, this message translates to:
  /// **'Als in Bearbeitung markieren'**
  String get markAsProcessing;

  /// Als abgeschlossen markieren Button
  ///
  /// In de, this message translates to:
  /// **'Als abgeschlossen markieren'**
  String get markAsCompleted;

  /// Als fehlgeschlagen markieren Button
  ///
  /// In de, this message translates to:
  /// **'Als fehlgeschlagen markieren'**
  String get markAsFailed;

  /// Als in Bearbeitung markiert Nachricht
  ///
  /// In de, this message translates to:
  /// **'Zahlung als in Bearbeitung markiert'**
  String get paymentMarkedProcessing;

  /// Als abgeschlossen markiert Nachricht
  ///
  /// In de, this message translates to:
  /// **'Zahlung als abgeschlossen markiert'**
  String get paymentMarkedCompleted;

  /// Als fehlgeschlagen markiert Nachricht
  ///
  /// In de, this message translates to:
  /// **'Zahlung als fehlgeschlagen markiert'**
  String get paymentMarkedFailed;

  /// Slot-Varianten Screen Titel
  ///
  /// In de, this message translates to:
  /// **'Slot-Varianten'**
  String get slotVariantsScreen;

  /// Aktive Slot-Varianten Tab
  ///
  /// In de, this message translates to:
  /// **'Aktiv'**
  String get activeSlotVariants;

  /// Inaktive Slot-Varianten Tab
  ///
  /// In de, this message translates to:
  /// **'Inaktiv'**
  String get inactiveSlotVariants;

  /// Slot-Variante erstellen Button
  ///
  /// In de, this message translates to:
  /// **'Slot-Variante erstellen'**
  String get createSlotVariant;

  /// Keine Slot-Varianten Titel
  ///
  /// In de, this message translates to:
  /// **'Keine Slot-Varianten'**
  String get noSlotVariants;

  /// Keine Slot-Varianten Nachricht
  ///
  /// In de, this message translates to:
  /// **'Es wurden noch keine Slot-Varianten erstellt.'**
  String get noSlotVariantsMessage;

  /// Variantenname Label
  ///
  /// In de, this message translates to:
  /// **'Name'**
  String get variantName;

  /// Laufzeit Label
  ///
  /// In de, this message translates to:
  /// **'Laufzeit'**
  String get duration;

  /// Laufzeit in Tagen
  ///
  /// In de, this message translates to:
  /// **'{days} Tage'**
  String durationDays(int days);

  /// Preis USD Label
  ///
  /// In de, this message translates to:
  /// **'Preis (USD)'**
  String get priceUSD;

  /// Preis BTC Label
  ///
  /// In de, this message translates to:
  /// **'Preis (BTC)'**
  String get priceBTC;

  /// Maximale Angebote Label
  ///
  /// In de, this message translates to:
  /// **'Max. Angebote'**
  String get maxListings;

  /// Varianten-Status Label
  ///
  /// In de, this message translates to:
  /// **'Status'**
  String get variantStatus;

  /// Slot-Variante bearbeiten Button
  ///
  /// In de, this message translates to:
  /// **'Slot-Variante bearbeiten'**
  String get editSlotVariant;

  /// Slot-Variante löschen Button
  ///
  /// In de, this message translates to:
  /// **'Slot-Variante löschen'**
  String get deleteSlotVariant;

  /// Slot-Variante erstellen Dialog Titel
  ///
  /// In de, this message translates to:
  /// **'Slot-Variante erstellen'**
  String get createSlotVariantDialog;

  /// Slot-Variante bearbeiten Dialog Titel
  ///
  /// In de, this message translates to:
  /// **'Slot-Variante bearbeiten'**
  String get editSlotVariantDialog;

  /// Variantenname Hint
  ///
  /// In de, this message translates to:
  /// **'Variantenname eingeben'**
  String get enterVariantName;

  /// Laufzeit Hint
  ///
  /// In de, this message translates to:
  /// **'Laufzeit (Tage)'**
  String get enterDuration;

  /// Preis USD Hint
  ///
  /// In de, this message translates to:
  /// **'Preis in USD'**
  String get enterPriceUSD;

  /// Preis BTC Hint
  ///
  /// In de, this message translates to:
  /// **'Preis in BTC'**
  String get enterPriceBTC;

  /// Max. Angebote Hint
  ///
  /// In de, this message translates to:
  /// **'Max. Angebote'**
  String get enterMaxListings;

  /// Variantenname erforderlich Validierung
  ///
  /// In de, this message translates to:
  /// **'Name ist erforderlich'**
  String get variantNameRequired;

  /// Laufzeit erforderlich Validierung
  ///
  /// In de, this message translates to:
  /// **'Laufzeit ist erforderlich'**
  String get durationRequired;

  /// USD-Preis erforderlich Validierung
  ///
  /// In de, this message translates to:
  /// **'USD-Preis ist erforderlich'**
  String get priceUSDRequired;

  /// BTC-Preis erforderlich Validierung
  ///
  /// In de, this message translates to:
  /// **'BTC-Preis ist erforderlich'**
  String get priceBTCRequired;

  /// Max. Angebote erforderlich Validierung
  ///
  /// In de, this message translates to:
  /// **'Max. Angebote ist erforderlich'**
  String get maxListingsRequired;

  /// Slot-Variante erstellt Nachricht
  ///
  /// In de, this message translates to:
  /// **'Slot-Variante erstellt'**
  String get slotVariantCreated;

  /// Slot-Variante aktualisiert Nachricht
  ///
  /// In de, this message translates to:
  /// **'Slot-Variante aktualisiert'**
  String get slotVariantUpdated;

  /// Slot-Variante gelöscht Nachricht
  ///
  /// In de, this message translates to:
  /// **'Slot-Variante gelöscht'**
  String get slotVariantDeleted;

  /// Slot-Variante löschen Bestätigung
  ///
  /// In de, this message translates to:
  /// **'Möchtest du diese Slot-Variante wirklich löschen?'**
  String get confirmDeleteSlotVariant;

  /// Slot-Variante löschen Bestätigung mit Name
  ///
  /// In de, this message translates to:
  /// **'Möchtest du \"{name}\" wirklich löschen?'**
  String confirmDeleteSlotVariantWithName(String name);

  /// Slot-Varianten verwalten Titel
  ///
  /// In de, this message translates to:
  /// **'Slot-Varianten verwalten'**
  String get manageSlotVariants;

  /// Erstelle erste Slot-Variante Nachricht
  ///
  /// In de, this message translates to:
  /// **'Erstelle die erste Slot-Variante mit dem + Button.'**
  String get createFirstSlotVariant;

  /// Neue Slot-Variante Dialog Titel
  ///
  /// In de, this message translates to:
  /// **'Neue Slot-Variante'**
  String get newSlotVariant;

  /// Kostenlos Badge
  ///
  /// In de, this message translates to:
  /// **'KOSTENLOS'**
  String get freeLabel;

  /// Kostenlos Label
  ///
  /// In de, this message translates to:
  /// **'Kostenlos'**
  String get free;

  /// Name Hinweis
  ///
  /// In de, this message translates to:
  /// **'z.B. Standard, Premium'**
  String get nameHint;

  /// Beschreibung optional Label
  ///
  /// In de, this message translates to:
  /// **'Beschreibung (optional)'**
  String get descriptionOptional;

  /// Preis in USD Label
  ///
  /// In de, this message translates to:
  /// **'Preis (USD)'**
  String get priceUsd;

  /// Laufzeit in Tagen Label
  ///
  /// In de, this message translates to:
  /// **'Laufzeit (Tage)'**
  String get durationDaysLabel;

  /// Kostenlose Variante Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Variante ist gratis (für Promotion-Slots)'**
  String get freeVariantDescription;

  /// Aktive Variante Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Variante kann gekauft werden'**
  String get activeVariantDescription;

  /// Mindestens eine Zahlungsmethode Validierung
  ///
  /// In de, this message translates to:
  /// **'Mindestens eine Zahlungsmethode muss aktiviert sein'**
  String get atLeastOnePaymentMethodRequired;

  /// Benutzerverwaltung Screen Titel
  ///
  /// In de, this message translates to:
  /// **'Benutzerverwaltung'**
  String get userManagementScreen;

  /// Alle Benutzer Tab
  ///
  /// In de, this message translates to:
  /// **'Alle Benutzer'**
  String get allUsers;

  /// Aktive Benutzer Tab
  ///
  /// In de, this message translates to:
  /// **'Aktiv'**
  String get activeUsers;

  /// Gesperrte Benutzer Tab
  ///
  /// In de, this message translates to:
  /// **'Gesperrt'**
  String get bannedUsers;

  /// Benutzer suchen Hint
  ///
  /// In de, this message translates to:
  /// **'Benutzer suchen...'**
  String get searchUsers;

  /// Keine Benutzer Titel
  ///
  /// In de, this message translates to:
  /// **'Keine Benutzer'**
  String get noUsers;

  /// Keine Benutzer Nachricht
  ///
  /// In de, this message translates to:
  /// **'Keine Benutzer gefunden.'**
  String get noUsersMessage;

  /// Rolle Label
  ///
  /// In de, this message translates to:
  /// **'Rolle'**
  String get role;

  /// Benutzer ansehen Button
  ///
  /// In de, this message translates to:
  /// **'Benutzer ansehen'**
  String get viewUser;

  /// Sperre aufheben
  ///
  /// In de, this message translates to:
  /// **'Sperre aufheben'**
  String get unbanUser;

  /// Sperre aufgehoben Bestätigung
  ///
  /// In de, this message translates to:
  /// **'Sperre wurde aufgehoben'**
  String get userUnbanned;

  /// Benutzer entsperren Bestätigung
  ///
  /// In de, this message translates to:
  /// **'Möchtest du diesen Benutzer wirklich entsperren?'**
  String get confirmUnbanUser;

  /// Entsperren Button
  ///
  /// In de, this message translates to:
  /// **'Entsperren'**
  String get unban;

  /// Administration Titel
  ///
  /// In de, this message translates to:
  /// **'Administration'**
  String get administration;

  /// System- und Benutzerverwaltung Untertitel
  ///
  /// In de, this message translates to:
  /// **'System- und Benutzerverwaltung'**
  String get systemUserManagement;

  /// Kategorien verwalten Titel
  ///
  /// In de, this message translates to:
  /// **'Kategorien verwalten'**
  String get manageCategories;

  /// Kategorien und Subkategorien erstellen Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Kategorien und Subkategorien erstellen'**
  String get createCategoriesSubcategories;

  /// Slot-Typen konfigurieren Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Slot-Typen und Preise konfigurieren'**
  String get configureSlotTypes;

  /// PayPal und Bitcoin Beschreibung
  ///
  /// In de, this message translates to:
  /// **'PayPal und Bitcoin für Slot-Käufe'**
  String get paypalBitcoinSlots;

  /// Offene Bestellungen prüfen Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Offene Bestellungen prüfen und bestätigen'**
  String get reviewPendingOrders;

  /// Benutzer verwalten Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Benutzer verwalten und Rollen zuweisen'**
  String get manageUsersRoles;

  /// Feature kommt in Meilenstein Nachricht
  ///
  /// In de, this message translates to:
  /// **'{title} wird in Meilenstein {milestone} implementiert.'**
  String featureInMilestone(String title, String milestone);

  /// Slots Abschnittstitel
  ///
  /// In de, this message translates to:
  /// **'Slots'**
  String get slots;

  /// Zahlungen Abschnittstitel
  ///
  /// In de, this message translates to:
  /// **'Zahlungen'**
  String get payments;

  /// Benutzer Abschnittstitel
  ///
  /// In de, this message translates to:
  /// **'Benutzer'**
  String get users;

  /// Moderator Panel Screen Titel
  ///
  /// In de, this message translates to:
  /// **'Moderator Panel'**
  String get moderatorPanelScreen;

  /// Anzahl offener Meldungen
  ///
  /// In de, this message translates to:
  /// **'{count} offen'**
  String openReportsCount(int count);

  /// Angebots-Meldungen Tab
  ///
  /// In de, this message translates to:
  /// **'Angebote'**
  String get listingReports;

  /// Benutzer-Meldungen Tab
  ///
  /// In de, this message translates to:
  /// **'Benutzer'**
  String get userReports;

  /// Keine Meldungen Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Es gibt derzeit keine Meldungen'**
  String get noReportsDescription;

  /// Angebot Label
  ///
  /// In de, this message translates to:
  /// **'Angebot'**
  String get listing;

  /// Meldung Status: Offen
  ///
  /// In de, this message translates to:
  /// **'OFFEN'**
  String get reportStatusOpen;

  /// Meldung Status: In Prüfung
  ///
  /// In de, this message translates to:
  /// **'IN PRÜFUNG'**
  String get reportStatusReviewing;

  /// Meldung Status: Gelöst
  ///
  /// In de, this message translates to:
  /// **'GELÖST'**
  String get reportStatusResolved;

  /// Meldung Status: Abgewiesen
  ///
  /// In de, this message translates to:
  /// **'ABGEWIESEN'**
  String get reportStatusDismissed;

  /// Meldegrund: Betrug
  ///
  /// In de, this message translates to:
  /// **'Betrügerisches Angebot'**
  String get reportReasonFraud;

  /// Zugewiesen Label
  ///
  /// In de, this message translates to:
  /// **'Zugewiesen'**
  String get assigned;

  /// Gerade eben Zeitformat
  ///
  /// In de, this message translates to:
  /// **'Gerade eben'**
  String get justNow;

  /// Vor X Minuten
  ///
  /// In de, this message translates to:
  /// **'vor {minutes}m'**
  String minutesAgo(int minutes);

  /// Vor X Stunden
  ///
  /// In de, this message translates to:
  /// **'vor {hours}h'**
  String hoursAgo(int hours);

  /// Vor X Tagen
  ///
  /// In de, this message translates to:
  /// **'vor {days}d'**
  String daysAgo(int days);

  /// Staff Tab
  ///
  /// In de, this message translates to:
  /// **'Staff'**
  String get staff;

  /// Gesperrt Badge
  ///
  /// In de, this message translates to:
  /// **'GESPERRT'**
  String get banned;

  /// Keine Benutzer gefunden
  ///
  /// In de, this message translates to:
  /// **'Keine Benutzer gefunden'**
  String get noUsersFound;

  /// Meldung zugewiesen Bestätigung
  ///
  /// In de, this message translates to:
  /// **'Meldung wurde Ihnen zugewiesen'**
  String get reportAssignedToYou;

  /// Status aktualisiert Bestätigung
  ///
  /// In de, this message translates to:
  /// **'Status wurde aktualisiert'**
  String get statusUpdated;

  /// Notiz leer Fehler
  ///
  /// In de, this message translates to:
  /// **'Notiz darf nicht leer sein'**
  String get noteCannotBeEmpty;

  /// Angebot deaktivieren Titel
  ///
  /// In de, this message translates to:
  /// **'Angebot deaktivieren'**
  String get deactivateListing;

  /// Angebot deaktivieren Bestätigung
  ///
  /// In de, this message translates to:
  /// **'Möchten Sie dieses Angebot wirklich deaktivieren? Diese Aktion kann nicht rückgängig gemacht werden.'**
  String get deactivateListingConfirm;

  /// Deaktivieren Button
  ///
  /// In de, this message translates to:
  /// **'Deaktivieren'**
  String get deactivate;

  /// Angebot deaktiviert Bestätigung
  ///
  /// In de, this message translates to:
  /// **'Angebot wurde deaktiviert'**
  String get listingDeactivated;

  /// Meldung nicht gefunden
  ///
  /// In de, this message translates to:
  /// **'Meldung nicht gefunden'**
  String get reportNotFound;

  /// Zugewiesen an Moderator
  ///
  /// In de, this message translates to:
  /// **'Zugewiesen an Moderator #{id}'**
  String assignedToModerator(int id);

  /// Noch nicht zugewiesen
  ///
  /// In de, this message translates to:
  /// **'Noch nicht zugewiesen'**
  String get notYetAssigned;

  /// Meldungsdetails Titel
  ///
  /// In de, this message translates to:
  /// **'Meldungsdetails'**
  String get reportDetails;

  /// Gemeldet am Label
  ///
  /// In de, this message translates to:
  /// **'Gemeldet am'**
  String get reportedOn;

  /// Meldender Benutzer
  ///
  /// In de, this message translates to:
  /// **'Benutzer #{id}'**
  String reporterUser(int id);

  /// Gemeldetes Benutzerprofil
  ///
  /// In de, this message translates to:
  /// **'Gemeldetes Benutzerprofil'**
  String get reportedUserProfile;

  /// Notizen Hinweis
  ///
  /// In de, this message translates to:
  /// **'Fügen Sie interne Notizen hinzu...'**
  String get addInternalNotes;

  /// Mir zuweisen Button
  ///
  /// In de, this message translates to:
  /// **'Mir zuweisen'**
  String get assignToMe;

  /// Als gelöst markieren Button
  ///
  /// In de, this message translates to:
  /// **'Als gelöst markieren'**
  String get markAsResolved;

  /// Vollständiges Datum/Zeit Format
  ///
  /// In de, this message translates to:
  /// **'{day}.{month}.{year} um {hour}:{minute} Uhr'**
  String fullDateTimeFormat(
      String day, String month, int year, String hour, String minute);

  /// Angebot ID
  ///
  /// In de, this message translates to:
  /// **'Angebot #{id}'**
  String listingId(int id);

  /// Warnung Titel
  ///
  /// In de, this message translates to:
  /// **'Warnung'**
  String get warning;

  /// Bestätigung für Rollen-Änderung
  ///
  /// In de, this message translates to:
  /// **'Möchten Sie diesem Benutzer wirklich die Rolle \"{role}\" zuweisen? Diese Aktion gibt dem Benutzer erweiterte Berechtigungen.'**
  String confirmRoleChange(String role);

  /// Rolle aktualisiert Bestätigung
  ///
  /// In de, this message translates to:
  /// **'Rolle wurde aktualisiert'**
  String get roleUpdated;

  /// Fehler Nachricht
  ///
  /// In de, this message translates to:
  /// **'Fehler: {error}'**
  String error(String error);

  /// Keine kostenlosen Slot-Varianten verfügbar
  ///
  /// In de, this message translates to:
  /// **'Keine kostenlosen Slot-Varianten verfügbar. Erstelle zuerst eine kostenlose Variante.'**
  String get noFreeSlotVariantsAvailable;

  /// Kostenlosen Slot vergeben
  ///
  /// In de, this message translates to:
  /// **'Kostenlosen Slot vergeben'**
  String get grantFreeSlot;

  /// Slot-Variante auswählen
  ///
  /// In de, this message translates to:
  /// **'Wähle eine kostenlose Slot-Variante für {username}:'**
  String selectFreeSlotVariant(String username);

  /// Tage Laufzeit
  ///
  /// In de, this message translates to:
  /// **'{days} Tage Laufzeit'**
  String daysRuntime(int days);

  /// Kostenlos Label (Großbuchstaben)
  ///
  /// In de, this message translates to:
  /// **'KOSTENLOS'**
  String get freeUppercase;

  /// Kostenloser Slot vergeben Bestätigung
  ///
  /// In de, this message translates to:
  /// **'Kostenloser Slot \"{variantName}\" wurde an {username} vergeben'**
  String freeSlotGranted(String variantName, String username);

  /// Sperre aufheben Bestätigung
  ///
  /// In de, this message translates to:
  /// **'Möchten Sie die Sperre dieses Benutzers wirklich aufheben?'**
  String get confirmUnban;

  /// Standard-Grund für Aufhebung der Sperre
  ///
  /// In de, this message translates to:
  /// **'Sperre durch Admin aufgehoben'**
  String get unbanReason;

  /// Informationen Titel
  ///
  /// In de, this message translates to:
  /// **'Informationen'**
  String get information;

  /// Letzter Login Label
  ///
  /// In de, this message translates to:
  /// **'Letzter Login'**
  String get lastLogin;

  /// Noch nie
  ///
  /// In de, this message translates to:
  /// **'Noch nie'**
  String get never;

  /// Status Label
  ///
  /// In de, this message translates to:
  /// **'Status'**
  String get status;

  /// Gesperrt seit Label
  ///
  /// In de, this message translates to:
  /// **'Gesperrt seit'**
  String get bannedSince;

  /// Sperrgrund Label
  ///
  /// In de, this message translates to:
  /// **'Sperrgrund'**
  String get banReasonLabel;

  /// Eigene Rolle nicht änderbar
  ///
  /// In de, this message translates to:
  /// **'Sie können Ihre eigene Rolle nicht ändern.'**
  String get cannotChangeOwnRole;

  /// Administrator Rollen-Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Voller Zugriff auf alle Funktionen'**
  String get roleDescriptionAdmin;

  /// Moderator Rollen-Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Kann Meldungen bearbeiten und Inhalte moderieren'**
  String get roleDescriptionModerator;

  /// Benutzer Rollen-Beschreibung
  ///
  /// In de, this message translates to:
  /// **'Normaler Benutzer ohne erweiterte Berechtigungen'**
  String get roleDescriptionUser;

  /// Sperr-Historie
  ///
  /// In de, this message translates to:
  /// **'Sperr-Historie'**
  String get banHistory;

  /// Gesperrt Aktion
  ///
  /// In de, this message translates to:
  /// **'Gesperrt'**
  String get bannedAction;

  /// Entsperrt Aktion
  ///
  /// In de, this message translates to:
  /// **'Entsperrt'**
  String get unbannedAction;

  /// Ban-Grund: Betrug/Scam
  ///
  /// In de, this message translates to:
  /// **'Betrug/Scam'**
  String get banReasonFraud;

  /// Ban-Grund: Unangemessenes Verhalten
  ///
  /// In de, this message translates to:
  /// **'Unangemessenes Verhalten'**
  String get banReasonInappropriate;

  /// Ban-Grund: Verstoß gegen Nutzungsbedingungen
  ///
  /// In de, this message translates to:
  /// **'Verstoß gegen Nutzungsbedingungen'**
  String get banReasonTosViolation;

  /// Ban-Grund: Mehrfach-Accounts
  ///
  /// In de, this message translates to:
  /// **'Mehrfach-Accounts'**
  String get banReasonMultipleAccounts;

  /// Ban-Grund: Illegale Aktivitäten
  ///
  /// In de, this message translates to:
  /// **'Illegale Aktivitäten'**
  String get banReasonIllegal;

  /// Ban-Grund erforderlich Fehlermeldung
  ///
  /// In de, this message translates to:
  /// **'Bitte geben Sie einen Grund ein'**
  String get banReasonRequired;

  /// Grund für Sperre eingeben
  ///
  /// In de, this message translates to:
  /// **'Bitte geben Sie einen Grund für die Sperre an:'**
  String get enterBanReason;

  /// Vordefinierte Gründe Label
  ///
  /// In de, this message translates to:
  /// **'Vordefinierte Gründe:'**
  String get presetReasons;

  /// Grund erforderlich Label
  ///
  /// In de, this message translates to:
  /// **'Grund (erforderlich)'**
  String get reasonRequired;

  /// Beschreibung für Ban-Grund Platzhalter
  ///
  /// In de, this message translates to:
  /// **'Beschreiben Sie den Grund für die Sperre...'**
  String get describeBanReason;

  /// Warnung beim Sperren eines Benutzers
  ///
  /// In de, this message translates to:
  /// **'Achtung: Beim Sperren werden alle aktiven Angebote des Benutzers deaktiviert und offene Transaktionen abgebrochen.'**
  String get banWarning;

  /// Sperren Aktion
  ///
  /// In de, this message translates to:
  /// **'Sperren'**
  String get banAction;
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
