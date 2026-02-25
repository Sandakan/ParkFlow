import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/repositories/providers/parking_repository_provider.dart';
import 'package:parkflow/repositories/interfaces/parking_repository_interface.dart';
import 'package:parkflow/models/parking/parking_slot_model.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';

class ParkingService {
  final ParkingRepositoryInterface _repo;

  ParkingService(this._repo);

  Future<List<ParkingSlotModel>> fetchParkingSlots() async {
    try {
      return await _repo.getParkingSlots();
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Stream<List<ParkingSlotModel>> streamParkingSlots() {
    return _repo.watchParkingSlots();
  }
}

final parkingServiceProvider = Provider<ParkingService>((ref) {
  final repo = ref.watch(parkingRepositoryProvider);
  return ParkingService(repo);
});
