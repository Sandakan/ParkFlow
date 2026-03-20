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
  @JsonValue('USER_ALREADY_EXISTS')
  userAlreadyExists,
  @JsonValue('AUTH_TOKEN_EXPIRED')
  authTokenExpired,
  @JsonValue('INVALID_CREDENTIALS')
  invalidCredentials,
  @JsonValue('USER_NOT_FOUND')
  userNotFound,
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
  messageMarkAsReadFailed,
  // Vehicles
  @JsonValue('VEHICLE_ALREADY_EXISTS')
  vehicleAlreadyExists,
  @JsonValue('VEHICLE_NOT_FOUND')
  vehicleNotFound,
  // Payment Methods
  @JsonValue('PAYMENT_METHOD_NOT_FOUND')
  paymentMethodNotFound,
  // Reservation
  @JsonValue('RESERVATION_LOT_ID_REQUIRED')
  reservationLotIdRequired,
  @JsonValue('RESERVATION_NO_AVAILABLE_SLOTS')
  reservationNoAvailableSlots,
  @JsonValue('RESERVATION_SLOT_NOT_FOUND')
  reservationSlotNotFound,
  @JsonValue('RESERVATION_SLOT_OCCUPIED')
  reservationSlotOccupied,
  @JsonValue('RESERVATION_LOT_NOT_FOUND')
  reservationLotNotFound,
  @JsonValue('RESERVATION_CREATED')
  reservationCreated,
  @JsonValue('RESERVATION_SLOT_TIME_CONFLICT')
  reservationSlotTimeConflict,
  // Cameras
  @JsonValue('CAMERA_NOT_FOUND')
  cameraNotFound,
  @JsonValue('CAMERA_RTSP_NOT_CONFIGURED')
  cameraRtspNotConfigured,
  @JsonValue('CAMERA_WEBRTC_FAILED')
  cameraWebrtcFailed,
  @JsonValue('CAMERA_NO_UPDATE_DATA')
  cameraNoUpdateData,
  // Parking
  @JsonValue('PARKING_LOT_NOT_FOUND')
  parkingLotNotFound,
  @JsonValue('PARKING_SLOT_NOT_FOUND')
  parkingSlotNotFound,
  // Permission
  @JsonValue('PERMISSION_DENIED')
  permissionDenied;

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
      case AppStatusCode.invalidResponse:
        return 'Invalid server response';
      case AppStatusCode.invalidPageNumber:
        return l10n.invalidPageNumber;
      case AppStatusCode.currentPasswordInvalid:
        return l10n.currentPasswordInvalid;
      case AppStatusCode.changePasswordFailed:
        return l10n.changePasswordFailed;
      case AppStatusCode.userAlreadyExists:
        return l10n.userAlreadyExists;
      case AppStatusCode.invalidCredentials:
        return l10n.invalidCredentials;
      case AppStatusCode.userNotFound:
        return l10n.userNotFound;
      case AppStatusCode.vehicleAlreadyExists:
        return l10n.vehicleAlreadyExists;
      case AppStatusCode.vehicleNotFound:
        return l10n.vehicleNotFound;
      case AppStatusCode.paymentMethodNotFound:
        return l10n.paymentMethodNotFound;
      case AppStatusCode.reservationNoAvailableSlots:
        return l10n.reservationNoAvailableSlots;
      case AppStatusCode.reservationSlotOccupied:
        return l10n.reservationSlotOccupied;
      case AppStatusCode.reservationSlotNotFound:
        return l10n.reservationSlotNotFound;
      case AppStatusCode.reservationLotNotFound:
        return l10n.reservationLotNotFound;
      case AppStatusCode.reservationLotIdRequired:
        return l10n.reservationLotIdRequired;
      case AppStatusCode.reservationSlotTimeConflict:
        return 'This slot is already booked for the selected time window';
      case AppStatusCode.cameraNotFound:
        return l10n.cameraNotFound;
      case AppStatusCode.cameraRtspNotConfigured:
        return l10n.cameraRtspNotConfigured;
      case AppStatusCode.cameraWebrtcFailed:
        return l10n.cameraWebrtcFailed;
      case AppStatusCode.permissionDenied:
        return l10n.permissionDenied;
      default:
        return l10n.somethingWrongDescription;
    }
  }

  factory AppStatusCode.fromString(String code) {
    return _$AppStatusCodeEnumMap.entries
        .firstWhere(
          (e) => e.value == code,
          orElse: () => MapEntry(AppStatusCode.unknownError, ''),
        )
        .key;
  }
}
