// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VehicleNotifier)
final vehicleProvider = VehicleNotifierProvider._();

final class VehicleNotifierProvider
    extends $NotifierProvider<VehicleNotifier, VehicleActionState> {
  VehicleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vehicleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vehicleNotifierHash();

  @$internal
  @override
  VehicleNotifier create() => VehicleNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VehicleActionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VehicleActionState>(value),
    );
  }
}

String _$vehicleNotifierHash() => r'52363c86cb0a0973928a3769ec46185e5edc361e';

abstract class _$VehicleNotifier extends $Notifier<VehicleActionState> {
  VehicleActionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<VehicleActionState, VehicleActionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<VehicleActionState, VehicleActionState>,
              VehicleActionState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
