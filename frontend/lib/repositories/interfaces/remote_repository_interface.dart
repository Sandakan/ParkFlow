import 'package:parkflow/core/network/entities/login_request_entity.dart';
import 'package:parkflow/core/network/entities/login_response_entity.dart';
import 'package:parkflow/core/network/entities/get_user_response_entity.dart';
import 'package:parkflow/core/network/entities/get_parking_lot_response_entity.dart';
import 'package:parkflow/repositories/entities/parking/update_parking_lot_request.dart';
import 'package:parkflow/core/network/entities/get_parking_slots_response_entity.dart';
import 'package:parkflow/core/network/entities/get_parking_lots_response_entity.dart';
import 'package:parkflow/core/network/entities/register_request_entity.dart';
import 'package:parkflow/repositories/entities/parking/create_parking_lot_request.dart';
import 'package:parkflow/core/network/entities/get_cameras_response_entity.dart';
import 'package:parkflow/repositories/entities/parking/create_camera_request.dart';
import 'package:parkflow/repositories/entities/camera/create_webrtc_offer_request.dart';
import 'package:parkflow/core/network/entities/get_webrtc_offer_response_entity.dart';
import 'package:parkflow/repositories/entities/parking/create_parking_slot_request.dart';
import 'package:parkflow/repositories/entities/parking/update_camera_request.dart';
import 'package:parkflow/core/network/entities/get_analytics_overview_response_entity.dart';
import 'package:parkflow/core/network/entities/get_occupancy_trend_response_entity.dart';
import 'package:parkflow/core/network/entities/get_ai_health_response_entity.dart';
import 'package:parkflow/repositories/entities/settings/get_inference_settings_response_entity.dart';
import 'package:parkflow/repositories/entities/settings/update_inference_settings_request.dart';
import 'package:parkflow/core/network/entities/get_parking_suggestions_response_entity.dart';

abstract class RemoteRepositoryInterface {
  Future<LoginResponseEntity> login(LoginRequestEntity request);
  Future<void> register(RegisterRequestEntity request);
  Future<GetUserResponseEntity> getCurrentUser(String token);
  Future<GetParkingSlotsResponseEntity> getParkingSlots({
    String? cameraId,
    String? lotId,
    String? accessToken,
  });
  Future<GetParkingLotsResponseEntity> getParkingLots({
    String? search,
    double? latitude,
    double? longitude,
    String? accessToken,
  });
  Future<GetParkingLotResponseEntity> getParkingLot(
    String lotId, {
    String? accessToken,
  });
  Future<GetUserResponseEntity> testToken(String token);
  Future<LoginResponseEntity> refreshToken(String refreshToken);
  Future<void> createParkingLot(
    CreateParkingLotRequest request, {
    String? accessToken,
  });
  Future<void> updateParkingLot(
    String lotId,
    UpdateParkingLotRequest request, {
    String? accessToken,
  });
  Future<void> deleteParkingLot(String lotId, {String? accessToken});

  Future<void> createParkingSlot(
    CreateParkingSlotRequest request, {
    String? accessToken,
  });
  Future<void> deleteParkingSlot(
    String slotId, {
    String? cameraId,
    String? accessToken,
  });

  Future<GetCamerasResponseEntity> getCameras({String? accessToken});
  Future<void> createCamera(CreateCameraRequest request, {String? accessToken});
  Future<void> updateCamera(
    String cameraId,
    UpdateCameraRequest request, {
    String? accessToken,
  });
  Future<void> deleteCamera(String cameraId, {String? accessToken});
  Future<GetWebrtcOfferResponseEntity> sendWebrtcOffer(
    String cameraId,
    CreateWebrtcOfferRequest request, {
    String? accessToken,
  });

  Future<GetAnalyticsOverviewResponseEntity> getAnalyticsOverview({
    String? accessToken,
  });
  Future<GetOccupancyTrendResponseEntity> getOccupancyTrend(
    String period, {
    String? accessToken,
  });
  Future<GetAiHealthResponseEntity> getAiHealth({String? accessToken});
  Future<bool> checkCameraHealth(String cameraId, {String? accessToken});

  Future<GetInferenceSettingsResponseEntity> getInferenceSettings({
    String? accessToken,
  });
  Future<void> updateInferenceSettings(
    UpdateInferenceSettingsRequest request, {
    String? accessToken,
  });

  Future<GetParkingSuggestionsResponseEntity> getParkingSuggestions(
    String lotId, {
    String? accessToken,
  });
}
