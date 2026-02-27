import 'package:parkflow/l10n/app_localizations.dart';
import 'package:parkflow/utils/constants/enums/app_status_code.dart';

class AppException implements Exception {
  final AppStatusCode code;
  final Object? cause;
  final StackTrace? stackTrace;

  const AppException(this.code, {this.cause, this.stackTrace});

  String toLocalizedString(AppLocalizations l10n) =>
      code.toLocalizedString(l10n);

  @override
  String toString() => 'AppException(code: $code, cause: $cause)';

  static String getLocalizedErrorMessage(Object? e, AppLocalizations l10n) {
    if (e is AppException) return e.toLocalizedString(l10n);
    return AppStatusCode.unknownError.toLocalizedString(l10n);
  }
}
