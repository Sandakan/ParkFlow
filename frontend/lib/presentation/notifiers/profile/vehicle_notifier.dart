import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/services/vehicle_service.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';

part 'vehicle_notifier.g.dart';

@riverpod
class VehicleNotifier extends _$VehicleNotifier {
  @override
  void build() {
    return;
  }

  Future<void> addVehicle(String plateNumber, String type) async {
    try {
      await ref.read(vehicleServiceProvider).addVehicle(plateNumber, type);
      await ref.read(authProvider.notifier).refreshUser();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeVehicle(String plateNumber) async {
    try {
      await ref.read(vehicleServiceProvider).removeVehicle(plateNumber);
      await ref.read(authProvider.notifier).refreshUser();
    } catch (e) {
      rethrow;
    }
  }
}
