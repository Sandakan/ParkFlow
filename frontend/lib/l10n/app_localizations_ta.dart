// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appTitle => 'பார்க்ஃப்ளோ';

  @override
  String get loginTitle => 'பார்க்ஃப்ளோ';

  @override
  String get signInToContinue => 'தொடர உள்நுழையவும்';

  @override
  String get emailLabel => 'மின்னஞ்சல்';

  @override
  String get passwordLabel => 'கடவுச்சொல்';

  @override
  String get loginButton => 'உள்நுழை';

  @override
  String get liveDashboard => 'பார்க்ஃப்ளோ நேரடி டாஷ்போர்டு';

  @override
  String get liveFeed => 'நேரடி காணொளி';

  @override
  String get occupied => 'நிரம்பியுள்ளது';

  @override
  String get available => 'காலியாக உள்ளது';

  @override
  String get checkInternetConnection =>
      'உங்கள் இணைய இணைப்பை சரிபார்த்து மீண்டும் முயற்சிக்கவும்.';

  @override
  String get somethingWrongDescription =>
      'ஏதோ தவறு நடந்துள்ளது. சிறிது நேரம் கழித்து மீண்டும் முயற்சிக்கவும்.';

  @override
  String get authTokenExpiredError =>
      'உங்கள் அமர்வு காலாவதியானது. மீண்டும் உள்நுழையவும்.';

  @override
  String get sessionExpired => 'அமர்வு காலாவதியானது';

  @override
  String get invalidPageNumber => 'தவறான பக்க எண்';

  @override
  String get currentPasswordInvalid => 'தற்போதைய கடவுச்சொல் செல்லுபடியாகாது';

  @override
  String get changePasswordFailed => 'கடவுச்சொல்லை மாற்றுவது தோல்வியடைந்தது';

  @override
  String get emailRequired => 'மின்னஞ்சல் காலியாக இருக்கக்கூடாது';

  @override
  String get emailInvalid =>
      'மின்னஞ்சல் செல்லுபடியாகும் மின்னஞ்சலாக இருக்க வேண்டும்';

  @override
  String get passwordRequired => 'கடவுச்சொல் காலியாக இருக்கக்கூடாது';

  @override
  String get passwordMinLength =>
      'கடவுச்சொல் குறைந்தது 6 எழுத்துகள் நீளமாக இருக்க வேண்டும்';
}
