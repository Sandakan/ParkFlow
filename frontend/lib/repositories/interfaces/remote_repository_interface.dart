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
import 'package:parkflow/core/network/entities/get_analytics_overview_response_entity.dart';
import 'package:parkflow/core/network/entities/get_occupancy_trend_response_entity.dart';
import 'package:parkflow/core/network/entities/get_ai_health_response_entity.dart';

abstract class RemoteRepositoryInterface {
  Future<LoginResponseEntity> login(LoginRequestEntity request);
  Future<void> register(RegisterRequestEntity request);
  Future<GetUserResponseEntity> getCurrentUser(String token);
  Future<GetParkingSlotsResponseEntity> getParkingSlots({String? cameraId});
  Future<GetParkingLotsResponseEntity> getParkingLots({String? search});
  Future<GetParkingLotResponseEntity> getParkingLot(String lotId);
  Future<GetUserResponseEntity> testToken(String token);
  Future<LoginResponseEntity> refreshToken(String refreshToken);
  Future<void> createParkingLot(CreateParkingLotRequest request);
  Future<void> updateParkingLot(String lotId, UpdateParkingLotRequest request);
  Future<void> deleteParkingLot(String lotId);

  Future<void> createParkingSlot(CreateParkingSlotRequest request);
  Future<void> deleteParkingSlot(String slotId, {String? cameraId});

  Future<GetCamerasResponseEntity> getCameras();
  Future<void> createCamera(CreateCameraRequest request);
  Future<GetWebrtcOfferResponseEntity> sendWebrtcOffer(
    String cameraId,
    CreateWebrtcOfferRequest request,
  );

  Future<GetAnalyticsOverviewResponseEntity> getAnalyticsOverview();
  Future<GetOccupancyTrendResponseEntity> getOccupancyTrend(String period);
  Future<GetAiHealthResponseEntity> getAiHealth();
}
