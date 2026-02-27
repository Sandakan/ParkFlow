// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'ParkFlow';

  @override
  String get loginTitle => 'ParkFlow';

  @override
  String get welcomeBackSubtitle => 'Welcome back! Sign in to your account.';

  @override
  String get signInToContinue => 'Sign in to continue';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get loginButton => 'Login';

  @override
  String get signInButton => 'Sign In';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get signUp => 'Sign up';

  @override
  String get createAccountTitle => 'Create Account';

  @override
  String get signUpSubtitle => 'Sign up to get started!';

  @override
  String get fullNameLabel => 'Full Name';

  @override
  String get fullNameHint => 'John Doe';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get confirmPasswordRequired => 'Confirm Password is required';

  @override
  String get passwordsMustMatch => 'Passwords must match';

  @override
  String get signUpButton => 'Sign Up';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get signIn => 'Sign in';

  @override
  String get liveDashboard => 'ParkFlow Live Dashboard';

  @override
  String get liveFeed => 'Live Feed';

  @override
  String get occupied => 'Occupied';

  @override
  String get available => 'Available';

  @override
  String get logoutTooltip => 'Logout';

  @override
  String get checkInternetConnection =>
      'Please check your internet connection and try again.';

  @override
  String get somethingWrongDescription =>
      'Something went wrong. Please try again later.';

  @override
  String get authTokenExpiredError =>
      'Your session has expired. Please log in again.';

  @override
  String get sessionExpired => 'Session expired';

  @override
  String get invalidPageNumber => 'Invalid page number';

  @override
  String get currentPasswordInvalid => 'Current password is not valid';

  @override
  String get changePasswordFailed => 'Failed to change password';

  @override
  String get emailRequired => 'The email must not be empty';

  @override
  String get emailInvalid => 'The email value must be a valid email';

  @override
  String get passwordRequired => 'The password must not be empty';

  @override
  String get passwordMinLength =>
      'The password must be at least 6 characters long';

  @override
  String get invalidCredentials =>
      'The email or password you entered is incorrect';
}
