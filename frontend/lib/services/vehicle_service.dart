import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/repositories/interfaces/secure_storage_repository_interface.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:parkflow/repositories/providers/secure_storage_repository_provider.dart';
import 'package:parkflow/models/auth/user_model.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/utils/constants/enums/app_status_code.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';

part 'vehicle_service.g.dart';

class VehicleService {
  final RemoteRepositoryInterface _remote;
  final SecureStorageRepositoryInterface _storage;

  VehicleService(this._remote, this._storage);

  Future<UserModel> addVehicle(String plateNumber, String type) async {
    try {
      if (plateNumber.isEmpty || type.isEmpty) {
        throw const AppException(AppStatusCode.invalidResponse);
      }
      final token = await _storage.getAccessToken();
      final userResponse = await _remote.addVehicle({
        'plate_number': plateNumber,
        'type': type,
      }, accessToken: token);

      return UserModel(
        id: userResponse.id,
        email: userResponse.email,
        name: userResponse.name,
        role: userResponse.role,
        vehicles: userResponse.vehicles,
        paymentMethods: userResponse.paymentMethods,
      );
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<UserModel> removeVehicle(String plateNumber) async {
    try {
      if (plateNumber.isEmpty) {
        throw const AppException(AppStatusCode.invalidResponse);
      }
      final token = await _storage.getAccessToken();
      final userResponse = await _remote.removeVehicle(
        plateNumber,
        accessToken: token,
      );

      return UserModel(
        id: userResponse.id,
        email: userResponse.email,
        name: userResponse.name,
        role: userResponse.role,
        vehicles: userResponse.vehicles,
        paymentMethods: userResponse.paymentMethods,
      );
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}

@riverpod
VehicleService vehicleService(Ref ref) {
  final remote = ref.watch(remoteRepositoryProvider);
  final storage = ref.watch(secureStorageRepositoryProvider);
  return VehicleService(remote, storage);
}
