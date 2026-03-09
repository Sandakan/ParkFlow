import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/services/parking_service.dart';
import 'package:parkflow/presentation/states/parking/parking_state.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';

part 'parking_lot_layout_notifier.g.dart';

@riverpod
class ParkingLotLayout extends _$ParkingLotLayout {
  StreamSubscription? _subscription;

  @override
  ParkingState build(String lotId) {
    _subscription?.cancel();

    final service = ref.watch(parkingServiceProvider);

    Future.microtask(() => _init(lotId, service));

    ref.onDispose(() {
      _subscription?.cancel();
    });

    return const ParkingState(isLoading: true);
  }

  Future<void> _init(String lotId, ParkingService service) async {
    try {
      final lotResponse = await service.fetchParkingLot(lotId);
      final lot = lotResponse.toModel();

      state = state.copyWith(lot: lot);

      final suggestionsResponse = await service.getParkingSuggestions(lotId);
      state = state.copyWith(suggestions: suggestionsResponse.suggestions);

      _initStream(lotId, service);
    } catch (e) {
      if (state.isLoading) {
        state = state.copyWith(isLoading: false, error: ErrorHandler.handle(e));
      }
    }
  }

  void _initStream(String lotId, ParkingService service) {
    final stream = service.streamParkingSlots(lotId: lotId);
    _subscription = stream.listen(
      (slots) {
        final filteredSlots = slots.where((s) => s.lotId == lotId).toList();
        state = state.copyWith(
          isLoading: false,
          slots: filteredSlots,
          error: null,
        );
      },
      onError: (e) {
        state = state.copyWith(isLoading: false, error: ErrorHandler.handle(e));
      },
    );
  }
}
