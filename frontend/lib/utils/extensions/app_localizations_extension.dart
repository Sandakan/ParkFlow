import 'package:flutter/widgets.dart';
import 'package:parkflow/l10n/app_localizations.dart';
import 'package:parkflow/utils/constants/enums/language.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension AppLocalizationsExtension on AppLocalizations {
  LanguageEnum get languageEnum {
    switch (localeName) {
      case 'en':
        return LanguageEnum.en;
      case 'si':
        return LanguageEnum.si;
      case 'ta':
        return LanguageEnum.ta;
      default:
        return LanguageEnum.en;
    }
  }
}
