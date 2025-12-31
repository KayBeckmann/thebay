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
}
