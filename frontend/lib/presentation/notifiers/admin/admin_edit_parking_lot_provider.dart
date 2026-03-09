import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/repositories/entities/parking/update_parking_lot_request.dart';
import 'package:parkflow/services/parking_service.dart';
import 'package:parkflow/presentation/notifiers/parking_lots/parking_lots_notifier.dart';
import 'package:parkflow/core/network/entities/get_parking_lot_response_entity.dart';

part 'admin_edit_parking_lot_provider.g.dart';

class AdminEditParkingLotState {
  final bool isLoading;
  final bool isUpdating;
  final GetParkingLotResponseEntity? lot;

  AdminEditParkingLotState({
    required this.isLoading,
    required this.isUpdating,
    this.lot,
  });

  AdminEditParkingLotState copyWith({
    bool? isLoading,
    bool? isUpdating,
    GetParkingLotResponseEntity? lot,
  }) {
    return AdminEditParkingLotState(
      isLoading: isLoading ?? this.isLoading,
      isUpdating: isUpdating ?? this.isUpdating,
      lot: lot ?? this.lot,
    );
  }
}

@riverpod
class AdminEditParkingLot extends _$AdminEditParkingLot {
  @override
  AdminEditParkingLotState build(String lotId) {
    _fetchLotData();
    return AdminEditParkingLotState(isLoading: true, isUpdating: false);
  }

  Future<void> _fetchLotData() async {
    try {
      final lot = await ref.read(parkingServiceProvider).fetchParkingLot(lotId);
      state = state.copyWith(isLoading: false, lot: lot);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> submit(UpdateParkingLotRequest request) async {
    state = state.copyWith(isUpdating: true);
    try {
      await ref.read(parkingServiceProvider).updateParkingLot(lotId, request);
      await ref.read(parkingLotsProvider.notifier).fetchLots();
    } finally {
      state = state.copyWith(isUpdating: false);
    }
  }

  Future<void> deleteLot() async {
    state = state.copyWith(isUpdating: true);
    try {
      await ref.read(parkingServiceProvider).deleteParkingLot(lotId);
      await ref.read(parkingLotsProvider.notifier).fetchLots();
    } finally {
      state = state.copyWith(isUpdating: false);
    }
  }
}
