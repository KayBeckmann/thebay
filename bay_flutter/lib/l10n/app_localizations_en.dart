// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Bay';

  @override
  String get loginTitle => 'Welcome Back';

  @override
  String get loginSubtitle => 'Sign in to continue';

  @override
  String get username => 'Username';

  @override
  String get usernameRequired => 'Please enter your username';

  @override
  String get password => 'Password';

  @override
  String get passwordRequired => 'Please enter your password';

  @override
  String get stayLoggedIn => 'Stay logged in';

  @override
  String get signIn => 'Sign In';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get signUp => 'Sign Up';

  @override
  String get loginFailed => 'Login failed';

  @override
  String get connectionError => 'Connection error. Please try again.';

  @override
  String tryAgainInSeconds(int seconds) {
    return 'Try again in $seconds seconds';
  }

  @override
  String get registerTitle => 'Create Account';

  @override
  String get registerSubtitle => 'Sign up to get started';

  @override
  String get usernameHelper => '3-20 characters, letters, numbers, underscores';

  @override
  String get usernameMinLength => 'Username must be at least 3 characters';

  @override
  String get usernameMaxLength => 'Username must be at most 20 characters';

  @override
  String get usernameInvalidChars =>
      'Only letters, numbers, and underscores allowed';

  @override
  String get passwordHelper => 'Min 8 chars, uppercase, lowercase, digit';

  @override
  String get passwordMinLength => 'Password must be at least 8 characters';

  @override
  String get passwordNeedsUppercase =>
      'Password must contain an uppercase letter';

  @override
  String get passwordNeedsLowercase =>
      'Password must contain a lowercase letter';

  @override
  String get passwordNeedsDigit => 'Password must contain a digit';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get agreeToTerms => 'I agree to the ';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get close => 'Close';

  @override
  String get createAccount => 'Create Account';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get mustAcceptTerms => 'You must accept the terms of service';

  @override
  String get registrationFailed => 'Registration failed';

  @override
  String get generatingKey => 'Generating security key...';

  @override
  String get generatingKeyMessage =>
      'Your personal encryption key is being generated.\nThis will only take a few seconds.';

  @override
  String keyGenerationFailed(String error) {
    return 'Key could not be generated: $error\nYou can create it later in settings.';
  }

  @override
  String elapsedTime(String time) {
    return 'Elapsed time: $time';
  }

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navMessages => 'Messages';

  @override
  String get navSearch => 'Search';

  @override
  String get navSell => 'Sell';

  @override
  String get navTransactions => 'Transactions';

  @override
  String get navSettings => 'Settings';

  @override
  String get navModeration => 'Moderation';

  @override
  String get navNews => 'News';

  @override
  String get navAdmin => 'Admin';

  @override
  String get drawerUserFallback => 'User';

  @override
  String get drawerModerationSection => 'Moderation';

  @override
  String get drawerAdminSection => 'Administration';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleModerator => 'Moderator';

  @override
  String get roleUser => 'User';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get sectionPaymentInfo => 'Payment Information';

  @override
  String get sectionDisplay => 'Display';

  @override
  String get sectionSecurity => 'Security';

  @override
  String get sectionAccount => 'Account';

  @override
  String get paypalAddress => 'PayPal Address';

  @override
  String get bitcoinWallet => 'Bitcoin Wallet';

  @override
  String get notSpecified => 'Not specified';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get emailHint => 'your@email.com';

  @override
  String get walletAddress => 'Wallet Address';

  @override
  String get walletHint => 'bc1q...';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get paypalAddressSaved => 'PayPal address saved';

  @override
  String get bitcoinWalletSaved => 'Bitcoin wallet saved';

  @override
  String errorSaving(String error) {
    return 'Error saving: $error';
  }

  @override
  String get itemsPerPage => 'Items per page';

  @override
  String itemsCount(int count) {
    return '$count items';
  }

  @override
  String get displayCurrency => 'Display Currency';

  @override
  String get language => 'Language';

  @override
  String get languageChanged =>
      'Language changed. Please restart the app to apply the change.';

  @override
  String get langEnglish => 'English';

  @override
  String get langGerman => 'Deutsch';

  @override
  String get langFrench => 'Français';

  @override
  String get langSpanish => 'Español';

  @override
  String get pgpKey => 'PGP Key';

  @override
  String get configured => 'Configured';

  @override
  String get notConfigured => 'Not configured yet';

  @override
  String get changePassword => 'Change Password';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get passwordsMismatch => 'Passwords do not match';

  @override
  String get passwordChangeSuccess => 'Password changed successfully';

  @override
  String get passwordChangeError => 'Error changing password';

  @override
  String get changeButton => 'Change';

  @override
  String get logout => 'Log Out';

  @override
  String get logoutConfirm => 'Do you really want to log out?';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountWarning =>
      'This action cannot be undone. All your data will be permanently deleted.';

  @override
  String get passwordConfirmation => 'Password for confirmation';

  @override
  String get pleaseEnterPassword => 'Please enter your password';

  @override
  String get deleteAccountError => 'Error deleting account';

  @override
  String genericError(String error) {
    return 'Error: $error';
  }

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String welcomeUser(String username) {
    return 'Welcome, $username!';
  }

  @override
  String get userFallback => 'User';

  @override
  String get whatTodayQuestion => 'What would you like to do today?';

  @override
  String get sectionPendingRatings => 'Pending Ratings';

  @override
  String get sectionNews => 'News';

  @override
  String get sectionSlotWarnings => 'Slot Warnings';

  @override
  String get sectionRecentListings => 'Recent Listings';

  @override
  String get noNews => 'No News';

  @override
  String get noNewsMessage => 'There are currently no news. Check back later!';

  @override
  String pendingRatingsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'You have $count pending ratings',
      one: 'You have 1 pending rating',
    );
    return '$_temp0';
  }

  @override
  String transactionNumber(int id) {
    return 'Transaction #$id';
  }

  @override
  String viewAllPendingRatings(int count) {
    return 'View all $count pending ratings';
  }

  @override
  String get noSlotsExpiring => 'No slots expire in the next 3 days.';

  @override
  String slotsExpiringSoon(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count slots expire soon',
      one: '1 slot expires soon',
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
  String get noListingLinked => 'No listing linked';

  @override
  String moreCount(int count) {
    return '+$count more';
  }

  @override
  String get noListingsYet => 'No listings yet';

  @override
  String get noListingsMessage =>
      'You haven\'t created any listings yet. Create your first listing now!';

  @override
  String get unitPiece => 'piece';

  @override
  String get unitKg => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitMeter => 'm';

  @override
  String get unitLiter => 'L';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get create => 'Create';

  @override
  String get active => 'Active';

  @override
  String get inactive => 'Inactive';

  @override
  String get required => 'Required';

  @override
  String get invalidInput => 'Invalid input';

  @override
  String get shipping => 'Shipping';

  @override
  String get shippingMethod => 'Shipping method';

  @override
  String get shippingCost => 'Shipping cost';

  @override
  String get searchTitle => 'Search';

  @override
  String get favorites => 'Favorites';

  @override
  String get searchListingsHint => 'Search listings...';

  @override
  String get category => 'Category';

  @override
  String get subcategory => 'Subcategory';

  @override
  String get paymentMethod => 'Payment method';

  @override
  String get clearFilters => 'Clear filters';

  @override
  String get noResults => 'No results';

  @override
  String get browseListings => 'Browse listings';

  @override
  String get paypal => 'PayPal';

  @override
  String get bitcoin => 'Bitcoin';

  @override
  String get listingDetailTitle => 'Listing Details';

  @override
  String get description => 'Description';

  @override
  String get details => 'Details';

  @override
  String get acceptedPaymentMethods => 'Accepted payment methods';

  @override
  String get quantity => 'Quantity';

  @override
  String pricePerUnit(Object price, Object unit) {
    return '$price per $unit';
  }

  @override
  String get createdAt => 'Created at';

  @override
  String get expiresAt => 'Expires at';

  @override
  String get listingNotFound => 'Listing not found';

  @override
  String get tryAgain => 'Try again';

  @override
  String get buyNow => 'Buy now';

  @override
  String get contactSeller => 'Contact seller';

  @override
  String get createListingTitle => 'New Listing';

  @override
  String get editListingTitle => 'Edit Listing';

  @override
  String get title => 'Title';

  @override
  String get titleHint => 'Enter a title';

  @override
  String get titleRequired => 'Title is required';

  @override
  String get descriptionHint => 'Describe your listing...';

  @override
  String get descriptionRequired => 'Description is required';

  @override
  String get price => 'Price';

  @override
  String get priceHint => '0.00';

  @override
  String get priceRequired => 'Price is required';

  @override
  String get priceInvalid => 'Price must be greater than 0';

  @override
  String get quantityHint => '1';

  @override
  String get quantityRequired => 'Quantity is required';

  @override
  String get quantityInvalid => 'Quantity must be greater than 0';

  @override
  String get unit => 'Unit';

  @override
  String get selectCategory => 'Select category';

  @override
  String get selectSubcategory => 'Select subcategory';

  @override
  String get categoryRequired => 'Category is required';

  @override
  String get images => 'Images';

  @override
  String get addImages => 'Add images';

  @override
  String get selectPaymentMethods => 'Select payment methods';

  @override
  String get atLeastOnePaymentMethod => 'At least one payment method required';

  @override
  String get shippingOptions => 'Shipping options';

  @override
  String get shippingAvailable => 'Shipping available';

  @override
  String get shippingCostHint => '5.00';

  @override
  String get listingCreated => 'Listing created';

  @override
  String get listingUpdated => 'Listing updated';

  @override
  String get errorCreatingListing => 'Error creating listing';

  @override
  String get errorUpdatingListing => 'Error updating listing';

  @override
  String get deleteListing => 'Delete listing';

  @override
  String deleteListingConfirm(Object title) {
    return 'Do you really want to delete this listing?';
  }

  @override
  String get listingDeleted => 'Listing deleted';

  @override
  String get errorDeletingListing => 'Error deleting listing';

  @override
  String get slot => 'Slot';

  @override
  String get selectSlot => 'Select slot';

  @override
  String get slotRequired => 'Slot is required';

  @override
  String get noSlotsAvailable => 'No slots available';

  @override
  String get loading => 'Loading...';

  @override
  String get retry => 'Retry';

  @override
  String get searchEmptyStateMessage =>
      'Enter a search term or select filters to find listings.';

  @override
  String get noResultsMessage =>
      'Try different search terms or adjust the filters.';

  @override
  String get resetFilters => 'Reset filters';

  @override
  String get noCategory => 'No category';

  @override
  String get allSubcategories => 'All subcategories';

  @override
  String get allPaymentMethods => 'All payment methods';

  @override
  String searchError(String error) {
    return 'Search error: $error';
  }

  @override
  String resultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count results',
      one: '1 result',
    );
    return '$_temp0';
  }

  @override
  String get transactions => 'Transactions';

  @override
  String purchases(int count) {
    return 'Purchases ($count)';
  }

  @override
  String sales(int count) {
    return 'Sales ($count)';
  }

  @override
  String get refresh => 'Refresh';

  @override
  String get noPurchasesYet => 'No purchases yet';

  @override
  String get noSalesYet => 'No sales yet';

  @override
  String get yourPurchasesWillAppearHere => 'Your purchases will appear here';

  @override
  String get yourSalesWillAppearHere => 'Your sales will appear here';

  @override
  String get statusOpen => 'Open';

  @override
  String get statusPaid => 'Paid';

  @override
  String get statusShipped => 'Shipped';

  @override
  String get statusReceived => 'Received';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get statusDisputed => 'Disputed';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get autoCompletesToday => 'Auto-completes today';

  @override
  String autoCompletesInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'days',
      one: 'day',
    );
    return 'Auto-completes in $count $_temp0';
  }

  @override
  String get transaction => 'Transaction';

  @override
  String get rateThisTransaction => 'Rate this transaction';

  @override
  String shareYourExperience(String username) {
    return 'Share your experience with $username';
  }

  @override
  String get rateNow => 'Rate now';

  @override
  String get alreadyRated => 'You have already rated this transaction';

  @override
  String get statusOpenDesc => 'Waiting for buyer\'s payment';

  @override
  String get statusPaidDesc => 'Payment sent, waiting for seller to ship';

  @override
  String get statusShippedDesc => 'Item has been shipped, waiting for delivery';

  @override
  String get statusReceivedDesc => 'Buyer has received the item';

  @override
  String get statusCompletedDesc => 'Transaction completed successfully';

  @override
  String get statusDisputedDesc => 'A dispute has been opened';

  @override
  String get statusCancelledDesc => 'Transaction was cancelled';

  @override
  String get timeline => 'Timeline';

  @override
  String created(Object date) {
    return 'Created on $date';
  }

  @override
  String get paid => 'Paid';

  @override
  String get paymentSent => 'Payment sent';

  @override
  String get waitingForBuyer => 'Waiting for buyer';

  @override
  String get shipped => 'Shipped';

  @override
  String get waitingForSeller => 'Waiting for seller';

  @override
  String get received => 'Received';

  @override
  String get completed => 'Completed';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get pending => 'Pending';

  @override
  String get markAsShipped => 'Mark as shipped';

  @override
  String get markAsPaid => 'Mark as paid';

  @override
  String get markAsReceived => 'Mark as received';

  @override
  String get cancelTransaction => 'Cancel transaction';

  @override
  String get openDispute => 'Open dispute';

  @override
  String get actions => 'Actions';

  @override
  String get confirmShipment =>
      'Confirm that you have shipped the item. The buyer will have 14 days to confirm receipt or open a dispute.';

  @override
  String get confirm => 'Confirm';

  @override
  String get transactionMarkedAsShipped => 'Transaction marked as shipped';

  @override
  String get confirmPayment =>
      'Confirm that you have sent the payment to the seller.';

  @override
  String get paymentMarkedAsSent => 'Payment marked as sent';

  @override
  String get confirmReceipt =>
      'Confirm that you have received the item. This will complete the transaction.';

  @override
  String get transactionCompleted => 'Transaction completed';

  @override
  String get cancelTransactionConfirm =>
      'Do you really want to cancel this transaction? This action cannot be undone.';

  @override
  String get keep => 'Keep';

  @override
  String get transactionCancelled => 'Transaction cancelled';

  @override
  String get describeIssue =>
      'Please describe the issue with this transaction. A moderator will review your dispute.';

  @override
  String get reason => 'Reason';

  @override
  String get describeProblem => 'Describe the problem...';

  @override
  String get pleaseEnterReason => 'Please enter a reason';

  @override
  String get disputeOpened => 'Dispute opened';

  @override
  String get transactionNotFound => 'Transaction not found';

  @override
  String get transactionId => 'Transaction ID';

  @override
  String get totalPrice => 'Total price';

  @override
  String get parties => 'Parties';

  @override
  String get buyer => 'Buyer';

  @override
  String get seller => 'Seller';

  @override
  String get you => 'You';

  @override
  String get viewListingDetails => 'View listing details';

  @override
  String get buyerNote => 'Buyer note';

  @override
  String get autoCompleteWarning => 'Auto-complete warning';

  @override
  String get autoCompleteToday =>
      'This transaction will auto-complete today if no dispute is opened.';

  @override
  String autoCompleteInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'days',
      one: 'day',
    );
    return 'This transaction will auto-complete in $count $_temp0 if no action is taken.';
  }

  @override
  String get disputeOpen => 'Dispute open';

  @override
  String disputeReason(String reason) {
    return 'Reason: $reason';
  }

  @override
  String disputeOpenedDate(String date) {
    return 'Opened: $date';
  }

  @override
  String get moderatorReviewing => 'A moderator is reviewing this dispute.';

  @override
  String get paymentInformation => 'Payment information';

  @override
  String get sendPaymentTo =>
      'Please send payment to the seller with the following details:';

  @override
  String get includeTransactionId =>
      'The seller will ship the item once payment is received. Please include your transaction ID in the payment note.';

  @override
  String get messages => 'Messages';

  @override
  String get inbox => 'Inbox';

  @override
  String get sent => 'Sent';

  @override
  String get drafts => 'Drafts';

  @override
  String get newMessage => 'New message';

  @override
  String get noMessages => 'No messages';

  @override
  String get inboxEmpty => 'Your inbox is empty.';

  @override
  String get noSentMessages => 'No sent messages';

  @override
  String get noSentMessagesYet => 'You haven\'t sent any messages yet.';

  @override
  String get noDrafts => 'No drafts';

  @override
  String get noSavedDrafts => 'You have no saved drafts.';

  @override
  String get errorLoadingTitle => 'Error loading';

  @override
  String from(String username) {
    return 'From: $username';
  }

  @override
  String to(String username) {
    return 'To: $username';
  }

  @override
  String get yesterday => 'Yesterday';

  @override
  String get monday => 'Mon';

  @override
  String get tuesday => 'Tue';

  @override
  String get wednesday => 'Wed';

  @override
  String get thursday => 'Thu';

  @override
  String get friday => 'Fri';

  @override
  String get saturday => 'Sat';

  @override
  String get sunday => 'Sun';

  @override
  String userNumber(int id) {
    return 'User #$id';
  }

  @override
  String get noRecipient => 'No recipient';

  @override
  String lastEdited(String date) {
    return 'Last edited: $date';
  }

  @override
  String get deleteMessage => 'Delete message?';

  @override
  String get actionCannotBeUndone => 'This action cannot be undone.';

  @override
  String get deleteDraft => 'Delete draft?';

  @override
  String get reply => 'Reply';

  @override
  String get decryptingMessage => 'Decrypting message...';

  @override
  String get decryptionFailed => 'Decryption failed';

  @override
  String get endToEndEncrypted => 'End-to-end encrypted';

  @override
  String fromUser(String username) {
    return 'From: $username';
  }

  @override
  String dateLabel(String date) {
    return 'Date: $date';
  }

  @override
  String get subject => 'Subject';

  @override
  String get noSubject => '[No subject]';

  @override
  String get message => 'Message';

  @override
  String get noContent => '[No content]';

  @override
  String get editDraft => 'Edit draft';

  @override
  String get draft => 'Draft';

  @override
  String get send => 'Send';

  @override
  String get recipient => 'Recipient';

  @override
  String get enterUsername => 'Enter username';

  @override
  String get messageWillBeEncrypted => 'Message will be encrypted';

  @override
  String get clickToVerifyRecipient =>
      'Click the search icon to verify recipient';

  @override
  String userNotFoundOrNoKey(String username) {
    return 'User \"$username\" not found or has no PGP key';
  }

  @override
  String get pleaseSelectRecipient => 'Please select a recipient';

  @override
  String get recipientNotVerified =>
      'Recipient not verified or no PGP key available. Please verify recipient.';

  @override
  String get pleaseEnterSubject => 'Please enter a subject';

  @override
  String get pleaseEnterMessage => 'Please enter a message';

  @override
  String errorSending(String error) {
    return 'Error sending: $error';
  }

  @override
  String get draftSaved => 'Draft saved';

  @override
  String errorSavingDraft(String error) {
    return 'Error saving: $error';
  }

  @override
  String get pgpKeys => 'PGP Keys';

  @override
  String get keyInformation => 'Key Information';

  @override
  String get generateNewKey => 'Generate New Key';

  @override
  String get exportKey => 'Export Key';

  @override
  String get importKey => 'Import Key';

  @override
  String get serverBackup => 'Server Backup';

  @override
  String get securityNotices => 'Security Notices';

  @override
  String get setBackupPassword => 'Set Backup Password';

  @override
  String get generateKey => 'Generate Key';

  @override
  String get privateKeyExport => 'Private Key Export';

  @override
  String get importPrivateKey => 'Import Private Key';

  @override
  String get keyConfigured => 'Key Configured';

  @override
  String get keyIncomplete => 'Key Incomplete';

  @override
  String get canSendEncryptedMessages =>
      'You can send and receive encrypted messages.';

  @override
  String get generateOrImportKey =>
      'Generate a new key or import an existing one.';

  @override
  String get privateKeyLocalPublicKeyMissing =>
      'Private Key exists locally, but Public Key not on server.';

  @override
  String get publicKeyOnServerPrivateKeyMissing =>
      'Public Key on server, but Private Key missing locally.';

  @override
  String get keysMismatch => 'Keys do not match.';

  @override
  String get exportPrivateKeyForBackup =>
      'Export your Private Key for backup. Keep it safe!';

  @override
  String get importExistingPrivateKey =>
      'Import an existing Private Key (e.g., from a backup or another device).';

  @override
  String get storePrivateKeyEncryptedOnServer =>
      'Store your Private Key encrypted on the server. This allows you to restore it on another device.';

  @override
  String get securityWarning => 'Security Warning';

  @override
  String get aboutToStorePrivateKeyOnServer =>
      'You are about to store your Private Key on the server.';

  @override
  String get keyWillBeEncryptedBeforeUpload =>
      'The key will be encrypted with a password before upload. However, you should note the following:';

  @override
  String get chooseStrongUniquePassword => 'Choose a strong, unique password';

  @override
  String get passwordCannotBeReset => 'This password CANNOT be reset';

  @override
  String get backupWorthlessWithoutPassword =>
      'Without the password, the backup is worthless';

  @override
  String get serverOperatorMightGuessPassword =>
      'The server operator might attempt to guess the password';

  @override
  String get chooseStrongPasswordForBackup =>
      'Choose a strong password for your backup. You will need it to restore the key.';

  @override
  String get passwordsDontMatch => 'Passwords do not match';

  @override
  String get pleaseEnterName => 'Please enter a name';

  @override
  String get enterPasswordForBackup =>
      'Enter the password you used to encrypt the backup:';

  @override
  String get decryptingAndImporting => 'Decrypting and importing...';

  @override
  String get decryptionFailedWrongPassword =>
      'Decryption failed. Wrong password?';

  @override
  String get understandProceed => 'I understand, proceed';

  @override
  String get uploadPublicKey => 'Upload Public Key';

  @override
  String get generating => 'Generating...';

  @override
  String get exportPrivateKey => 'Export Private Key';

  @override
  String get pastePrivateKey => 'Paste Private Key';

  @override
  String get loadFromServerBackup => 'Load from Server Backup';

  @override
  String get createEncryptedBackup => 'Create Encrypted Backup';

  @override
  String get copyFingerprint => 'Copy Fingerprint';

  @override
  String get createBackup => 'Create Backup';

  @override
  String get restore => 'Restore';

  @override
  String errorLoading(String error) {
    return 'Error loading';
  }

  @override
  String get existingKeyWillBeReplaced => 'The existing key will be replaced!';

  @override
  String get invalidKeyAfterDecryption => 'Invalid key after decryption';

  @override
  String get noPrivateKey => 'No Private Key available';

  @override
  String get noFingerprint => 'No fingerprint available';

  @override
  String get backupSuccessfullySaved => 'Backup successfully saved to server!';

  @override
  String errorBackup(String error) {
    return 'Error during backup: $error';
  }

  @override
  String get noBackupOnServer => 'No backup found on server.';

  @override
  String errorGeneration(String error) {
    return 'Error during generation: $error';
  }

  @override
  String get keySuccessfullyGenerated =>
      'Key successfully generated and uploaded!';

  @override
  String errorUploading(String error) {
    return 'Error uploading: $error';
  }

  @override
  String get privateKeyNeverLeavesDevice =>
      'Your Private Key never leaves this device';

  @override
  String get onlyPublicKeyStoredOnServer =>
      'Only the Public Key is stored on the server';

  @override
  String get regularBackupsRecommended =>
      'Create regular backups of your Private Key';

  @override
  String get lostKeyCannotDecryptOldMessages =>
      'If you lose your key, old messages cannot be decrypted';

  @override
  String get createsNewEd25519Key =>
      'Creates a new Ed25519/Curve25519 key. This takes only a few seconds.';

  @override
  String get generatingEd25519Key =>
      'Creating Ed25519/Curve25519 key. This takes only a few seconds.';

  @override
  String get keySuccessfullyRestored => 'Key successfully restored!';

  @override
  String get protectWithPassphrase => 'Protect with passphrase';

  @override
  String get recommendedForSecurity => 'Recommended for additional security';

  @override
  String get passphrase => 'Passphrase';

  @override
  String get enterSecurePassphrase => 'Enter a secure passphrase';

  @override
  String get name => 'Name';

  @override
  String get yourName => 'Your name';

  @override
  String get emailOptional => 'Email (optional)';

  @override
  String get yourEmailCom => 'your@email.com';

  @override
  String get fingerprint => 'Fingerprint';

  @override
  String get algorithm => 'Algorithm';

  @override
  String get keySize => 'Key Size';

  @override
  String get identity => 'Identity';

  @override
  String get keepKeySafe => 'Keep this key safe! Never share it with others.';

  @override
  String get pastePrivateKeyInPgpFormat =>
      'Paste your Private Key in PGP armor format:';

  @override
  String get beginPgpPrivateKeyBlock => '-----BEGIN PGP PRIVATE KEY BLOCK-----';

  @override
  String get pleasePasteKey => 'Please paste a key';

  @override
  String get invalidKeyFormat => 'Invalid key format';

  @override
  String get privateKeySuccessfullyImported =>
      'Private Key successfully imported!';

  @override
  String get selectBackupToRestore => 'Select the backup you want to restore:';

  @override
  String get selectBackup => 'Select Backup';

  @override
  String get decryptBackup => 'Decrypt Backup';

  @override
  String copiedToClipboard(String label) {
    return '$label copied to clipboard';
  }

  @override
  String get publicKeySuccessfullyUploaded =>
      'Public Key successfully uploaded!';

  @override
  String get backupPassword => 'Backup Password';

  @override
  String get keyGenerationTooLong =>
      'Key generation is taking too long. Please try again or restart the app.';

  @override
  String get noOwnPgpKey =>
      'No own PGP key available. Please upload your Public Key.';

  @override
  String get recipientHasNoPgpKey => 'Recipient has no PGP key';

  @override
  String get adminPanel => 'Admin Panel';

  @override
  String get adminPanelWelcome => 'Welcome to the Admin Area';

  @override
  String get userManagement => 'User Management';

  @override
  String get categoryManagement => 'Category Management';

  @override
  String get newsManagement => 'News Management';

  @override
  String get paymentSettings => 'Payment Settings';

  @override
  String get pendingPayments => 'Pending Payments';

  @override
  String get slotVariants => 'Slot Variants';

  @override
  String get moderatorPanel => 'Moderator Panel';

  @override
  String get moderatorPanelWelcome => 'Welcome to the Moderation Area';

  @override
  String get reports => 'Reports';

  @override
  String get disputes => 'Disputes';

  @override
  String get allReports => 'All Reports';

  @override
  String get openReports => 'Open';

  @override
  String get inReviewReports => 'In Review';

  @override
  String get resolvedReports => 'Resolved';

  @override
  String get dismissedReports => 'Dismissed';

  @override
  String get statusReportOpen => 'OPEN';

  @override
  String get statusReportInReview => 'IN REVIEW';

  @override
  String get statusReportResolved => 'RESOLVED';

  @override
  String get statusReportDismissed => 'DISMISSED';

  @override
  String get reportedBy => 'Reported by';

  @override
  String get reportedUser => 'Reported User';

  @override
  String get reportedListing => 'Reported Listing';

  @override
  String get reportReason => 'Reason';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonInappropriate => 'Inappropriate Content';

  @override
  String get reportReasonScam => 'Scam/Fraud';

  @override
  String get reportReasonHarassment => 'Harassment';

  @override
  String get reportReasonFakeInfo => 'False Information';

  @override
  String get reportReasonOther => 'Other';

  @override
  String get noReports => 'No Reports';

  @override
  String get noReportsMessage => 'There are currently no reports to review.';

  @override
  String get viewReport => 'View Report';

  @override
  String get reportDetail => 'Report Details';

  @override
  String reportId(Object id) {
    return 'Report ID';
  }

  @override
  String get reportType => 'Type';

  @override
  String get reportTypeUser => 'User';

  @override
  String get reportTypeListing => 'Listing';

  @override
  String get reportedAt => 'Reported at';

  @override
  String get reportDescription => 'Description';

  @override
  String get moderatorNotes => 'Moderator Notes';

  @override
  String get addNote => 'Add Note';

  @override
  String get internalNotesOnly => 'Visible to moderators only';

  @override
  String get enterNote => 'Enter note...';

  @override
  String get noteSaved => 'Note saved';

  @override
  String get takeAction => 'Take Action';

  @override
  String get markAsInReview => 'Mark as In Review';

  @override
  String get resolveReport => 'Resolve Report';

  @override
  String get dismissReport => 'Dismiss Report';

  @override
  String get viewReportedUser => 'View Reported User';

  @override
  String get viewReportedListing => 'View Reported Listing';

  @override
  String get warnUser => 'Warn User';

  @override
  String get banUser => 'Ban User';

  @override
  String get reportMarkedInReview => 'Report marked as in review';

  @override
  String get reportResolved => 'Report resolved';

  @override
  String get reportDismissed => 'Report dismissed';

  @override
  String get confirmResolveReport =>
      'Do you want to mark this report as resolved?';

  @override
  String get confirmDismissReport => 'Do you want to dismiss this report?';

  @override
  String get resolve => 'Resolve';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get userDetail => 'User Details';

  @override
  String userId(Object id) {
    return 'User ID';
  }

  @override
  String get registeredAt => 'Registered at';

  @override
  String get lastActive => 'Last active';

  @override
  String get totalListings => 'Total listings';

  @override
  String get totalTransactions => 'Total transactions';

  @override
  String get userRating => 'Rating';

  @override
  String get userStatus => 'Status';

  @override
  String get userStatusActive => 'Active';

  @override
  String get userStatusBanned => 'Banned';

  @override
  String get userStatusWarned => 'Warned';

  @override
  String get banUserDialog => 'Ban User';

  @override
  String banReason(Object reason) {
    return 'Ban Reason';
  }

  @override
  String get selectBanReason => 'Select ban reason';

  @override
  String get banReasonSpam => 'Spam';

  @override
  String get banReasonScam => 'Scam';

  @override
  String get banReasonHarassment => 'Harassment';

  @override
  String get banReasonIllegalContent => 'Illegal Content';

  @override
  String get banReasonMultipleViolations => 'Multiple Violations';

  @override
  String get banReasonOther => 'Other';

  @override
  String get banDuration => 'Ban Duration';

  @override
  String get banDuration24h => '24 Hours';

  @override
  String get banDuration7d => '7 Days';

  @override
  String get banDuration30d => '30 Days';

  @override
  String get banDurationPermanent => 'Permanent';

  @override
  String get additionalNotes => 'Additional Notes';

  @override
  String get optionalNotes => 'Optional: Additional information...';

  @override
  String get confirmBanUser => 'Do you really want to ban this user?';

  @override
  String get ban => 'Ban';

  @override
  String get userBanned => 'User banned';

  @override
  String get userWarned => 'User warned';

  @override
  String get newsManagementScreen => 'News Management';

  @override
  String get allNews => 'All News';

  @override
  String get publishedNews => 'Published';

  @override
  String get draftNews => 'Drafts';

  @override
  String get createNews => 'Create News';

  @override
  String get noNewsItems => 'No News Items';

  @override
  String get noNewsItemsMessage => 'No news items have been created yet.';

  @override
  String get newsTitle => 'Title';

  @override
  String get newsContent => 'Content';

  @override
  String get newsStatus => 'Status';

  @override
  String get newsStatusPublished => 'Published';

  @override
  String get newsStatusDraft => 'Draft';

  @override
  String get publishedAt => 'Published at';

  @override
  String get editNews => 'Edit News';

  @override
  String get deleteNews => 'Delete News';

  @override
  String get createNewsItem => 'Create News';

  @override
  String get editNewsItem => 'Edit News';

  @override
  String get enterNewsTitle => 'Enter news title';

  @override
  String get enterNewsContent => 'Enter news content...';

  @override
  String get newsTitleRequired => 'Title is required';

  @override
  String get newsContentRequired => 'Content is required';

  @override
  String get publish => 'Publish';

  @override
  String get saveAsDraft => 'Save as Draft';

  @override
  String get newsCreated => 'News created';

  @override
  String get newsUpdated => 'News updated';

  @override
  String get newsDeleted => 'News deleted';

  @override
  String get confirmDeleteNews =>
      'Do you really want to delete this news item?';

  @override
  String confirmDeleteNewsWithTitle(String title) {
    return 'Do you really want to delete \"$title\"?';
  }

  @override
  String get deleteExpired => 'Delete expired';

  @override
  String get deleteExpiredNews => 'Delete expired news';

  @override
  String get confirmDeleteExpiredNews =>
      'Do you want to delete all expired news?';

  @override
  String expiredNewsDeleted(int count) {
    return '$count expired news deleted';
  }

  @override
  String get newsStatusExpired => 'Expired';

  @override
  String createdLabel(String date) {
    return 'Created: $date';
  }

  @override
  String expiresLabel(String date) {
    return 'Expires: $date';
  }

  @override
  String get markdownSupported => 'Markdown is supported';

  @override
  String get lifetimeDays => 'Lifetime (days)';

  @override
  String get defaultLifetimeDays => 'Default: 14 days';

  @override
  String get expiryDate => 'Expiry date';

  @override
  String get noExpiryDate => 'No expiry date';

  @override
  String get publishNewsMessage => 'News will be displayed on the dashboard';

  @override
  String get titleContentRequired => 'Title and content must not be empty';

  @override
  String get createFirstNews => 'Create the first news with the + button.';

  @override
  String errorDeleting(String error) {
    return 'Error deleting: $error';
  }

  @override
  String get categoryManagementScreen => 'Category Management';

  @override
  String get categories => 'Categories';

  @override
  String get subcategories => 'Subcategories';

  @override
  String get createCategory => 'Create Category';

  @override
  String get createSubcategory => 'Create Subcategory';

  @override
  String get noCategories => 'No Categories';

  @override
  String get noCategoriesMessage => 'No categories have been created yet.';

  @override
  String get noSubcategories => 'No Subcategories';

  @override
  String get noSubcategoriesMessage =>
      'No subcategories have been created yet.';

  @override
  String get categoryName => 'Name';

  @override
  String get categoryDescription => 'Description';

  @override
  String get parentCategory => 'Parent Category';

  @override
  String get listingsCount => 'Listings';

  @override
  String get editCategory => 'Edit Category';

  @override
  String get deleteCategory => 'Delete Category';

  @override
  String get createCategoryDialog => 'Create Category';

  @override
  String get editCategoryDialog => 'Edit Category';

  @override
  String get enterCategoryName => 'Enter category name';

  @override
  String get enterCategoryDescription => 'Enter description (optional)';

  @override
  String get categoryNameRequired => 'Name is required';

  @override
  String get categoryCreated => 'Category created';

  @override
  String get categoryUpdated => 'Category updated';

  @override
  String get categoryDeleted => 'Category deleted';

  @override
  String get confirmDeleteCategory =>
      'Do you really want to delete this category? All associated subcategories will also be deleted.';

  @override
  String confirmDeleteCategoryWithName(String name) {
    return 'Do you really want to delete \"$name\"?';
  }

  @override
  String get newCategory => 'New category';

  @override
  String get addSubcategory => 'Add subcategory';

  @override
  String get createFirstCategory =>
      'Create the first category with the + button.';

  @override
  String subcategoriesCount(int count, int sortOrder) {
    return '$count Subcategories • Sorting: $sortOrder';
  }

  @override
  String get sorting => 'Sorting';

  @override
  String sortingLabel(int sortOrder) {
    return 'Sorting: $sortOrder';
  }

  @override
  String get sortingHint => '0';

  @override
  String get categoryShownToUsers => 'Category is shown to users';

  @override
  String categoryHasSubcategories(int count) {
    return 'This category has $count subcategories that will also be deleted!';
  }

  @override
  String get nameRequired => 'Name must not be empty';

  @override
  String get paymentSettingsScreen => 'Payment Settings';

  @override
  String get paymentMethods => 'Payment Methods';

  @override
  String get fees => 'Fees';

  @override
  String get paypalEnabled => 'PayPal Enabled';

  @override
  String get bitcoinEnabled => 'Bitcoin Enabled';

  @override
  String get transactionFee => 'Transaction Fee';

  @override
  String get platformFee => 'Platform Fee';

  @override
  String get feePercentage => 'Percentage';

  @override
  String get minimumFee => 'Minimum Fee';

  @override
  String get maximumFee => 'Maximum Fee';

  @override
  String get settingsSaved => 'Settings saved';

  @override
  String get saveSettings => 'Save settings';

  @override
  String get paymentSettingsInfo =>
      'These settings determine how users can pay for slots.';

  @override
  String get enablePaypal => 'Enable PayPal';

  @override
  String get paypalPaymentDescription => 'Users can pay with PayPal';

  @override
  String get paypalEmailAddress => 'PayPal email address';

  @override
  String get paypalEmailHint => 'payments@example.com';

  @override
  String get enableBitcoin => 'Enable Bitcoin';

  @override
  String get bitcoinPaymentDescription => 'Users can pay with Bitcoin';

  @override
  String get bitcoinWalletAddress => 'Bitcoin wallet address';

  @override
  String get bitcoinWalletHint => 'bc1q...';

  @override
  String get pendingPaymentsScreen => 'Pending Payments';

  @override
  String get allPendingPayments => 'All';

  @override
  String get paypalPayments => 'PayPal';

  @override
  String get bitcoinPayments => 'Bitcoin';

  @override
  String get noPendingPayments => 'No Pending Payments';

  @override
  String get noPendingPaymentsMessage =>
      'There are currently no pending payments to process.';

  @override
  String get paymentId => 'Payment ID';

  @override
  String get amount => 'Amount';

  @override
  String get requestedAt => 'Requested at';

  @override
  String get paymentStatus => 'Status';

  @override
  String get paymentStatusPending => 'Pending';

  @override
  String get paymentStatusProcessing => 'Processing';

  @override
  String get paymentStatusCompleted => 'Completed';

  @override
  String get paymentStatusFailed => 'Failed';

  @override
  String get processPayment => 'Process Payment';

  @override
  String get checkBitcoinPayments => 'Check Bitcoin payments';

  @override
  String get expireOldOrders => 'Expire old orders';

  @override
  String get confirmPaymentTitle => 'Confirm payment';

  @override
  String confirmPaymentMessage(int orderId, String amount, String method) {
    return 'Do you really want to confirm the payment for order #$orderId?\n\nAmount: $amount\nMethod: $method';
  }

  @override
  String get paymentConfirmedSlotActivated =>
      'Payment confirmed and slot activated';

  @override
  String bitcoinPaymentsProcessed(int count) {
    return '$count Bitcoin payments processed';
  }

  @override
  String get expireOldOrdersTitle => 'Expire old orders';

  @override
  String get expireOldOrdersMessage =>
      'Do you want to mark all pending orders older than 24 hours as expired?';

  @override
  String get expireAction => 'Expire';

  @override
  String ordersExpired(int count) {
    return '$count orders marked as expired';
  }

  @override
  String get allPaymentsProcessed => 'All payments have been processed';

  @override
  String get sell => 'Sell';

  @override
  String myListings(Object count) {
    return 'My Listings ($count)';
  }

  @override
  String mySlots(Object count) {
    return 'My Slots ($count)';
  }

  @override
  String get newListing => 'New Listing';

  @override
  String get noAvailableSlots => 'No available slots';

  @override
  String get noSlotsMessage =>
      'You don\'t have any slots to create a listing. Buy slots first.';

  @override
  String get showSlots => 'Show Slots';

  @override
  String get noListings => 'No listings';

  @override
  String get createFirstListing => 'Create first listing';

  @override
  String get buySlots => 'Buy Slots';

  @override
  String get available => 'Available';

  @override
  String get used => 'Used';

  @override
  String get expired => 'Expired';

  @override
  String get pendingOrders => 'Pending Orders';

  @override
  String orderNumber(Object id) {
    return 'Order #$id';
  }

  @override
  String get paypalWaitingForPayment => 'PayPal - Waiting for payment';

  @override
  String get bitcoinWaitingForConfirmation =>
      'Bitcoin - Waiting for confirmation';

  @override
  String get enterTxId => 'Enter Transaction ID';

  @override
  String get pay => 'Pay';

  @override
  String get cancelOrder => 'Cancel Order';

  @override
  String cancelOrderConfirm(Object id) {
    return 'Do you really want to cancel order #$id?';
  }

  @override
  String get orderCanceled => 'Order canceled';

  @override
  String get bitcoinTransactionId => 'Bitcoin Transaction ID';

  @override
  String get txIdLabel => 'Transaction ID';

  @override
  String get txIdPlaceholder => 'Enter the transaction ID here';

  @override
  String get txIdSaved => 'Transaction ID saved';

  @override
  String get paypalPayment => 'PayPal Payment';

  @override
  String get bitcoinPayment => 'Bitcoin Payment';

  @override
  String get reference => 'Reference';

  @override
  String get address => 'Address';

  @override
  String get activeSlots => 'Active Slots';

  @override
  String get noActiveSlots => 'You don\'t have any active slots.';

  @override
  String get slotUsed => 'Slot used';

  @override
  String get slotAvailable => 'Slot available';

  @override
  String expiresOn(Object date) {
    return 'Expires on: $date';
  }

  @override
  String get free => 'FREE';

  @override
  String daysRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'days',
      one: 'day',
    );
    return '$count $_temp0';
  }

  @override
  String get extend => 'Extend';

  @override
  String get noSlotVariantsAvailable => 'No slot variants available';

  @override
  String get adminMustConfigureSlots =>
      'The administrator must configure slot variants first.';

  @override
  String daysValidity(Object count) {
    return '$count days validity';
  }

  @override
  String get activateSlot => 'Activate Slot';

  @override
  String get noPaymentMethod => 'No payment method available';

  @override
  String get amountUsd => 'Amount (USD)';

  @override
  String get amountBtc => 'Amount (BTC)';

  @override
  String get memo => 'Memo';

  @override
  String get extendSlot => 'Extend Slot';

  @override
  String error(Object error) {
    return 'Error: $error';
  }

  @override
  String get bitcoinAddress => 'Bitcoin Address';

  @override
  String get referenceLabel => 'Reference';

  @override
  String errorLoadingPaymentInfo(Object error) {
    return 'Error loading payment information: $error';
  }

  @override
  String get buySlot => 'Buy Slot';

  @override
  String get buy => 'Buy';

  @override
  String removedFromFavorites(Object title) {
    return '$title has been removed from favorites';
  }

  @override
  String get undo => 'Undo';

  @override
  String get retryButton => 'Retry';

  @override
  String get noFavorites => 'No Favorites';

  @override
  String get noFavoritesDescription =>
      'You haven\'t saved any favorites yet. Tap the heart icon on listings you like.';

  @override
  String get removeFavoriteTitle => 'Remove Favorite';

  @override
  String removeFavoriteConfirm(Object title) {
    return 'Do you really want to remove \"$title\" from your favorites?';
  }

  @override
  String get remove => 'Remove';

  @override
  String get monthJan => 'Jan';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Apr';

  @override
  String get monthMay => 'May';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Aug';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dec';

  @override
  String get quantityUnitPiece => 'piece';

  @override
  String get quantityUnitKg => 'kg';

  @override
  String get quantityUnitGram => 'g';

  @override
  String get quantityUnitMeter => 'm';

  @override
  String get quantityUnitLiter => 'l';

  @override
  String get startTransaction => 'Start Transaction';

  @override
  String get quantityLabel => 'Quantity';

  @override
  String get enterQuantity => 'Enter quantity';

  @override
  String ofAvailable(Object available) {
    return 'of $available available';
  }

  @override
  String get noteForSeller => 'Note for seller';

  @override
  String get noteForSellerHint => 'Optional: Add a message for the seller';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get total => 'Total';

  @override
  String paymentVia(Object method) {
    return 'Payment via $method';
  }

  @override
  String get paymentMethodPaypalOrBitcoin => 'PayPal or Bitcoin';

  @override
  String get paymentMethodPaypal => 'PayPal';

  @override
  String get paymentMethodBitcoin => 'Bitcoin';

  @override
  String get enterValidQuantity => 'Please enter a valid quantity';

  @override
  String get quantityExceedsAvailable => 'Quantity exceeds available amount';

  @override
  String get rateTransaction => 'Rate Transaction';

  @override
  String get howWasYourExperience => 'How was your experience?';

  @override
  String get ratingGood => 'Good';

  @override
  String get ratingNeutral => 'Neutral';

  @override
  String get ratingBad => 'Bad';

  @override
  String get commentOptional => 'Comment (optional)';

  @override
  String get ratingCommentHint => 'Share your experience with other users';

  @override
  String get submitRating => 'Submit Rating';

  @override
  String get ratingSubmittedSuccessfully => 'Rating submitted successfully';

  @override
  String get warning => 'Warning';

  @override
  String confirmRoleChange(Object role) {
    return 'Do you really want to change the role to \"$role\"?';
  }

  @override
  String get roleUpdated => 'Role updated';

  @override
  String get noFreeSlotVariantsAvailable => 'No free slot variants available';

  @override
  String get grantFreeSlot => 'Grant Free Slot';

  @override
  String selectFreeSlotVariant(Object username) {
    return 'Select a slot variant for $username';
  }

  @override
  String daysRuntime(Object days) {
    return '$days days runtime';
  }

  @override
  String get freeUppercase => 'FREE';

  @override
  String freeSlotGranted(Object username, Object variantName) {
    return '$variantName has been granted to $username';
  }

  @override
  String get unbanUser => 'Unban User';

  @override
  String get confirmUnban => 'Do you really want to unban this user?';

  @override
  String get unbanReason => 'Reason for unbanning';

  @override
  String get userUnbanned => 'User has been unbanned';

  @override
  String get information => 'Information';

  @override
  String get lastLogin => 'Last Login';

  @override
  String get never => 'Never';

  @override
  String get status => 'Status';

  @override
  String get bannedSince => 'Banned since';

  @override
  String get banReasonLabel => 'Reason';

  @override
  String get role => 'Role';

  @override
  String get cannotChangeOwnRole => 'You cannot change your own role';

  @override
  String get banHistory => 'Ban History';

  @override
  String get bannedAction => 'Banned';

  @override
  String get unbannedAction => 'Unbanned';

  @override
  String get roleDescriptionAdmin => 'Full access';

  @override
  String get roleDescriptionModerator => 'Moderation rights';

  @override
  String get roleDescriptionUser => 'Normal user rights';

  @override
  String get errorLoadingRatings => 'Error loading ratings';

  @override
  String get noRatingsYet => 'No ratings yet';

  @override
  String get noRatingsDescription =>
      'This user has not received any ratings yet';

  @override
  String get positive => 'Positive';

  @override
  String showAllRatings(Object count) {
    return 'Show all $count ratings';
  }

  @override
  String get loadMore => 'Load more';

  @override
  String get auto => 'Auto';

  @override
  String get banReasonFraud => 'Fraud';

  @override
  String get banReasonInappropriate => 'Inappropriate content';

  @override
  String get banReasonTosViolation => 'Terms of Service violation';

  @override
  String get banReasonMultipleAccounts => 'Multiple accounts';

  @override
  String get banReasonIllegal => 'Illegal activities';

  @override
  String get banReasonRequired => 'Please provide a reason';

  @override
  String get enterBanReason => 'Enter ban reason';

  @override
  String get presetReasons => 'Preset reasons';

  @override
  String get reasonRequired => 'Reason (required)';

  @override
  String get describeBanReason => 'Describe the reason for the ban';

  @override
  String get banWarning =>
      'This user will be immediately blocked and won\'t be able to log in.';

  @override
  String get banAction => 'Ban User';

  @override
  String get activeSlotVariants => 'Active';

  @override
  String get activeUsers => 'Active';

  @override
  String get activeVariantDescription => 'Variant can be purchased';

  @override
  String get addInternalNotes => 'Add internal notes...';

  @override
  String get administration => 'Administration';

  @override
  String get allUsers => 'All Users';

  @override
  String get assignToMe => 'Assign to Me';

  @override
  String get assigned => 'Assigned';

  @override
  String assignedToModerator(Object id) {
    return 'Assigned to moderator #$id';
  }

  @override
  String get atLeastOnePaymentMethodRequired =>
      'Au moins une méthode de paiement doit être activée';

  @override
  String get banned => 'BANNED';

  @override
  String get bannedUsers => 'Banned';

  @override
  String get bitcoinAddressCopied => 'Adresse Bitcoin copiée !';

  @override
  String get bitcoinInstructions =>
      'Please send the BTC amount to the provided address and include the reference in the transaction comment';

  @override
  String get bitcoinInstructionsDetailed =>
      'Scan the QR code or send the BTC amount to the provided address and include the reference in the transaction comment. After the transaction is confirmed, the slot will be activated automatically.';

  @override
  String get configureSlotTypes => 'Configurer les types et prix de slots';

  @override
  String get confirmDeleteSlotVariant =>
      'Do you really want to delete this slot variant?';

  @override
  String confirmDeleteSlotVariantWithName(Object name) {
    return 'Do you really want to delete \"$name\"?';
  }

  @override
  String get confirmUnbanUser => 'Do you really want to unban this user?';

  @override
  String get createCategoriesSubcategories =>
      'Créer des catégories et sous-catégories';

  @override
  String get createFirstSlotVariant =>
      'Create the first slot variant with the + button.';

  @override
  String get createSlotVariant => 'Create Slot Variant';

  @override
  String get createSlotVariantDialog => 'Create Slot Variant';

  @override
  String get currency => 'Currency';

  @override
  String daysAgo(Object days) {
    return '${days}d ago';
  }

  @override
  String get deactivate => 'Deactivate';

  @override
  String get deactivateListing => 'Deactivate Listing';

  @override
  String get deactivateListingConfirm =>
      'Do you really want to deactivate this listing? This action cannot be undone.';

  @override
  String get deleteSlotVariant => 'Delete Slot Variant';

  @override
  String get descriptionOptional => 'Description (optional)';

  @override
  String get donateBitcoin => 'Faire un Don Bitcoin';

  @override
  String get donateCoffee => 'Buy Me a Coffee';

  @override
  String get donateDescription =>
      'Si vous aimez cette application, vous pouvez soutenir son développement avec un don :';

  @override
  String get donateTitle => 'Soutenir le Développement';

  @override
  String get duration => 'Duration';

  @override
  String durationDays(Object days) {
    return '$days days runtime';
  }

  @override
  String durationDaysLabel(Object days) {
    return '$days Days';
  }

  @override
  String get durationRequired => 'Duration (days) required';

  @override
  String get editSlotVariant => 'Edit Slot Variant';

  @override
  String get editSlotVariantDialog => 'Modifier la Variante de Slot';

  @override
  String get encryptionActive => 'Chiffrement actif';

  @override
  String get enterBitcoinTxIdPrompt =>
      'Saisissez l\'ID de transaction Bitcoin (TX-Hash) après avoir envoyé le paiement:';

  @override
  String get enterDuration => 'Durée (jours)';

  @override
  String get enterMaxListings => 'Max. annonces';

  @override
  String get enterPriceBTC => 'Prix en BTC';

  @override
  String get enterPriceUSD => 'Prix en USD';

  @override
  String get enterVariantName => 'Entrer le nom de la variante';

  @override
  String get extendSlotPrompt =>
      'Choisissez une variante de slot pour prolonger votre slot. La durée sera ajoutée à la date d\'expiration actuelle.';

  @override
  String featureInMilestone(Object milestone, Object title) {
    return '$title will be implemented in Milestone $milestone.';
  }

  @override
  String get freeLabel => 'Free';

  @override
  String get freeVariantDescription =>
      'La variante est gratuite (pour les emplacements promotionnels)';

  @override
  String fullDateTimeFormat(
      Object day, Object hour, Object minute, Object month, Object year) {
    return '$day.$month.$year à $hour:$minute';
  }

  @override
  String hoursAgo(Object hours) {
    return '${hours}h ago';
  }

  @override
  String get inactiveSlotVariants => 'Inactive';

  @override
  String get justNow => 'Just now';

  @override
  String get listing => 'Listing';

  @override
  String get listingDeactivated => 'L\'annonce a été désactivée';

  @override
  String listingId(Object id) {
    return 'Annonce #$id';
  }

  @override
  String get listingReports => 'Listing Reports';

  @override
  String listingsWithCount(Object count) {
    return 'Annonces ($count)';
  }

  @override
  String get manageCategories => 'Gérer les catégories';

  @override
  String get manageSlotVariants => 'Manage Slot Variants';

  @override
  String get manageUsersRoles =>
      'Gérer les utilisateurs et attribuer des rôles';

  @override
  String get markAsCompleted => 'Marquer comme Terminé';

  @override
  String get markAsFailed => 'Marquer comme Échoué';

  @override
  String get markAsProcessing => 'Marquer comme En Traitement';

  @override
  String get markAsResolved => 'Marquer comme Résolu';

  @override
  String get maxListings => 'Max. Annonces';

  @override
  String get maxListingsRequired => 'Le max. d\'annonces est requis';

  @override
  String memberSince(Object date) {
    return 'Membre depuis $date';
  }

  @override
  String get method => 'Méthode';

  @override
  String minutesAgo(Object minutes) {
    return '${minutes}m ago';
  }

  @override
  String get moderatorPanelScreen => 'Moderator Panel';

  @override
  String get nameHint => 'Name';

  @override
  String get newSlotVariant => 'New Slot Variant';

  @override
  String get noActiveListings => 'Aucune annonce active';

  @override
  String get noPgpKeyAvailable => 'Aucune clé PGP disponible';

  @override
  String get noRatings => 'Aucune évaluation';

  @override
  String get noReportsDescription =>
      'There are no reports to review at this time.';

  @override
  String get noSlotVariants => 'No Slot Variants';

  @override
  String get noSlotVariantsMessage =>
      'Aucune variante de slot n\'a encore été créée.';

  @override
  String get noUsers => 'Aucun Utilisateur';

  @override
  String get noUsersFound => 'Aucun Utilisateur Trouvé';

  @override
  String get noUsersMessage => 'Aucun utilisateur trouvé.';

  @override
  String get notYetAssigned => 'Pas encore assigné';

  @override
  String get noteCannotBeEmpty => 'La note ne peut pas être vide';

  @override
  String openReportsCount(Object count) {
    return '$count open reports';
  }

  @override
  String order(Object id) {
    return 'Commande #$id';
  }

  @override
  String paymentDetailsTitle(Object number) {
    return 'Détails du paiement #$number';
  }

  @override
  String get paymentMarkedCompleted => 'Paiement marqué comme terminé';

  @override
  String get paymentMarkedFailed => 'Paiement marqué comme échoué';

  @override
  String get paymentMarkedProcessing => 'Paiement marqué comme en traitement';

  @override
  String get payments => 'Paiements';

  @override
  String get paypalBitcoinSlots => 'PayPal et Bitcoin pour l\'achat de slots';

  @override
  String get paypalEmail => 'Email PayPal';

  @override
  String get paypalInstructions =>
      'Veuillez envoyer le montant à l\'adresse PayPal fournie et inclure la référence.';

  @override
  String get paypalInstructionsDetailed =>
      'Veuillez envoyer le montant à l\'adresse PayPal fournie et inclure la référence. Votre slot sera activé automatiquement après réception du paiement.';

  @override
  String get priceBTC => 'Prix (BTC)';

  @override
  String get priceBTCRequired => 'Le prix en BTC est requis';

  @override
  String get priceUSD => 'Prix (USD)';

  @override
  String get priceUSDRequired => 'Le prix en USD est requis';

  @override
  String get priceUsd => 'Prix (USD)';

  @override
  String get profile => 'Profil';

  @override
  String ratingCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count évaluations',
      one: '1 évaluation',
    );
    return '$_temp0';
  }

  @override
  String ratingsWithCount(Object count) {
    return 'Évaluations ($count)';
  }

  @override
  String get report => 'Signaler';

  @override
  String get reportAlreadyReported => 'Vous avez déjà signalé ceci';

  @override
  String get reportAssignedToYou => 'Le signalement vous a été assigné';

  @override
  String get reportDetails => 'Détails du Signalement';

  @override
  String get reportDetailsHint => 'Décrivez le problème...';

  @override
  String get reportDetailsOptional => 'Détails Supplémentaires (facultatif)';

  @override
  String get reportNotFound => 'Signalement non trouvé';

  @override
  String get reportReasonFraud => 'Fraud';

  @override
  String get reportReasonLabel => 'Raison du signalement :';

  @override
  String get reportSelectReason => 'Veuillez sélectionner une raison';

  @override
  String get reportStatusDismissed => 'Dismissed';

  @override
  String get reportStatusOpen => 'Open';

  @override
  String get reportStatusResolved => 'Resolved';

  @override
  String get reportStatusReviewing => 'Reviewing';

  @override
  String get reportSubmitError => 'Erreur lors de l\'envoi du signalement';

  @override
  String get reportSubmittedSuccessfully => 'Signalement soumis avec succès';

  @override
  String get reportTargetListing => 'Annonce';

  @override
  String get reportTargetNotFound => 'Entrée non trouvée';

  @override
  String get reportTargetUser => 'Utilisateur';

  @override
  String reportTitle(Object targetType) {
    return 'Signaler $targetType';
  }

  @override
  String get reportUser => 'Signaler l\'Utilisateur';

  @override
  String reportYouAreReporting(Object targetName) {
    return 'Vous signalez : \"$targetName\"';
  }

  @override
  String get reportedOn => 'Signalé le';

  @override
  String get reportedUserProfile => 'Profil Utilisateur Signalé';

  @override
  String reporterUser(Object id) {
    return 'Utilisateur #$id';
  }

  @override
  String get reviewPendingOrders =>
      'Examiner et confirmer les commandes en attente';

  @override
  String get searchUsers => 'Rechercher des utilisateurs...';

  @override
  String get sectionDonate => 'Soutenir le Développeur';

  @override
  String get sendMessage => 'Envoyer un Message';

  @override
  String get slotVariantCreated => 'Variante de slot créée';

  @override
  String get slotVariantDeleted => 'Variante de slot supprimée';

  @override
  String get slotVariantUpdated => 'Variante de slot mise à jour';

  @override
  String get slotVariantsScreen => 'Variantes de Slot';

  @override
  String get slots => 'Slots';

  @override
  String get staff => 'Personnel';

  @override
  String get statusUpdated => 'Le statut a été mis à jour';

  @override
  String get systemUserManagement => 'Gestion du système et des utilisateurs';

  @override
  String get txId => 'TX-ID';

  @override
  String get unban => 'Débannir';

  @override
  String get unknown => 'Inconnu';

  @override
  String get user => 'User';

  @override
  String get userManagementScreen => 'Gestion des Utilisateurs';

  @override
  String get userNotFound => 'Utilisateur non trouvé';

  @override
  String get userReports => 'User Reports';

  @override
  String get users => 'Utilisateurs';

  @override
  String get variant => 'Variante';

  @override
  String get variantName => 'Nom';

  @override
  String get variantNameRequired => 'Le nom est requis';

  @override
  String get variantStatus => 'Statut';

  @override
  String get viewUser => 'Voir l\'Utilisateur';

  @override
  String get listings => 'Listings';
}
