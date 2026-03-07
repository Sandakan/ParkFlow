import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parkflow/core/app_exception.dart';

part 'payment_action_state.freezed.dart';

@freezed
abstract class PaymentActionState with _$PaymentActionState {
  const factory PaymentActionState({
    @Default(false) bool isLoading,
    AppException? error,
  }) = _PaymentActionState;
}
