import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/services/vehicle_service.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/presentation/states/profile/vehicle_action_state.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';

part 'vehicle_notifier.g.dart';

@riverpod
class VehicleNotifier extends _$VehicleNotifier {
  @override
  VehicleActionState build() {
    return const VehicleActionState();
  }

  Future<void> addVehicle(String plateNumber, String type) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await ref.read(vehicleServiceProvider).addVehicle(plateNumber, type);
      await ref.read(authProvider.notifier).refreshUser();
      state = state.copyWith(isLoading: false);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      state = state.copyWith(isLoading: false, error: error);
      rethrow;
    }
  }

  Future<void> removeVehicle(String plateNumber) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await ref.read(vehicleServiceProvider).removeVehicle(plateNumber);
      await ref.read(authProvider.notifier).refreshUser();
      state = state.copyWith(isLoading: false);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      state = state.copyWith(isLoading: false, error: error);
      rethrow;
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
