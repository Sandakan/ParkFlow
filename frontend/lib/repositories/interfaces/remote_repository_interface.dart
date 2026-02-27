import 'package:parkflow/core/network/entities/login_request_entity.dart';
import 'package:parkflow/core/network/entities/login_response_entity.dart';
import 'package:parkflow/core/network/entities/get_user_response_entity.dart';
import 'package:parkflow/core/network/entities/get_parking_slots_response_entity.dart';
import 'package:parkflow/core/network/entities/register_request_entity.dart';

abstract class RemoteRepositoryInterface {
  Future<LoginResponseEntity> login(LoginRequestEntity request);
  Future<void> register(RegisterRequestEntity request);
  Future<GetUserResponseEntity> getCurrentUser(String token);
  Future<GetParkingSlotsResponseEntity> getParkingSlots();
  Future<GetUserResponseEntity> testToken(String token);
  Future<LoginResponseEntity> refreshToken(String refreshToken);
}
