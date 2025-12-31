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

  /// Bitte gib dein Passwort ein Fehler
  ///
  /// In de, this message translates to:
  /// **'Bitte gib dein Passwort ein'**
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
  /// **'Details'**
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

  /// Angebot löschen Label
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
  String get errorLoading;

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

  /// Entschlüsselung fehlgeschlagen Fehler
  ///
  /// In de, this message translates to:
  /// **'Entschlüsselung fehlgeschlagen'**
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
