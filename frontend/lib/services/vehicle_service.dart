import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/utils/constants/enums/app_status_code.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';

part 'vehicle_service.g.dart';

class VehicleService {
  final RemoteRepositoryInterface _remote;
  final Ref _ref;

  VehicleService(this._remote, this._ref);

  Future<String?> _getToken() =>
      _ref.read(authProvider.notifier).getValidAccessToken();

  Future<void> addVehicle(String plateNumber, String type) async {
    try {
      if (plateNumber.isEmpty || type.isEmpty) {
        throw const AppException(AppStatusCode.invalidResponse);
      }
      final token = await _getToken();
      await _remote.addVehicle({
        'plate_number': plateNumber,
        'type': type,
      }, accessToken: token);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<void> removeVehicle(String plateNumber) async {
    try {
      if (plateNumber.isEmpty) {
        throw const AppException(AppStatusCode.invalidResponse);
      }
      final token = await _getToken();
      await _remote.removeVehicle(plateNumber, accessToken: token);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}

@riverpod
VehicleService vehicleService(Ref ref) {
  final remote = ref.watch(remoteRepositoryProvider);
  return VehicleService(remote, ref);
}
