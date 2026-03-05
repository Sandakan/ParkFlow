import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/services/parking_service.dart';
import 'package:parkflow/presentation/states/parking/parking_state.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';

import 'package:parkflow/utils/helpers/talker.dart';

part 'parking_notifier.g.dart';

@riverpod
class ParkingNotifier extends _$ParkingNotifier {
  StreamSubscription? _subscription;

  @override
  ParkingState build() {
    _subscription?.cancel();

    Future.microtask(() => _init());

    ref.onDispose(() {
      _subscription?.cancel();
    });

    return const ParkingState(isLoading: true);
  }

  Future<void> _init() async {
    try {
      final service = ref.read(parkingServiceProvider);

      final lots = await service.fetchParkingLots();
      if (lots.isNotEmpty) {
        state = state.copyWith(lot: lots[0]);
        await _fetchSuggestions(lots[0].id);
      }

      _initStream();
    } catch (e) {
      if (state.isLoading) {
        state = state.copyWith(isLoading: false, error: ErrorHandler.handle(e));
      }
    }
  }

  Future<void> _fetchSuggestions(String lotId) async {
    try {
      final response = await ref
          .read(parkingServiceProvider)
          .getParkingSuggestions(lotId);
      state = state.copyWith(suggestions: response.suggestions);
    } catch (e) {
      talker.error('Error fetching suggestions: $e');
    }
  }

  void _initStream() {
    final lotId = state.lot?.id;
    final stream = ref
        .read(parkingServiceProvider)
        .streamParkingSlots(lotId: lotId);
    _subscription = stream.listen(
      (slots) {
        state = state.copyWith(isLoading: false, slots: slots, error: null);
        if (state.lot != null) {
          _fetchSuggestions(state.lot!.id);
        }
      },
      onError: (e) {
        state = state.copyWith(isLoading: false, error: ErrorHandler.handle(e));
      },
    );
  }
}
