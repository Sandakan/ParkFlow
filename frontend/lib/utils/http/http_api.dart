import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/repositories/interfaces/env_repository_interface.dart';
import 'package:parkflow/repositories/interfaces/secure_storage_repository_interface.dart';
import 'package:parkflow/utils/constants/enums/app_error_code.dart';
import 'package:parkflow/utils/constants/enums/http_method.dart';
import 'package:parkflow/utils/constants/enums/request_type.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';
import 'package:parkflow/utils/helpers/talker.dart';

class HttpApi {
  final Dio dio;
  final SecureStorageRepositoryInterface secureStorageRepository;
  final EnvRepositoryInterface envRepository;
  final Ref ref;

  HttpApi({
    required this.dio,
    required this.secureStorageRepository,
    required this.envRepository,
    required this.ref,
  }) {
    dio.options = BaseOptions(
      baseUrl: '${envRepository.getBaseUrl()}/api/v1',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    );

    dio.interceptors.add(
      TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: false,
          printResponseMessage: true,
        ),
      ),
    );
  }

  Future<Response?> doRequest(
    HttpMethodEnum connectionType,
    String url, {
    RequestTypeEnum requestType = RequestTypeEnum.json,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? customHeaders,
    Options? options,
    bool isAuthProcess = true,
    String? cookie,
    bool signoutWhenInvalidated = true,
    String? accessToken,
  }) async {
    try {
      if (!await _checkInternet()) {
        throw const AppException(AppErrorCode.noInternetConnection);
      }

      dio.options.extra = {'withCredentials': true};

      if (accessToken != null) {
        dio.options.headers['Authorization'] = 'Bearer $accessToken';
      }

      dynamic sendData = data;

      if (requestType != RequestTypeEnum.none) {
        switch (requestType) {
          case RequestTypeEnum.formdata:
            sendData = FormData.fromMap(data!);
            break;
          case RequestTypeEnum.urlencoded:
            dio.options.contentType = 'application/x-www-form-urlencoded';
            break;
          default:
            dio.options.contentType = 'application/json';
        }
      }

      if (customHeaders != null && customHeaders.isNotEmpty) {
        customHeaders.forEach((key, value) => dio.options.headers[key] = value);
      }

      if (cookie != null && !kIsWeb) {
        dio.options.headers['Cookie'] = cookie;
      }

      Response? response;

      switch (connectionType) {
        case HttpMethodEnum.post:
          response = await dio.post(
            url,
            data: sendData,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case HttpMethodEnum.delete:
          response = await dio.delete(
            url,
            data: sendData,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case HttpMethodEnum.put:
          response = await dio.put(
            url,
            data: sendData,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case HttpMethodEnum.patch:
          response = await dio.patch(
            url,
            data: sendData,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        default:
          response = await dio.get(
            url,
            data: sendData,
            queryParameters: queryParameters,
            options: options,
          );
      }

      return response;
    } on DioException catch (e) {
      try {
        if (e.response != null && [400, 401].contains(e.response!.statusCode)) {
          if (isAuthProcess && 401 == e.response!.statusCode) {
            if (signoutWhenInvalidated) {
              await ref.read(authProvider.notifier).logout();
            }
            throw const AppException(AppErrorCode.sessionExpired);
          }
          return e.response;
        }

        // Delegate to general error handler
        throw ErrorHandler.handle(e);
      } catch (innerError) {
        if (innerError is AppException) {
          rethrow;
        }
        throw ErrorHandler.handle(innerError);
      }
    }
  }

  Future<Uint8List?> downloadAsBytes(String url) async {
    try {
      if (!await _checkInternet()) {
        throw const AppException(AppErrorCode.noInternetConnection);
      }

      final response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status != null && status < 500;
          },
        ),
      );

      return response.data as Uint8List;
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<bool> _checkInternet() async {
    if (kIsWeb) {
      return true; // InternetConnection checking on web may fail or isn't needed usually
    }
    return await InternetConnection().hasInternetAccess;
  }
}
