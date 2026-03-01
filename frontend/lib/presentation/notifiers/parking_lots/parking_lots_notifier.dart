import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/services/parking_service.dart';
import 'package:parkflow/presentation/notifiers/parking_lots/parking_lots_state.dart';

part 'parking_lots_notifier.g.dart';

@riverpod
class ParkingLotsNotifier extends _$ParkingLotsNotifier {
  Timer? _debounceTimer;

  @override
  ParkingLotsState build() {
    // Initial fetch
    Future.microtask(() => fetchLots());
    return const ParkingLotsState();
  }

  Future<void> fetchLots({String query = ''}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final parkingService = ref.read(parkingServiceProvider);

      final lots = await parkingService.fetchParkingLots(search: query);
      state = state.copyWith(lots: lots, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void updateSearchQuery(String query) {
    if (state.searchQuery == query) return;

    state = state.copyWith(searchQuery: query);

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      fetchLots(query: query);
    });
  }
}
