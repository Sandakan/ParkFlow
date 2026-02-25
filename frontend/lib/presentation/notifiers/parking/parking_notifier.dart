import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/services/parking_service.dart';
import 'package:parkflow/presentation/states/parking/parking_state.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';

part 'parking_notifier.g.dart';

@riverpod
class ParkingNotifier extends _$ParkingNotifier {
  StreamSubscription? _subscription;

  @override
  ParkingState build() {
    _initStream();

    ref.onDispose(() {
      _subscription?.cancel();
    });

    return const ParkingState(isLoading: true);
  }

  void _initStream() {
    final stream = ref.read(parkingServiceProvider).streamParkingSlots();
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
