import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parkflow/models/parking/parking_lot_model.dart';

part 'parking_lots_state.freezed.dart';

@freezed
abstract class ParkingLotsState with _$ParkingLotsState {
  const factory ParkingLotsState({
    @Default([]) List<ParkingLotModel> lots,
    @Default(true) bool isLoading,
    String? error,
    @Default('') String searchQuery,
  }) = _ParkingLotsState;
}
