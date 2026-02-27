import 'package:parkflow/core/network/entities/login_request_entity.dart';
import 'package:parkflow/core/network/entities/login_response_entity.dart';
import 'package:parkflow/core/network/entities/get_user_response_entity.dart';
import 'package:parkflow/core/network/entities/get_parking_lot_response_entity.dart';
import 'package:parkflow/repositories/entities/parking/update_parking_lot_request.dart';
import 'package:parkflow/core/network/entities/get_parking_slots_response_entity.dart';
import 'package:parkflow/core/network/entities/get_parking_lots_response_entity.dart';
import 'package:parkflow/core/network/entities/register_request_entity.dart';
import 'package:parkflow/repositories/entities/parking/create_parking_lot_request.dart';

abstract class RemoteRepositoryInterface {
  Future<LoginResponseEntity> login(LoginRequestEntity request);
  Future<void> register(RegisterRequestEntity request);
  Future<GetUserResponseEntity> getCurrentUser(String token);
  Future<GetParkingSlotsResponseEntity> getParkingSlots();
  Future<GetParkingLotsResponseEntity> getParkingLots({String? search});
  Future<GetParkingLotResponseEntity> getParkingLot(String lotId);
  Future<GetUserResponseEntity> testToken(String token);
  Future<LoginResponseEntity> refreshToken(String refreshToken);
  Future<void> createParkingLot(CreateParkingLotRequest request);
  Future<void> updateParkingLot(String lotId, UpdateParkingLotRequest request);
  Future<void> deleteParkingLot(String lotId);
}
