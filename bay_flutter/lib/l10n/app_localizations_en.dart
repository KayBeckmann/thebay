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
  String get roleAdmin => 'Administrator';

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
  String get noListingsMessage => 'Recent listings will be displayed here.';

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
  String get pricePerUnit => 'Price per unit';

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
  String get deleteListingConfirm =>
      'Do you really want to delete this listing?';

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
  String get created => 'Created';

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
}
