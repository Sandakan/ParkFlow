import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/services/payment_service.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/presentation/states/profile/payment_action_state.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';

part 'payment_notifier.g.dart';

@riverpod
class PaymentNotifier extends _$PaymentNotifier {
  @override
  PaymentActionState build() {
    return const PaymentActionState();
  }

  Future<void> addPaymentMethod(
    String provider,
    String type, {
    String? last4,
    bool isDefault = false,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await ref
          .read(paymentServiceProvider)
          .addPaymentMethod(provider, type, last4: last4, isDefault: isDefault);
      await ref.read(authProvider.notifier).refreshUser();
      state = state.copyWith(isLoading: false);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      state = state.copyWith(isLoading: false, error: error);
      rethrow;
    }
  }

  Future<void> removePaymentMethod(String methodId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await ref.read(paymentServiceProvider).removePaymentMethod(methodId);
      await ref.read(authProvider.notifier).refreshUser();
      state = state.copyWith(isLoading: false);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      state = state.copyWith(isLoading: false, error: error);
      rethrow;
    }
  }

  Future<void> setDefaultPaymentMethod(String methodId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await ref.read(paymentServiceProvider).setDefaultPaymentMethod(methodId);
      await ref.read(authProvider.notifier).refreshUser();
      state = state.copyWith(isLoading: false);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      state = state.copyWith(isLoading: false, error: error);
      rethrow;
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
