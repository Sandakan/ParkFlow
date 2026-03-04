import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parkflow/models/parking/parking_slot_model.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/models/parking/parking_lot_model.dart';
import 'package:parkflow/core/network/entities/get_parking_suggestions_response_entity.dart';

part 'parking_state.freezed.dart';

@freezed
abstract class ParkingState with _$ParkingState {
  const factory ParkingState({
    @Default(true) bool isLoading,
    @Default([]) List<ParkingSlotModel> slots,
    @Default([]) List<ParkingSuggestionEntity> suggestions,
    ParkingLotModel? lot,
    AppException? error,
  }) = _ParkingState;
}
