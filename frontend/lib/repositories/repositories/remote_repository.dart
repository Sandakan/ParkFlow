import 'package:dio/dio.dart';
import 'package:parkflow/core/network/entities/login_request_entity.dart';
import 'package:parkflow/core/network/entities/login_response_entity.dart';
import 'package:parkflow/core/network/entities/get_user_response_entity.dart';
import 'package:parkflow/core/network/entities/get_parking_slots_response_entity.dart';
import 'package:parkflow/core/network/entities/get_parking_lots_response_entity.dart';
import 'package:parkflow/core/network/entities/register_request_entity.dart';
import 'package:parkflow/core/network/entities/base_response_entity.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/repositories/interfaces/env_repository_interface.dart';
import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/repositories/interfaces/secure_storage_repository_interface.dart';
import 'package:parkflow/core/network/entities/get_parking_lot_response_entity.dart';
import 'package:parkflow/repositories/entities/parking/update_parking_lot_request.dart';
import 'package:parkflow/repositories/entities/parking/create_parking_lot_request.dart';
import 'package:parkflow/repositories/entities/parking/create_camera_request.dart';
import 'package:parkflow/repositories/entities/parking/update_camera_request.dart';
import 'package:parkflow/core/network/entities/get_cameras_response_entity.dart';
import 'package:parkflow/repositories/entities/camera/create_webrtc_offer_request.dart';
import 'package:parkflow/core/network/entities/get_webrtc_offer_response_entity.dart';
import 'package:parkflow/repositories/entities/parking/create_parking_slot_request.dart';
import 'package:parkflow/core/network/entities/get_analytics_overview_response_entity.dart';
import 'package:parkflow/core/network/entities/get_occupancy_trend_response_entity.dart';
import 'package:parkflow/core/network/entities/get_ai_health_response_entity.dart';
import 'package:parkflow/repositories/entities/settings/get_inference_settings_response_entity.dart';
import 'package:parkflow/repositories/entities/settings/update_inference_settings_request.dart';
import 'package:parkflow/core/network/entities/get_parking_suggestions_response_entity.dart';
import 'package:parkflow/utils/constants/enums/app_status_code.dart';
import 'package:parkflow/utils/constants/enums/http_method.dart';
import 'package:parkflow/utils/constants/enums/request_type.dart';
import 'package:parkflow/utils/http/http_api.dart';

class RemoteRepository implements RemoteRepositoryInterface {
  final HttpApi httpAPI;
  final SecureStorageRepositoryInterface secureStorageRepository;
  final EnvRepositoryInterface envRepository;

  RemoteRepository({
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
  Future<GetParkingSlotsResponseEntity> getParkingSlots({
    String? cameraId,
    String? lotId,
    String? accessToken,
  }) async {
    final Map<String, dynamic> queryParameters = {};
    if (cameraId != null) {
      queryParameters['camera_id'] = cameraId;
    }
    if (lotId != null) {
      queryParameters['lot_id'] = lotId;
    }

    final response = await httpAPI.doRequest(
      HttpMethodEnum.get,
      'parking/slots',
      queryParameters: queryParameters,
      accessToken: accessToken,
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
  Future<void> createParkingSlot(
    CreateParkingSlotRequest request, {
    String? accessToken,
  }) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.post,
      'parking/slots',
      data: request.toJson(),
      accessToken: accessToken,
    );

    validateResponse(response, throwOnNullData: false);
  }

  @override
  Future<void> deleteParkingSlot(
    String slotId, {
    String? cameraId,
    String? accessToken,
  }) async {
    final Map<String, dynamic> queryParameters = {};
    if (cameraId != null) {
      queryParameters['camera_id'] = cameraId;
    }

    final response = await httpAPI.doRequest(
      HttpMethodEnum.delete,
      'parking/slots/$slotId',
      queryParameters: queryParameters,
      accessToken: accessToken,
    );

    validateResponse(response, throwOnNullData: false);
  }

  @override
  Future<GetParkingLotsResponseEntity> getParkingLots({
    String? search,
    double? latitude,
    double? longitude,
    String? accessToken,
  }) async {
    final Map<String, dynamic> queryParameters = {};
    if (search != null && search.isNotEmpty) {
      queryParameters['search'] = search;
    }
    if (latitude != null) {
      queryParameters['latitude'] = latitude;
    }
    if (longitude != null) {
      queryParameters['longitude'] = longitude;
    }

    final response = await httpAPI.doRequest(
      HttpMethodEnum.get,
      'parking/lots',
      queryParameters: queryParameters,
      accessToken: accessToken,
    );

    final validatedResponse = validateResponse(response);

    try {
      final data = GetParkingLotsResponseEntity.fromJson(
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

  @override
  Future<void> createParkingLot(
    CreateParkingLotRequest request, {
    String? accessToken,
  }) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.post,
      'parking/lots',
      data: request.toJson(),
      accessToken: accessToken,
    );

    validateResponse(response, throwOnNullData: false);
  }

  @override
  Future<GetParkingLotResponseEntity> getParkingLot(
    String lotId, {
    String? accessToken,
  }) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.get,
      'parking/lots/$lotId',
      accessToken: accessToken,
    );

    final validatedResponse = validateResponse(response);

    try {
      final data = GetParkingLotResponseEntity.fromJson(validatedResponse.data);
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
  Future<void> updateParkingLot(
    String lotId,
    UpdateParkingLotRequest request, {
    String? accessToken,
  }) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.put,
      'parking/lots/$lotId',
      data: request.toJson(),
      accessToken: accessToken,
    );

    validateResponse(response, throwOnNullData: false);
  }

  @override
  Future<void> deleteParkingLot(String lotId, {String? accessToken}) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.delete,
      'parking/lots/$lotId',
      accessToken: accessToken,
    );

