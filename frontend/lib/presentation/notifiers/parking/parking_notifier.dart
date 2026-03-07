import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/services/parking_service.dart';
import 'package:parkflow/presentation/states/parking/parking_state.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parkflow/utils/helpers/talker.dart';
import 'package:parkflow/models/parking/parking_lot_model.dart';

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

  Position? _lastPosition;

  Future<void> _init() async {
    try {
      final position = await _determinePosition();
      if (!ref.mounted) return;
      _lastPosition = position;
      state = state.copyWith(userPosition: _lastPosition);
      await fetchLots();
    } catch (e) {
      if (!ref.mounted) return;
      if (state.isLoading) {
        state = state.copyWith(isLoading: false, error: ErrorHandler.handle(e));
      }
    }
  }

  Future<void> fetchLots({String? query}) async {
    state = state.copyWith(isLoading: true, searchQuery: query);

    try {
      final service = ref.read(parkingServiceProvider);
      final lots = await service.fetchParkingLots(
        search: query,
        latitude: _lastPosition?.latitude,
        longitude: _lastPosition?.longitude,
      );

      if (lots.isNotEmpty) {
        final currentLotId = state.lot?.id;
        final selectedLot =
            (currentLotId != null && lots.any((l) => l.id == currentLotId))
            ? state.lot
            : lots[0];

        state = state.copyWith(isLoading: false, lots: lots, lot: selectedLot);

        if (selectedLot?.id != currentLotId || query == null) {
          if (selectedLot != null) {
            await _fetchSuggestions(selectedLot.id);
            _initStream();
          }
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          lots: [],
          lot: null,
          slots: [],
          suggestions: [],
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: ErrorHandler.handle(e));
    }
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      talker.warning('Location services are disabled.');
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        talker.warning('Location permissions are denied');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      talker.warning(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> selectLot(ParkingLotModel selectedLot) async {
    if (state.lot?.id == selectedLot.id) return;

    _subscription?.cancel();
    state = state.copyWith(isLoading: true, lot: selectedLot, slots: []);

    await _fetchSuggestions(selectedLot.id);
    _initStream();
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
    if (lotId == null) return;

    final stream = ref
        .read(parkingServiceProvider)
        .streamParkingSlots(lotId: lotId);
    _subscription = stream.listen(
      (slots) {
        state = state.copyWith(isLoading: false, slots: slots, error: null);
      },
      onError: (e) {
        state = state.copyWith(isLoading: false, error: ErrorHandler.handle(e));
      },
    );
  }
}
