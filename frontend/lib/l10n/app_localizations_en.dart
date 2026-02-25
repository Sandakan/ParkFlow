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
  String get signInToContinue => 'Sign in to continue';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get loginButton => 'Login';

  @override
  String get liveDashboard => 'ParkFlow Live Dashboard';

  @override
  String get liveFeed => 'Live Feed';

  @override
  String get occupied => 'Occupied';

  @override
  String get available => 'Available';

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
}
