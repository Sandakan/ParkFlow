import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_si.dart';
import 'app_localizations_ta.dart';

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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('en'),
    Locale('si'),
    Locale('ta'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'ParkFlow'**
  String get appTitle;

  /// The title displayed on the login screen
  ///
  /// In en, this message translates to:
  /// **'ParkFlow'**
  String get loginTitle;

  /// The subtitle displayed on the login screen
  ///
  /// In en, this message translates to:
  /// **'Welcome back! Sign in to your account.'**
  String get welcomeBackSubtitle;

  /// The subtitle displayed on the login screen
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get signInToContinue;

  /// The label for the email input field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// The label for the password input field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// Forgot password button text
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// The text for the login button
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// The text for the sign in button
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButton;

  /// Text asking if the user doesn't have an account
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// Sign up link text
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// Title for the registration screen
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccountTitle;

  /// Subtitle for the registration screen
  ///
  /// In en, this message translates to:
  /// **'Sign up to get started!'**
  String get signUpSubtitle;

  /// Label for the full name input field
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullNameLabel;

  /// Hint text for the full name input field
  ///
  /// In en, this message translates to:
  /// **'John Doe'**
  String get fullNameHint;

  /// Validation message when name is empty
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// Label for the confirm password input field
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// Validation message when confirm password is empty
  ///
  /// In en, this message translates to:
  /// **'Confirm Password is required'**
  String get confirmPasswordRequired;

  /// Validation message when passwords do not match
  ///
  /// In en, this message translates to:
  /// **'Passwords must match'**
  String get passwordsMustMatch;

  /// Text for the sign up button
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpButton;

  /// Text asking if the user already has an account
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// Sign in link text
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// The title for the live dashboard page
  ///
  /// In en, this message translates to:
  /// **'ParkFlow Live Dashboard'**
  String get liveDashboard;

  /// The title for the live video feed section
  ///
  /// In en, this message translates to:
  /// **'Live Feed'**
  String get liveFeed;

  /// Label indicating a parking slot is occupied
  ///
  /// In en, this message translates to:
  /// **'Occupied'**
  String get occupied;

  /// Label indicating a parking slot is available
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// Tooltip for the logout button
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutTooltip;

  /// Error message when there is no internet connection
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection and try again.'**
  String get checkInternetConnection;

  /// Generic error message for unknown errors
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again later.'**
  String get somethingWrongDescription;

  /// Error message when the authentication token has expired
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please log in again.'**
  String get authTokenExpiredError;

  /// Title or short description for session expired error
  ///
  /// In en, this message translates to:
  /// **'Session expired'**
  String get sessionExpired;

  /// Error message for invalid page number
  ///
  /// In en, this message translates to:
  /// **'Invalid page number'**
  String get invalidPageNumber;

  /// Error message for invalid current password
  ///
  /// In en, this message translates to:
  /// **'Current password is not valid'**
  String get currentPasswordInvalid;

  /// Error message when changing password fails
  ///
  /// In en, this message translates to:
  /// **'Failed to change password'**
  String get changePasswordFailed;

  /// Validation message when email is empty
  ///
  /// In en, this message translates to:
  /// **'The email must not be empty'**
  String get emailRequired;

  /// Validation message when email format is invalid
  ///
  /// In en, this message translates to:
  /// **'The email value must be a valid email'**
  String get emailInvalid;

  /// Validation message when password is empty
  ///
  /// In en, this message translates to:
  /// **'The password must not be empty'**
  String get passwordRequired;

  /// Validation message when password is too short
  ///
  /// In en, this message translates to:
  /// **'The password must be at least 6 characters long'**
  String get passwordMinLength;

  /// Error message for invalid login credentials
  ///
  /// In en, this message translates to:
  /// **'The email or password you entered is incorrect'**
  String get invalidCredentials;

  /// Title for the admin dashboard screen
  ///
  /// In en, this message translates to:
  /// **'Admin Dashboard'**
  String get adminDashboard;

  /// Welcome message for admin users
  ///
  /// In en, this message translates to:
  /// **'Welcome, Administrator'**
  String get adminWelcome;
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
      <String>['en', 'si', 'ta'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'si':
      return AppLocalizationsSi();
    case 'ta':
      return AppLocalizationsTa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
