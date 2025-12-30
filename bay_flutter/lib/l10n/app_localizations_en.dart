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
}
