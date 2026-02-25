import 'package:parkflow/l10n/app_localizations.dart';

enum AppErrorCode {
  noInternetConnection('NO_INTERNET_CONNECTION'),
  networkError('NETWORK_ERROR'),
  unknownError('UNKNOWN_ERROR'),
  // Add new error codes
  invalidResponse('INVALID_RESPONSE'),
  invalidPageNumber('INVALID_PAGE_NUMBER'),
  serverError('SERVER_ERROR'),
  // Authentication related error codes
  authTokenExpired('AUTH_TOKEN_EXPIRED'),
  missingInitialRefreshTokenInSetCookieHeader(
    'MISSING_INITIAL_REFRESH_TOKEN_IN_SET_COOKIE_HEADER',
  ),
  sessionExpired('SESSION_EXPIRED'),
  currentPasswordInvalid('CURRENT_PASSWORD_INVALID'),
  changePasswordFailed('CHANGE_PASSWORD_FAILED'),
  // Messages related error codes
  messageArchiveFailed('MESSAGE_ARCHIVE_FAILED'),
  messageMarkAsReadFailed('MESSAGE_MARK_AS_READ_FAILED');

  final String backendCode;
  const AppErrorCode(this.backendCode);

  static AppErrorCode fromBackendCode(String code) {
    return AppErrorCode.values.firstWhere(
      (e) => e.backendCode == code,
      orElse: () => AppErrorCode.unknownError,
    );
  }

  String toLocalizedString(AppLocalizations l10n) {
    switch (this) {
      case AppErrorCode.noInternetConnection:
        return l10n.checkInternetConnection;
      case AppErrorCode.networkError:
        return l10n.checkInternetConnection;
      case AppErrorCode.serverError:
        return l10n.somethingWrongDescription;
      case AppErrorCode.authTokenExpired:
        return l10n.authTokenExpiredError;
      case AppErrorCode.sessionExpired:
        return l10n.sessionExpired;
      case AppErrorCode.invalidPageNumber:
        return l10n.invalidPageNumber;
      case AppErrorCode.currentPasswordInvalid:
        return l10n.currentPasswordInvalid;
      case AppErrorCode.changePasswordFailed:
        return l10n.changePasswordFailed;
      default:
        return l10n.somethingWrongDescription;
    }
  }
}
