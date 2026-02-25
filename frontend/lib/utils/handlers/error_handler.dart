import 'package:dio/dio.dart';
import 'package:parkflow/utils/helpers/talker.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/utils/constants/enums/app_error_code.dart';

class ErrorHandler {
  static AppException handle(dynamic error) {
    if (error is DioException) {
      talker.error('Dio Error', error, error.stackTrace);
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return AppException(
            AppErrorCode.networkError,
            cause: error,
            stackTrace: error.stackTrace,
          );
        case DioExceptionType.badResponse:
          final data = error.response?.data;
          AppErrorCode errorCode = AppErrorCode.serverError;
          if (data is Map<String, dynamic> && data['code'] != null) {
            errorCode = AppErrorCode.fromBackendCode(data['code'].toString());
          } else if (error.response?.statusCode == 401) {
            errorCode = AppErrorCode.sessionExpired;
          }
          return AppException(
            errorCode,
            cause: error,
            stackTrace: error.stackTrace,
          );
        default:
          return AppException(
            AppErrorCode.unknownError,
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
    return AppException(AppErrorCode.unknownError, cause: error);
  }
}
