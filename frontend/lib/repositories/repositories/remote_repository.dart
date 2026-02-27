import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/core/network/entities/login_request_entity.dart';
import 'package:parkflow/core/network/entities/login_response_entity.dart';
import 'package:parkflow/core/network/entities/get_user_response_entity.dart';
import 'package:parkflow/core/network/entities/get_parking_slots_response_entity.dart';
import 'package:parkflow/core/network/entities/register_request_entity.dart';
import 'package:parkflow/core/network/entities/base_response_entity.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/repositories/interfaces/env_repository_interface.dart';
import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/repositories/interfaces/secure_storage_repository_interface.dart';
import 'package:parkflow/utils/constants/enums/app_status_code.dart';
import 'package:parkflow/utils/constants/enums/http_method.dart';
import 'package:parkflow/utils/constants/enums/request_type.dart';
import 'package:parkflow/utils/http/http_api.dart';

class RemoteRepository implements RemoteRepositoryInterface {
  final HttpApi httpAPI;
  final SecureStorageRepositoryInterface secureStorageRepository;
  final EnvRepositoryInterface envRepository;
  final Ref ref;

  RemoteRepository({
    required this.ref,
    required this.httpAPI,
    required this.secureStorageRepository,
    required this.envRepository,
  });

  /// Validates a response from the server and throws an [AppException] if:
  ///
  /// - The response is null.
  /// - The response status code is 401 (Unauthorized).
  /// - The response status code is not 200 (OK).
  ///
  /// Otherwise, returns the validated response.
  BaseResponseEntity validateResponse(
    Response? response, {
    bool throwOnNullData = true,
    bool allowNonSuccessResponses = false,
  }) {
    if (response == null) {
      throw AppException(
        AppStatusCode.invalidResponse,
        cause: 'No response received',
      );
    }

    late BaseResponseEntity baseResponse;
    try {
      baseResponse = BaseResponseEntity.fromJson(response.data);
    } catch (e) {
      throw AppException(AppStatusCode.invalidResponse);
    }

    if (baseResponse.statusCode == 401) {
      throw AppException(
        AppStatusCode.authTokenExpired,
        cause: 'Unauthorized access',
      );
    }

    if (!allowNonSuccessResponses &&
        baseResponse.statusCode != 200 &&
        baseResponse.statusCode != 201) {
      throw AppException(
        AppStatusCode.serverError,
        cause: 'Server returned ${baseResponse.statusCode}',
      );
    }

    if (throwOnNullData && baseResponse.data == null) {
      throw AppException(
        AppStatusCode.invalidResponse,
        cause: 'Response data is null',
      );
    }

    return baseResponse;
  }

  /// Fetches a valid access token via [AuthNotifier.getValidAccessToken].
  /// This handles expiry checks and refresh with a built-in lock.
  Future<String?> _getToken() =>
      ref.read(authProvider.notifier).getValidAccessToken();

  @override
  Future<LoginResponseEntity> login(LoginRequestEntity request) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.post,
      'auth/login',
      data: request.toJson(),
      requestType: RequestTypeEnum.urlencoded,
    );

    final validatedResponse = validateResponse(
      response,
      allowNonSuccessResponses: true,
      throwOnNullData: false,
    );

    if (!validatedResponse.success) {
      if (validatedResponse.code == 'INVALID_CREDENTIALS') {
        throw AppException(
          AppStatusCode.invalidCredentials,
          cause: validatedResponse.message,
        );
      }
      throw AppException(
        AppStatusCode.invalidResponse,
        cause: validatedResponse.message,
      );
    }

    try {
      final data = LoginResponseEntity.fromJson(validatedResponse.data);
      return data;
    } catch (e, stackTrace) {
      throw AppException(
        AppStatusCode.invalidResponse,
        cause: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> register(RegisterRequestEntity request) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.post,
      'users/',
      data: request.toJson(),
    );

    validateResponse(response);
  }

  @override
  Future<GetUserResponseEntity> getCurrentUser(String token) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.get,
      'users/me',
      accessToken: token,
    );

    final validatedResponse = validateResponse(response);

    try {
      final data = GetUserResponseEntity.fromJson(validatedResponse.data);
      return data;
    } catch (e, stackTrace) {
      throw AppException(
        AppStatusCode.invalidResponse,
        cause: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<GetParkingSlotsResponseEntity> getParkingSlots() async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.get,
      'parking/slots',
      accessToken: await _getToken(),
    );

    final validatedResponse = validateResponse(response);

    try {
      final data = GetParkingSlotsResponseEntity.fromJson(
        validatedResponse.data,
      );
      return data;
    } catch (e, stackTrace) {
      throw AppException(
        AppStatusCode.invalidResponse,
        cause: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<GetUserResponseEntity> testToken(String token) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.post,
      'auth/test-token',
      accessToken: token,
    );

    final validatedResponse = validateResponse(response);

    try {
      final data = GetUserResponseEntity.fromJson(validatedResponse.data);
      return data;
    } catch (e, stackTrace) {
      throw AppException(
        AppStatusCode.invalidResponse,
        cause: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<LoginResponseEntity> refreshToken(String refreshToken) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.post,
      'auth/refresh',
      data: {'refresh_token': refreshToken},
    );

    final validatedResponse = validateResponse(response);

    try {
      final data = LoginResponseEntity.fromJson(validatedResponse.data);
      return data;
    } catch (e, stackTrace) {
      throw AppException(
        AppStatusCode.invalidResponse,
        cause: e,
        stackTrace: stackTrace,
      );
    }
  }
}