    validateResponse(response, throwOnNullData: false);
  }

  @override
  Future<GetCamerasResponseEntity> getCameras({String? accessToken}) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.get,
      'cameras/',
      accessToken: accessToken,
    );

    final validatedResponse = validateResponse(response);

    try {
      final data = GetCamerasResponseEntity.fromJson(validatedResponse.data);
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
  Future<void> createCamera(
    CreateCameraRequest request, {
    String? accessToken,
  }) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.post,
      'cameras/',
      data: request.toJson(),
      accessToken: accessToken,
    );

    validateResponse(response, throwOnNullData: false);
  }

  @override
  Future<void> updateCamera(
    String cameraId,
    UpdateCameraRequest request, {
    String? accessToken,
  }) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.patch,
      'cameras/$cameraId',
      data: request.toJson(),
      accessToken: accessToken,
    );

    validateResponse(response, throwOnNullData: false);
  }

  @override
  Future<void> deleteCamera(String cameraId, {String? accessToken}) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.delete,
      'cameras/$cameraId',
      accessToken: accessToken,
    );

    validateResponse(response, throwOnNullData: false);
  }

  @override
  Future<GetWebrtcOfferResponseEntity> sendWebrtcOffer(
    String cameraId,
    CreateWebrtcOfferRequest request, {
    String? accessToken,
  }) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.post,
      'cameras/$cameraId/webrtc/offer',
      data: request.toJson(),
      accessToken: accessToken,
    );

    final validatedResponse = validateResponse(response);

    try {
      final data = GetWebrtcOfferResponseEntity.fromJson(
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
  Future<GetAnalyticsOverviewResponseEntity> getAnalyticsOverview({
    String? accessToken,
  }) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.get,
      'analytics/overview',
      accessToken: accessToken,
    );

    final validatedResponse = validateResponse(response);

    try {
      return GetAnalyticsOverviewResponseEntity.fromJson(
        validatedResponse.data,
      );
    } catch (e, stackTrace) {
      throw AppException(
        AppStatusCode.invalidResponse,
        cause: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<GetOccupancyTrendResponseEntity> getOccupancyTrend(
    String period, {
    String? accessToken,
  }) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.get,
      'analytics/occupancy-trend',
      queryParameters: {'period': period},
      accessToken: accessToken,
    );

    final validatedResponse = validateResponse(response);

    try {
      return GetOccupancyTrendResponseEntity.fromJson(validatedResponse.data);
    } catch (e, stackTrace) {
      throw AppException(
        AppStatusCode.invalidResponse,
        cause: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<GetAiHealthResponseEntity> getAiHealth({String? accessToken}) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.get,
      'analytics/ai-health',
      accessToken: accessToken,
    );

    final validatedResponse = validateResponse(response);

    try {
      return GetAiHealthResponseEntity.fromJson(validatedResponse.data);
    } catch (e, stackTrace) {
      throw AppException(
        AppStatusCode.invalidResponse,
        cause: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<bool> checkCameraHealth(String cameraId, {String? accessToken}) async {
    try {
      final response = await httpAPI.doRequest(
        HttpMethodEnum.get,
        'cameras/$cameraId/health',
        accessToken: accessToken,
      );

      final validatedResponse = validateResponse(response);

      return (validatedResponse.data as Map<String, dynamic>)['isAlive'] ??
          false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<GetInferenceSettingsResponseEntity> getInferenceSettings({
    String? accessToken,
  }) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.get,
      'settings/inference',
      accessToken: accessToken,
    );

    final validatedResponse = validateResponse(response);

    try {
      return GetInferenceSettingsResponseEntity.fromJson(
        validatedResponse.data,
      );
    } catch (e, stackTrace) {
      throw AppException(
        AppStatusCode.invalidResponse,
        cause: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> updateInferenceSettings(
    UpdateInferenceSettingsRequest request, {
    String? accessToken,
  }) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.put,
      'settings/inference',
      data: request.toJson(),
      accessToken: accessToken,
    );

    validateResponse(response, throwOnNullData: false);
  }

  @override
  Future<GetParkingSuggestionsResponseEntity> getParkingSuggestions(
    String lotId, {
    String? accessToken,
  }) async {
    final response = await httpAPI.doRequest(
      HttpMethodEnum.get,
      'parking/lots/$lotId/suggestions',
      accessToken: accessToken,
    );

    final validatedResponse = validateResponse(response);

    try {
      return GetParkingSuggestionsResponseEntity.fromJson(
        validatedResponse.data,
      );
    } catch (e, stackTrace) {
      throw AppException(
        AppStatusCode.invalidResponse,
        cause: e,
        stackTrace: stackTrace,
      );
    }
  }
}
