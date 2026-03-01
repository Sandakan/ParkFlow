import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parkflow/models/parking/parking_slot_model.dart';
import 'package:parkflow/core/app_exception.dart';

part 'parking_state.freezed.dart';

@freezed
abstract class ParkingState with _$ParkingState {
  const factory ParkingState({
    @Default(true) bool isLoading,
    @Default([]) List<ParkingSlotModel> slots,
    AppException? error,
  }) = _ParkingState;
}
