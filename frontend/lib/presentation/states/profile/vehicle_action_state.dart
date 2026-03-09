import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parkflow/core/app_exception.dart';

part 'vehicle_action_state.freezed.dart';

@freezed
abstract class VehicleActionState with _$VehicleActionState {
  const factory VehicleActionState({
    @Default(false) bool isLoading,
    AppException? error,
  }) = _VehicleActionState;
}
