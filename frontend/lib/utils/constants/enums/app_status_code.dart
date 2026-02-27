import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parkflow/l10n/app_localizations.dart';

part 'app_status_code.g.dart';

@JsonEnum(alwaysCreate: true)
enum AppStatusCode {
  @JsonValue('SUCCESS')
  success,
  @JsonValue('NO_INTERNET_CONNECTION')
  noInternetConnection,
  @JsonValue('NETWORK_ERROR')
  networkError,
  @JsonValue('UNKNOWN_ERROR')
  unknownError,
  // Add new error codes
  @JsonValue('INVALID_RESPONSE')
  invalidResponse,
  @JsonValue('INVALID_PAGE_NUMBER')
  invalidPageNumber,
  @JsonValue('SERVER_ERROR')
  serverError,
  // Authentication related error codes
  @JsonValue('AUTH_TOKEN_EXPIRED')
  authTokenExpired,
  @JsonValue('INVALID_CREDENTIALS')
  invalidCredentials,
  @JsonValue('SESSION_EXPIRED')
  sessionExpired,
  @JsonValue('CURRENT_PASSWORD_INVALID')
  currentPasswordInvalid,
  @JsonValue('CHANGE_PASSWORD_FAILED')
  changePasswordFailed,
  // Messages related error codes
  @JsonValue('MESSAGE_ARCHIVE_FAILED')
  messageArchiveFailed,
  @JsonValue('MESSAGE_MARK_AS_READ_FAILED')
  messageMarkAsReadFailed;

  String toLocalizedString(AppLocalizations l10n) {
    switch (this) {
      case AppStatusCode.success:
        return 'Success';
      case AppStatusCode.noInternetConnection:
        return l10n.checkInternetConnection;
      case AppStatusCode.networkError:
        return l10n.checkInternetConnection;
      case AppStatusCode.serverError:
        return l10n.somethingWrongDescription;
      case AppStatusCode.authTokenExpired:
        return l10n.authTokenExpiredError;
      case AppStatusCode.sessionExpired:
        return l10n.sessionExpired;
      case AppStatusCode.invalidPageNumber:
        return l10n.invalidPageNumber;
      case AppStatusCode.currentPasswordInvalid:
        return l10n.currentPasswordInvalid;
      case AppStatusCode.changePasswordFailed:
        return l10n.changePasswordFailed;
      case AppStatusCode.invalidCredentials:
        return l10n.invalidCredentials;
      default:
        return l10n.somethingWrongDescription;
    }
  }

  factory AppStatusCode.fromString(String code) {
    return AppStatusCode.values.firstWhere(
      (e) => e.name == code,
      orElse: () => AppStatusCode.unknownError,
    );
  }
}
