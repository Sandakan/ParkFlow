import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';
import 'package:parkflow/utils/constants/enums/app_status_code.dart';

void main() {
  group('ErrorHandler', () {
    test('should return sessionExpired for 401 DioException', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
        ),
        type: DioExceptionType.badResponse,
      );

      final exception = ErrorHandler.handle(dioError);

      expect(exception.code, AppStatusCode.sessionExpired);
    });

    test('should return serverError for 500 DioException', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
        ),
        type: DioExceptionType.badResponse,
      );

      final exception = ErrorHandler.handle(dioError);

      expect(exception.code, AppStatusCode.serverError);
    });

    test('should return custom message if present in data', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          data: {'message': 'Custom error message'},
          statusCode: 400,
        ),
        type: DioExceptionType.badResponse,
      );

      final exception = ErrorHandler.handle(dioError);

      expect(exception.customMessage, 'Custom error message');
    });

    test('should handle network timeout', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.connectionTimeout,
      );

      final exception = ErrorHandler.handle(dioError);

      expect(exception.code, AppStatusCode.networkError);
    });
  });
}
