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

  @override
  String get transactions => 'Transactions';

  @override
  String purchases(int count) {
    return 'Achats ($count)';
  }

  @override
  String sales(int count) {
    return 'Ventes ($count)';
  }

  @override
  String get refresh => 'Actualiser';

  @override
  String get noPurchasesYet => 'Aucun achat pour le moment';

  @override
  String get noSalesYet => 'Aucune vente pour le moment';

  @override
  String get yourPurchasesWillAppearHere => 'Vos achats apparaîtront ici';

  @override
  String get yourSalesWillAppearHere => 'Vos ventes apparaîtront ici';

  @override
  String get statusOpen => 'Ouverte';

  @override
  String get statusPaid => 'Payée';

  @override
  String get statusShipped => 'Expédiée';

  @override
  String get statusReceived => 'Reçue';

  @override
  String get statusCompleted => 'Terminée';

  @override
  String get statusDisputed => 'Contestée';

  @override
  String get statusCancelled => 'Annulée';

  @override
  String get autoCompletesToday => 'Se termine automatiquement aujourd\'hui';

  @override
  String autoCompletesInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'jours',
      one: 'jour',
    );
    return 'Se termine automatiquement dans $count $_temp0';
  }

  @override
  String get transaction => 'Transaction';

  @override
  String get rateThisTransaction => 'Évaluer cette transaction';

  @override
  String shareYourExperience(String username) {
    return 'Partagez votre expérience avec $username';
  }

  @override
  String get rateNow => 'Évaluer maintenant';

  @override
  String get alreadyRated => 'Vous avez déjà évalué cette transaction';

  @override
  String get statusOpenDesc => 'En attente du paiement de l\'acheteur';

  @override
  String get statusPaidDesc =>
      'Paiement envoyé, en attente de l\'expédition par le vendeur';

  @override
  String get statusShippedDesc =>
      'L\'article a été expédié, en attente de livraison';

  @override
  String get statusReceivedDesc => 'L\'acheteur a reçu l\'article';

  @override
  String get statusCompletedDesc => 'Transaction terminée avec succès';

  @override
  String get statusDisputedDesc => 'Un litige a été ouvert';

  @override
  String get statusCancelledDesc => 'La transaction a été annulée';

  @override
  String get timeline => 'Chronologie';

  @override
  String get created => 'Créée';

  @override
  String get paid => 'Payée';

  @override
  String get paymentSent => 'Paiement envoyé';

  @override
  String get waitingForBuyer => 'En attente de l\'acheteur';

  @override
  String get shipped => 'Expédiée';

  @override
  String get waitingForSeller => 'En attente du vendeur';

  @override
  String get received => 'Reçue';

  @override
  String get completed => 'Terminée';

  @override
  String get cancelled => 'Annulée';

  @override
  String get pending => 'En attente';

  @override
  String get markAsShipped => 'Marquer comme expédiée';

  @override
  String get markAsPaid => 'Marquer comme payée';

  @override
  String get markAsReceived => 'Marquer comme reçue';

  @override
  String get cancelTransaction => 'Annuler la transaction';

  @override
  String get openDispute => 'Ouvrir un litige';

  @override
  String get actions => 'Actions';

  @override
  String get confirmShipment =>
      'Confirmez que vous avez expédié l\'article. L\'acheteur aura 14 jours pour confirmer la réception ou ouvrir un litige.';

  @override
  String get confirm => 'Confirmer';

  @override
  String get transactionMarkedAsShipped => 'Transaction marquée comme expédiée';

  @override
  String get confirmPayment =>
      'Confirmez que vous avez envoyé le paiement au vendeur.';

  @override
  String get paymentMarkedAsSent => 'Paiement marqué comme envoyé';

  @override
  String get confirmReceipt =>
      'Confirmez que vous avez reçu l\'article. Cela terminera la transaction.';

  @override
  String get transactionCompleted => 'Transaction terminée';

  @override
  String get cancelTransactionConfirm =>
      'Voulez-vous vraiment annuler cette transaction ? Cette action ne peut pas être annulée.';

  @override
  String get keep => 'Conserver';

  @override
  String get transactionCancelled => 'Transaction annulée';

  @override
  String get describeIssue =>
      'Veuillez décrire le problème avec cette transaction. Un modérateur examinera votre litige.';

  @override
  String get reason => 'Raison';

  @override
  String get describeProblem => 'Décrivez le problème...';

  @override
  String get pleaseEnterReason => 'Veuillez entrer une raison';

  @override
  String get disputeOpened => 'Litige ouvert';

  @override
  String get transactionNotFound => 'Transaction non trouvée';

  @override
  String get transactionId => 'ID de transaction';

  @override
  String get totalPrice => 'Prix total';

  @override
  String get parties => 'Parties';

  @override
  String get buyer => 'Acheteur';

  @override
  String get seller => 'Vendeur';

  @override
  String get you => 'Vous';

  @override
  String get viewListingDetails => 'Voir les détails de l\'annonce';

  @override
  String get buyerNote => 'Note de l\'acheteur';

  @override
  String get autoCompleteWarning => 'Avertissement de fin automatique';

  @override
  String get autoCompleteToday =>
      'Cette transaction se terminera automatiquement aujourd\'hui si aucun litige n\'est ouvert.';

  @override
  String autoCompleteInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'jours',
      one: 'jour',
    );
    return 'Cette transaction se terminera automatiquement dans $count $_temp0 si aucune action n\'est entreprise.';
  }

  @override
  String get disputeOpen => 'Litige ouvert';

  @override
  String disputeReason(String reason) {
    return 'Raison : $reason';
  }

  @override
  String disputeOpenedDate(String date) {
    return 'Ouvert : $date';
  }

  @override
  String get moderatorReviewing => 'Un modérateur examine ce litige.';

  @override
  String get paymentInformation => 'Informations de paiement';

  @override
  String get sendPaymentTo =>
      'Veuillez envoyer le paiement au vendeur avec les détails suivants :';

  @override
  String get includeTransactionId =>
      'Le vendeur expédiera l\'article une fois le paiement reçu. Veuillez inclure votre ID de transaction dans la note de paiement.';

  @override
  String get messages => 'Messages';

  @override
  String get inbox => 'Boîte de réception';

  @override
  String get sent => 'Envoyés';

  @override
  String get drafts => 'Brouillons';

  @override
  String get newMessage => 'Nouveau message';

  @override
  String get noMessages => 'Aucun message';

  @override
  String get inboxEmpty => 'Votre boîte de réception est vide.';

  @override
  String get noSentMessages => 'Aucun message envoyé';

  @override
  String get noSentMessagesYet => 'Vous n\'avez encore envoyé aucun message.';

  @override
  String get noDrafts => 'Aucun brouillon';

  @override
  String get noSavedDrafts => 'Vous n\'avez aucun brouillon enregistré.';

  @override
  String get errorLoadingTitle => 'Erreur de chargement';

  @override
  String from(String username) {
    return 'De : $username';
  }

  @override
  String to(String username) {
    return 'À : $username';
  }

  @override
  String get yesterday => 'Hier';

  @override
  String get monday => 'Lun';

  @override
  String get tuesday => 'Mar';

  @override
  String get wednesday => 'Mer';

  @override
  String get thursday => 'Jeu';

  @override
  String get friday => 'Ven';

  @override
  String get saturday => 'Sam';

  @override
  String get sunday => 'Dim';

  @override
  String userNumber(int id) {
    return 'Utilisateur #$id';
  }

  @override
  String get noRecipient => 'Aucun destinataire';

  @override
  String lastEdited(String date) {
    return 'Dernière modification : $date';
  }

  @override
  String get deleteMessage => 'Supprimer le message ?';

  @override
  String get actionCannotBeUndone => 'Cette action ne peut pas être annulée.';

  @override
  String get deleteDraft => 'Supprimer le brouillon ?';

  @override
  String get reply => 'Répondre';

  @override
  String get decryptingMessage => 'Déchiffrement du message...';

  @override
  String get decryptionFailed => 'Échec du déchiffrement';

  @override
  String get endToEndEncrypted => 'Chiffrement de bout en bout';

  @override
  String fromUser(String username) {
    return 'De : $username';
  }

  @override
  String dateLabel(String date) {
    return 'Date : $date';
  }

  @override
  String get subject => 'Sujet';

  @override
  String get noSubject => '[Aucun sujet]';

  @override
  String get message => 'Message';

  @override
  String get noContent => '[Aucun contenu]';

  @override
  String get editDraft => 'Modifier le brouillon';

  @override
  String get draft => 'Brouillon';

  @override
  String get send => 'Envoyer';

  @override
  String get recipient => 'Destinataire';

  @override
  String get enterUsername => 'Entrer le nom d\'utilisateur';

  @override
  String get messageWillBeEncrypted => 'Le message sera chiffré';

  @override
  String get clickToVerifyRecipient =>
      'Cliquez sur l\'icône de recherche pour vérifier le destinataire';

  @override
  String userNotFoundOrNoKey(String username) {
    return 'Utilisateur \"$username\" non trouvé ou n\'a pas de clé PGP';
  }

  @override
  String get pleaseSelectRecipient => 'Veuillez sélectionner un destinataire';

  @override
  String get recipientNotVerified =>
      'Destinataire non vérifié ou aucune clé PGP disponible. Veuillez vérifier le destinataire.';

  @override
  String get pleaseEnterSubject => 'Veuillez entrer un sujet';

  @override
  String get pleaseEnterMessage => 'Veuillez entrer un message';

  @override
  String errorSending(String error) {
    return 'Erreur d\'envoi : $error';
  }

  @override
  String get draftSaved => 'Brouillon enregistré';

  @override
  String errorSavingDraft(String error) {
    return 'Erreur d\'enregistrement : $error';
  }

  @override
  String get pgpKeys => 'Clés PGP';

  @override
  String get keyInformation => 'Informations sur la clé';

  @override
  String get generateNewKey => 'Générer une nouvelle clé';

  @override
  String get exportKey => 'Exporter la clé';

  @override
  String get importKey => 'Importer la clé';

  @override
  String get serverBackup => 'Sauvegarde serveur';

  @override
  String get securityNotices => 'Avis de sécurité';

  @override
  String get setBackupPassword => 'Définir le mot de passe de sauvegarde';

  @override
  String get generateKey => 'Générer la clé';

  @override
  String get privateKeyExport => 'Export de Private Key';

  @override
  String get importPrivateKey => 'Importer Private Key';

  @override
  String get keyConfigured => 'Clé configurée';

  @override
  String get keyIncomplete => 'Clé incomplète';

  @override
  String get canSendEncryptedMessages =>
      'Vous pouvez envoyer et recevoir des messages chiffrés.';

  @override
  String get generateOrImportKey =>
      'Générez une nouvelle clé ou importez-en une existante.';

  @override
  String get privateKeyLocalPublicKeyMissing =>
      'Private Key présente localement, mais Public Key absente du serveur.';

  @override
  String get publicKeyOnServerPrivateKeyMissing =>
      'Public Key sur le serveur, mais Private Key manquante localement.';

  @override
  String get keysMismatch => 'Les clés ne correspondent pas.';

  @override
  String get exportPrivateKeyForBackup =>
      'Exportez votre Private Key pour la sauvegarder. Conservez-la en sécurité !';

  @override
  String get importExistingPrivateKey =>
      'Importez une Private Key existante (par ex. depuis une sauvegarde ou un autre appareil).';

  @override
  String get storePrivateKeyEncryptedOnServer =>
      'Stockez votre Private Key chiffrée sur le serveur. Cela vous permet de la restaurer sur un autre appareil.';

  @override
  String get securityWarning => 'Avertissement de sécurité';

  @override
  String get aboutToStorePrivateKeyOnServer =>
      'Vous êtes sur le point de stocker votre Private Key sur le serveur.';

  @override
  String get keyWillBeEncryptedBeforeUpload =>
      'La clé sera chiffrée avec un mot de passe avant l\'envoi. Cependant, vous devez noter ce qui suit :';

  @override
  String get chooseStrongUniquePassword =>
      'Choisissez un mot de passe fort et unique';

  @override
  String get passwordCannotBeReset =>
      'Ce mot de passe NE PEUT PAS être réinitialisé';

  @override
  String get backupWorthlessWithoutPassword =>
      'Sans le mot de passe, la sauvegarde est inutile';

  @override
  String get serverOperatorMightGuessPassword =>
      'L\'opérateur du serveur pourrait tenter de deviner le mot de passe';

  @override
  String get chooseStrongPasswordForBackup =>
      'Choisissez un mot de passe fort pour votre sauvegarde. Vous en aurez besoin pour restaurer la clé.';

  @override
  String get passwordsDontMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get pleaseEnterName => 'Veuillez entrer un nom';

  @override
  String get enterPasswordForBackup =>
      'Entrez le mot de passe que vous avez utilisé pour chiffrer la sauvegarde :';

  @override
  String get decryptingAndImporting => 'Déchiffrement et importation...';

  @override
  String get decryptionFailedWrongPassword =>
      'Échec du déchiffrement. Mauvais mot de passe ?';

  @override
  String get understandProceed => 'Je comprends, continuer';

  @override
  String get uploadPublicKey => 'Téléverser Public Key';

  @override
  String get generating => 'Génération...';

  @override
  String get exportPrivateKey => 'Exporter Private Key';

  @override
  String get pastePrivateKey => 'Coller Private Key';

  @override
  String get loadFromServerBackup => 'Charger depuis la sauvegarde serveur';

  @override
  String get createEncryptedBackup => 'Créer une sauvegarde chiffrée';

  @override
  String get copyFingerprint => 'Copier Fingerprint';

  @override
  String get createBackup => 'Créer une sauvegarde';

  @override
  String get restore => 'Restaurer';

  @override
  String errorLoading(String error) {
    return 'Erreur de chargement';
  }

  @override
  String get existingKeyWillBeReplaced => 'La clé existante sera remplacée !';

  @override
  String get invalidKeyAfterDecryption => 'Clé invalide après déchiffrement';

  @override
  String get noPrivateKey => 'Aucune Private Key disponible';

  @override
  String get noFingerprint => 'Aucun fingerprint disponible';

  @override
  String get backupSuccessfullySaved =>
      'Sauvegarde enregistrée avec succès sur le serveur !';

  @override
  String errorBackup(String error) {
    return 'Erreur lors de la sauvegarde : $error';
  }

  @override
  String get noBackupOnServer => 'Aucune sauvegarde trouvée sur le serveur.';

  @override
  String errorGeneration(String error) {
    return 'Erreur lors de la génération : $error';
  }

  @override
  String get keySuccessfullyGenerated =>
      'Clé générée et téléversée avec succès !';

  @override
  String errorUploading(String error) {
    return 'Erreur lors du téléversement : $error';
  }

  @override
  String get privateKeyNeverLeavesDevice =>
      'Votre Private Key ne quitte jamais cet appareil';

  @override
  String get onlyPublicKeyStoredOnServer =>
      'Seule la Public Key est stockée sur le serveur';

  @override
  String get regularBackupsRecommended =>
      'Créez des sauvegardes régulières de votre Private Key';

  @override
  String get lostKeyCannotDecryptOldMessages =>
      'Si vous perdez votre clé, les anciens messages ne pourront pas être déchiffrés';

  @override
  String get createsNewEd25519Key =>
      'Crée une nouvelle clé Ed25519/Curve25519. Cela ne prend que quelques secondes.';

  @override
  String get generatingEd25519Key =>
      'Création d\'une clé Ed25519/Curve25519. Cela ne prend que quelques secondes.';

  @override
  String get keySuccessfullyRestored => 'Clé restaurée avec succès !';

  @override
  String get protectWithPassphrase => 'Protéger avec une passphrase';

  @override
  String get recommendedForSecurity =>
      'Recommandé pour une sécurité supplémentaire';

  @override
  String get passphrase => 'Passphrase';

  @override
  String get enterSecurePassphrase => 'Entrez une passphrase sécurisée';

  @override
  String get name => 'Nom';

  @override
  String get yourName => 'Votre nom';

  @override
  String get emailOptional => 'Email (facultatif)';

  @override
  String get yourEmailCom => 'votre@email.com';

  @override
  String get fingerprint => 'Fingerprint';

  @override
  String get algorithm => 'Algorithme';

  @override
  String get keySize => 'Taille de clé';

  @override
  String get identity => 'Identité';

  @override
  String get keepKeySafe =>
      'Conservez cette clé en sécurité ! Ne la partagez jamais avec d\'autres.';

  @override
  String get pastePrivateKeyInPgpFormat =>
      'Collez votre Private Key au format PGP armor :';

  @override
  String get beginPgpPrivateKeyBlock => '-----BEGIN PGP PRIVATE KEY BLOCK-----';

  @override
  String get pleasePasteKey => 'Veuillez coller une clé';

  @override
  String get invalidKeyFormat => 'Format de clé invalide';

  @override
  String get privateKeySuccessfullyImported =>
      'Private Key importée avec succès !';

  @override
  String get selectBackupToRestore =>
      'Sélectionnez la sauvegarde que vous souhaitez restaurer :';

  @override
  String get selectBackup => 'Sélectionner une sauvegarde';

  @override
  String get decryptBackup => 'Déchiffrer la sauvegarde';

  @override
  String copiedToClipboard(String label) {
    return '$label copié dans le presse-papiers';
  }

  @override
  String get publicKeySuccessfullyUploaded =>
      'Public Key téléversée avec succès !';

  @override
  String get backupPassword => 'Mot de passe de sauvegarde';

  @override
  String get keyGenerationTooLong =>
      'La génération de clé prend trop de temps. Veuillez réessayer ou redémarrer l\'application.';

  @override
  String get noOwnPgpKey =>
      'Aucune clé PGP personnelle disponible. Veuillez téléverser votre Public Key.';

  @override
  String get recipientHasNoPgpKey => 'Le destinataire n\'a pas de clé PGP';
}
