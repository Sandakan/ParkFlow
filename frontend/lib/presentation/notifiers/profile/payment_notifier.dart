import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/services/payment_service.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';

part 'payment_notifier.g.dart';

@riverpod
class PaymentNotifier extends _$PaymentNotifier {
  @override
  void build() {
    return;
  }

  Future<void> addPaymentMethod(
    String provider,
    String type, {
    String? last4,
    bool isDefault = false,
  }) async {
    try {
      await ref
          .read(paymentServiceProvider)
          .addPaymentMethod(provider, type, last4: last4, isDefault: isDefault);
      await ref.read(authProvider.notifier).refreshUser();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removePaymentMethod(String methodId) async {
    try {
      await ref.read(paymentServiceProvider).removePaymentMethod(methodId);
      await ref.read(authProvider.notifier).refreshUser();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setDefaultPaymentMethod(String methodId) async {
    try {
      await ref.read(paymentServiceProvider).setDefaultPaymentMethod(methodId);
      await ref.read(authProvider.notifier).refreshUser();
    } catch (e) {
      rethrow;
    }
  }
}
