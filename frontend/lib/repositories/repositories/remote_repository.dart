import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/core/network/entities/login_request_entity.dart';
import 'package:parkflow/core/network/entities/login_response_entity.dart';
import 'package:parkflow/core/network/entities/get_user_response_entity.dart';
import 'package:parkflow/core/network/entities/get_parking_slots_response_entity.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/repositories/interfaces/env_repository_interface.dart';
import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/repositories/interfaces/secure_storage_repository_interface.dart';
import 'package:parkflow/utils/constants/enums/app_error_code.dart';
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
  T validateResponse<T extends Response>(T? response) {
    if (response == null) {
      throw AppException(
        AppErrorCode.invalidResponse,
        cause: 'No response received',
      );
    }

    if (response.statusCode == 401) {
      throw AppException(
        AppErrorCode.authTokenExpired,
        cause: 'Unauthorized access',
      );
    }

    // Accept both 200 and 201 as successful responses
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw AppException(
        AppErrorCode.serverError,
        cause: 'Server returned ${response.statusCode}',
      );
    }

    return response;
  }

  @override
  Future<LoginResponseEntity> login(LoginRequestEntity request) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.post,
      '/token',
      data: request.toJson(),
      requestType: RequestTypeEnum.urlencoded,
    );

    final validatedResponse = validateResponse(response);

    try {
      return LoginResponseEntity.fromJson(validatedResponse.data);
    } catch (e, stackTrace) {
      throw AppException(
        AppErrorCode.invalidResponse,
        cause: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<GetUserResponseEntity> getCurrentUser(String token) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.get,
      '/users/me',
      accessToken: token,
    );

    final validatedResponse = validateResponse(response);

    try {
      return GetUserResponseEntity.fromJson(validatedResponse.data);
    } catch (e, stackTrace) {
      throw AppException(
        AppErrorCode.invalidResponse,
        cause: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<GetParkingSlotsResponseEntity> getParkingSlots() async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.get,
      '/parking/slots',
    );

    final validatedResponse = validateResponse(response);

    try {
      return GetParkingSlotsResponseEntity.fromJson(validatedResponse.data);
    } catch (e, stackTrace) {
      throw AppException(
        AppErrorCode.invalidResponse,
        cause: e,
        stackTrace: stackTrace,
      );
    }
  }
}
