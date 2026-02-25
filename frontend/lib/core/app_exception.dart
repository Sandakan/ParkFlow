import 'package:parkflow/l10n/app_localizations.dart';
import 'package:parkflow/utils/constants/enums/app_error_code.dart';

class AppException implements Exception {
  final AppErrorCode code;
  final Object? cause;
  final StackTrace? stackTrace;

  const AppException(this.code, {this.cause, this.stackTrace});

  String toLocalizedString(AppLocalizations l10n) =>
      code.toLocalizedString(l10n);

  @override
  String toString() => 'AppException(code: $code, cause: $cause)';

  static String getLocalizedErrorMessage(Object? e, AppLocalizations l10n) {
    if (e is AppException) return e.toLocalizedString(l10n);
    return AppErrorCode.unknownError.toLocalizedString(l10n);
  }
}
