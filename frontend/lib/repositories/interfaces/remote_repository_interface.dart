import 'package:parkflow/core/network/entities/login_request_entity.dart';
import 'package:parkflow/core/network/entities/login_response_entity.dart';
import 'package:parkflow/core/network/entities/get_user_response_entity.dart';
import 'package:parkflow/core/network/entities/get_parking_slots_response_entity.dart';

abstract class RemoteRepositoryInterface {
  Future<LoginResponseEntity> login(LoginRequestEntity request);
  Future<GetUserResponseEntity> getCurrentUser(String token);
  Future<GetParkingSlotsResponseEntity> getParkingSlots();
}
