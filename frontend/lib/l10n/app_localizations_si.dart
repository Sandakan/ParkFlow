// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Sinhala Sinhalese (`si`).
class AppLocalizationsSi extends AppLocalizations {
  AppLocalizationsSi([String locale = 'si']) : super(locale);

  @override
  String get appTitle => 'ParkFlow';

  @override
  String get loginTitle => 'ParkFlow';

  @override
  String get signInToContinue => 'ඉදිරියට යාමට පුරන්න';

  @override
  String get emailLabel => 'විද්‍යුත් තැපෑල';

  @override
  String get passwordLabel => 'මුරපදය';

  @override
  String get loginButton => 'පුරන්න';

  @override
  String get liveDashboard => 'ParkFlow සජීවී ඩෑෂ්බෝර්ඩ්';

  @override
  String get liveFeed => 'සජීවී දර්ශනය';

  @override
  String get occupied => 'පිරී ඇත';

  @override
  String get available => 'හිස්ව ඇත';

  @override
  String get checkInternetConnection =>
      'කරුණාකර ඔබේ අන්තර්ජාල සම්බන්ධතාවය පරීක්ෂා කර නැවත උත්සාහ කරන්න.';

  @override
  String get somethingWrongDescription =>
      'යමක් වැරදී ඇත. කරුණාකර පසුව නැවත උත්සාහ කරන්න.';

  @override
  String get authTokenExpiredError =>
      'ඔබේ සැසිය කල් ඉකුත් වී ඇත. කරුණාකර නැවත පුරන්න.';

  @override
  String get sessionExpired => 'සැසිය කල් ඉකුත් වී ඇත';

  @override
  String get invalidPageNumber => 'අවලංගු පිටු අංකයක්';

  @override
  String get currentPasswordInvalid => 'වත්මන් මුරපදය වලංගු නැත';

  @override
  String get changePasswordFailed => 'මුරපදය වෙනස් කිරීම අසාර්ථක විය';

  @override
  String get emailRequired => 'විද්‍යුත් තැපෑල හිස් නොවිය යුතුය';

  @override
  String get emailInvalid =>
      'විද්‍යුත් තැපෑල වලංගු විද්‍යුත් තැපෑලක් විය යුතුය';

  @override
  String get passwordRequired => 'මුරපදය හිස් නොවිය යුතුය';

  @override
  String get passwordMinLength => 'මුරපදය අවම වශයෙන් අක්ෂර 6ක් දිග විය යුතුය';
}
