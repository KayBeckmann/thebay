// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Bay';

  @override
  String get loginTitle => 'Bienvenue';

  @override
  String get loginSubtitle => 'Connectez-vous pour continuer';

  @override
  String get username => 'Nom d\'utilisateur';

  @override
  String get usernameRequired => 'Veuillez entrer votre nom d\'utilisateur';

  @override
  String get password => 'Mot de passe';

  @override
  String get passwordRequired => 'Veuillez entrer votre mot de passe';

  @override
  String get stayLoggedIn => 'Rester connecté';

  @override
  String get signIn => 'Se connecter';

  @override
  String get dontHaveAccount => 'Vous n\'avez pas de compte ? ';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get loginFailed => 'Connexion échouée';

  @override
  String get connectionError => 'Erreur de connexion. Veuillez réessayer.';

  @override
  String tryAgainInSeconds(int seconds) {
    return 'Réessayez dans $seconds secondes';
  }

  @override
  String get registerTitle => 'Créer un compte';

  @override
  String get registerSubtitle => 'Inscrivez-vous pour commencer';

  @override
  String get usernameHelper => '3-20 caractères, lettres, chiffres, tirets bas';

  @override
  String get usernameMinLength =>
      'Le nom d\'utilisateur doit contenir au moins 3 caractères';

  @override
  String get usernameMaxLength =>
      'Le nom d\'utilisateur ne peut pas dépasser 20 caractères';

  @override
  String get usernameInvalidChars =>
      'Seuls les lettres, chiffres et tirets bas sont autorisés';

  @override
  String get passwordHelper => 'Min 8 car., majuscule, minuscule, chiffre';

  @override
  String get passwordMinLength =>
      'Le mot de passe doit contenir au moins 8 caractères';

  @override
  String get passwordNeedsUppercase =>
      'Le mot de passe doit contenir une majuscule';

  @override
  String get passwordNeedsLowercase =>
      'Le mot de passe doit contenir une minuscule';

  @override
  String get passwordNeedsDigit => 'Le mot de passe doit contenir un chiffre';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get agreeToTerms => 'J\'accepte les ';

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get close => 'Fermer';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte ? ';

  @override
  String get mustAcceptTerms =>
      'Vous devez accepter les conditions d\'utilisation';

  @override
  String get registrationFailed => 'Inscription échouée';

  @override
  String get generatingKey => 'Génération de la clé de sécurité...';

  @override
  String get generatingKeyMessage =>
      'Votre clé de chiffrement personnelle est en cours de génération.\nCela ne prendra que quelques secondes.';

  @override
  String keyGenerationFailed(String error) {
    return 'La clé n\'a pas pu être générée : $error\nVous pouvez la créer plus tard dans les paramètres.';
  }

  @override
  String elapsedTime(String time) {
    return 'Temps écoulé : $time';
  }

  @override
  String get navDashboard => 'Tableau de bord';

  @override
  String get navMessages => 'Messages';

  @override
  String get navSearch => 'Rechercher';

  @override
  String get navSell => 'Vendre';

  @override
  String get navTransactions => 'Transactions';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get navModeration => 'Modération';

  @override
  String get navNews => 'Actualités';

  @override
  String get navAdmin => 'Administration';

  @override
  String get drawerUserFallback => 'Utilisateur';

  @override
  String get drawerModerationSection => 'Modération';

  @override
  String get drawerAdminSection => 'Administration';

  @override
  String get roleAdmin => 'Administrateur';

  @override
  String get roleModerator => 'Modérateur';

  @override
  String get roleUser => 'Utilisateur';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get sectionPaymentInfo => 'Informations de paiement';

  @override
  String get sectionDisplay => 'Affichage';

  @override
  String get sectionSecurity => 'Sécurité';

  @override
  String get sectionAccount => 'Compte';

  @override
  String get paypalAddress => 'Adresse PayPal';

  @override
  String get bitcoinWallet => 'Portefeuille Bitcoin';

  @override
  String get notSpecified => 'Non spécifié';

  @override
  String get emailAddress => 'Adresse e-mail';

  @override
  String get emailHint => 'votre@email.com';

  @override
  String get walletAddress => 'Adresse du portefeuille';

  @override
  String get walletHint => 'bc1q...';

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Enregistrer';

  @override
  String get paypalAddressSaved => 'Adresse PayPal enregistrée';

  @override
  String get bitcoinWalletSaved => 'Portefeuille Bitcoin enregistré';

  @override
  String errorSaving(String error) {
    return 'Erreur d\'enregistrement : $error';
  }

  @override
  String get itemsPerPage => 'Éléments par page';

  @override
  String itemsCount(int count) {
    return '$count éléments';
  }

  @override
  String get displayCurrency => 'Devise d\'affichage';

  @override
  String get language => 'Langue';

  @override
  String get languageChanged =>
      'Langue modifiée. Veuillez redémarrer l\'application pour appliquer le changement.';

  @override
  String get langEnglish => 'English';

  @override
  String get langGerman => 'Deutsch';

  @override
  String get langFrench => 'Français';

  @override
  String get langSpanish => 'Español';

  @override
  String get pgpKey => 'Clé PGP';

  @override
  String get configured => 'Configuré';

  @override
  String get notConfigured => 'Pas encore configuré';

  @override
  String get changePassword => 'Changer le mot de passe';

  @override
  String get currentPassword => 'Mot de passe actuel';

  @override
  String get newPassword => 'Nouveau mot de passe';

  @override
  String get passwordsMismatch => 'Les mots de passe ne correspondent pas';

  @override
  String get passwordChangeSuccess => 'Mot de passe modifié avec succès';

  @override
  String get passwordChangeError => 'Erreur lors du changement de mot de passe';

  @override
  String get changeButton => 'Modifier';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get logoutConfirm => 'Voulez-vous vraiment vous déconnecter ?';

  @override
  String get deleteAccount => 'Supprimer le compte';

  @override
  String get deleteAccountWarning =>
      'Cette action ne peut pas être annulée. Toutes vos données seront définitivement supprimées.';

  @override
  String get passwordConfirmation => 'Mot de passe de confirmation';

  @override
  String get pleaseEnterPassword => 'Veuillez entrer votre mot de passe';

  @override
  String get deleteAccountError => 'Erreur lors de la suppression du compte';

  @override
  String genericError(String error) {
    return 'Erreur : $error';
  }
}
