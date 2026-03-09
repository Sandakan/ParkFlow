// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PaymentNotifier)
final paymentProvider = PaymentNotifierProvider._();

final class PaymentNotifierProvider
    extends $NotifierProvider<PaymentNotifier, PaymentActionState> {
  PaymentNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paymentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paymentNotifierHash();

  @$internal
  @override
  PaymentNotifier create() => PaymentNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaymentActionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaymentActionState>(value),
    );
  }
}

String _$paymentNotifierHash() => r'df727786ffae02faf7de41755cc1041c3fda6730';

abstract class _$PaymentNotifier extends $Notifier<PaymentActionState> {
  PaymentActionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PaymentActionState, PaymentActionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PaymentActionState, PaymentActionState>,
              PaymentActionState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
