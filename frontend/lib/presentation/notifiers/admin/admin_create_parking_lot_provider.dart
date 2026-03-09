import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/repositories/entities/parking/create_parking_lot_request.dart';
import 'package:parkflow/services/parking_service.dart';
import 'package:parkflow/presentation/notifiers/parking_lots/parking_lots_notifier.dart';

part 'admin_create_parking_lot_provider.g.dart';

@riverpod
class AdminCreateParkingLot extends _$AdminCreateParkingLot {
  @override
  bool build() {
    return false;
  }

  Future<void> submit(CreateParkingLotRequest request) async {
    state = true;
    try {
      await ref.read(parkingServiceProvider).createParkingLot(request);
      await ref.read(parkingLotsProvider.notifier).fetchLots();
    } finally {
      state = false;
    }
  }
}
