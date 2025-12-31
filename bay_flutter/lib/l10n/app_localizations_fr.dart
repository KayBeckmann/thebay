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

  @override
  String get dashboardTitle => 'Tableau de bord';

  @override
  String welcomeUser(String username) {
    return 'Bienvenue, $username !';
  }

  @override
  String get userFallback => 'Utilisateur';

  @override
  String get whatTodayQuestion => 'Que voulez-vous faire aujourd\'hui ?';

  @override
  String get sectionPendingRatings => 'Évaluations en attente';

  @override
  String get sectionNews => 'Actualités';

  @override
  String get sectionSlotWarnings => 'Alertes de slots';

  @override
  String get sectionRecentListings => 'Annonces récentes';

  @override
  String get noNews => 'Pas d\'actualités';

  @override
  String get noNewsMessage =>
      'Il n\'y a actuellement aucune actualité. Revenez plus tard !';

  @override
  String pendingRatingsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vous avez $count évaluations en attente',
      one: 'Vous avez 1 évaluation en attente',
    );
    return '$_temp0';
  }

  @override
  String transactionNumber(int id) {
    return 'Transaction #$id';
  }

  @override
  String viewAllPendingRatings(int count) {
    return 'Voir les $count évaluations en attente';
  }

  @override
  String get noSlotsExpiring =>
      'Aucun slot n\'expire dans les 3 prochains jours.';

  @override
  String slotsExpiringSoon(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count slots expirent bientôt',
      one: '1 slot expire bientôt',
    );
    return '$_temp0';
  }

  @override
  String slotNumber(int id) {
    return 'Slot #$id';
  }

  @override
  String listingNumber(int id) {
    return 'Annonce #$id';
  }

  @override
  String get noListingLinked => 'Aucune annonce liée';

  @override
  String moreCount(int count) {
    return '+$count de plus';
  }

  @override
  String get noListingsYet => 'Pas encore d\'annonces';

  @override
  String get noListingsMessage => 'Les annonces récentes seront affichées ici.';

  @override
  String get unitPiece => 'pièce';

  @override
  String get unitKg => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitMeter => 'm';

  @override
  String get unitLiter => 'L';

  @override
  String get edit => 'Modifier';

  @override
  String get delete => 'Supprimer';

  @override
  String get create => 'Créer';

  @override
  String get active => 'Actif';

  @override
  String get inactive => 'Inactif';

  @override
  String get required => 'Requis';

  @override
  String get invalidInput => 'Entrée invalide';

  @override
  String get shipping => 'Expédition';

  @override
  String get shippingMethod => 'Mode de livraison';

  @override
  String get shippingCost => 'Frais de port';

  @override
  String get searchTitle => 'Rechercher';

  @override
  String get favorites => 'Favoris';

  @override
  String get searchListingsHint => 'Rechercher des annonces...';

  @override
  String get category => 'Catégorie';

  @override
  String get subcategory => 'Sous-catégorie';

  @override
  String get paymentMethod => 'Mode de paiement';

  @override
  String get clearFilters => 'Effacer les filtres';

  @override
  String get noResults => 'Aucun résultat';

  @override
  String get browseListings => 'Parcourir les annonces';

  @override
  String get paypal => 'PayPal';

  @override
  String get bitcoin => 'Bitcoin';

  @override
  String get listingDetailTitle => 'Détails de l\'annonce';

  @override
  String get description => 'Description';

  @override
  String get details => 'Détails';

  @override
  String get acceptedPaymentMethods => 'Modes de paiement acceptés';

  @override
  String get quantity => 'Quantité';

  @override
  String get pricePerUnit => 'Prix par unité';

  @override
  String get createdAt => 'Créé le';

  @override
  String get expiresAt => 'Expire le';

  @override
  String get listingNotFound => 'Annonce non trouvée';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get buyNow => 'Acheter maintenant';

  @override
  String get contactSeller => 'Contacter le vendeur';

  @override
  String get createListingTitle => 'Nouvelle annonce';

  @override
  String get editListingTitle => 'Modifier l\'annonce';

  @override
  String get title => 'Titre';

  @override
  String get titleHint => 'Entrez un titre';

  @override
  String get titleRequired => 'Le titre est requis';

  @override
  String get descriptionHint => 'Décrivez votre annonce...';

  @override
  String get descriptionRequired => 'La description est requise';

  @override
  String get price => 'Prix';

  @override
  String get priceHint => '0.00';

  @override
  String get priceRequired => 'Le prix est requis';

  @override
  String get priceInvalid => 'Le prix doit être supérieur à 0';

  @override
  String get quantityHint => '1';

  @override
  String get quantityRequired => 'La quantité est requise';

  @override
  String get quantityInvalid => 'La quantité doit être supérieure à 0';

  @override
  String get unit => 'Unité';

  @override
  String get selectCategory => 'Sélectionner une catégorie';

  @override
  String get selectSubcategory => 'Sélectionner une sous-catégorie';

  @override
  String get categoryRequired => 'La catégorie est requise';

  @override
  String get images => 'Images';

  @override
  String get addImages => 'Ajouter des images';

  @override
  String get selectPaymentMethods => 'Sélectionner les modes de paiement';

  @override
  String get atLeastOnePaymentMethod => 'Au moins un mode de paiement requis';

  @override
  String get shippingOptions => 'Options d\'expédition';

  @override
  String get shippingAvailable => 'Expédition disponible';

  @override
  String get shippingCostHint => '5.00';

  @override
  String get listingCreated => 'Annonce créée';

  @override
  String get listingUpdated => 'Annonce mise à jour';

  @override
  String get errorCreatingListing => 'Erreur lors de la création de l\'annonce';

  @override
  String get errorUpdatingListing =>
      'Erreur lors de la mise à jour de l\'annonce';

  @override
  String get deleteListing => 'Supprimer l\'annonce';

  @override
  String get deleteListingConfirm =>
      'Voulez-vous vraiment supprimer cette annonce ?';

  @override
  String get listingDeleted => 'Annonce supprimée';

  @override
  String get errorDeletingListing =>
      'Erreur lors de la suppression de l\'annonce';

  @override
  String get slot => 'Slot';

  @override
  String get selectSlot => 'Sélectionner un slot';

  @override
  String get slotRequired => 'Le slot est requis';

  @override
  String get noSlotsAvailable => 'Aucun slot disponible';

  @override
  String get loading => 'Chargement...';

  @override
  String get retry => 'Réessayer';

  @override
  String get searchEmptyStateMessage =>
      'Saisissez un terme de recherche ou sélectionnez des filtres pour trouver des annonces.';

  @override
  String get noResultsMessage =>
      'Essayez d\'autres termes de recherche ou ajustez les filtres.';

  @override
  String get resetFilters => 'Réinitialiser les filtres';

  @override
  String get noCategory => 'Aucune catégorie';

  @override
  String get allSubcategories => 'Toutes les sous-catégories';

  @override
  String get allPaymentMethods => 'Tous les modes de paiement';

  @override
  String searchError(String error) {
    return 'Erreur de recherche : $error';
  }

  @override
  String resultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count résultats',
      one: '1 résultat',
    );
    return '$_temp0';
  }
}
