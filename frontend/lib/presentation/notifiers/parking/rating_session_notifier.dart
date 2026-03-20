import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rating_session_notifier.g.dart';

@Riverpod(keepAlive: true)
class RatingSessionNotifier extends _$RatingSessionNotifier {
  @override
  Set<String> build() {
    return {};
  }

  void markAsShown(String reservationId) {
    state = {...state, reservationId};
  }

  bool hasBeenShown(String reservationId) {
    return state.contains(reservationId);
  }
}
