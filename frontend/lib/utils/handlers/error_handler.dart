import 'package:dio/dio.dart';
import 'package:parkflow/utils/helpers/talker.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/utils/constants/enums/app_status_code.dart';

class ErrorHandler {
  static AppException handle(dynamic error) {
    if (error is DioException) {
      talker.error('Dio Error', error, error.stackTrace);
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return AppException(
            AppStatusCode.networkError,
            cause: error,
            stackTrace: error.stackTrace,
          );
        case DioExceptionType.badResponse:
          final data = error.response?.data;
          AppStatusCode errorCode = AppStatusCode.serverError;
          String? customMessage;

          if (data is Map<String, dynamic>) {
            if (data['code'] != null) {
              errorCode = AppStatusCode.fromString(data['code'].toString());
            }
            if (data['message'] != null) {
              customMessage = data['message'].toString();
            }
          } else if (error.response?.statusCode == 401) {
            errorCode = AppStatusCode.sessionExpired;
          }

          return AppException(
            errorCode,
            customMessage: customMessage,
            cause: error,
            stackTrace: error.stackTrace,
          );
        default:
          return AppException(
            AppStatusCode.unknownError,
            cause: error,
            stackTrace: error.stackTrace,
          );
      }
    }

    if (error is AppException) {
      talker.warning('App Exception', error, error.stackTrace);
      return error;
    }

    talker.error('Unknown Error', error);
    return AppException(AppStatusCode.unknownError, cause: error);
  }
}
