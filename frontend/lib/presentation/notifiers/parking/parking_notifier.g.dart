// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ParkingNotifier)
final parkingProvider = ParkingNotifierProvider._();

final class ParkingNotifierProvider
    extends $NotifierProvider<ParkingNotifier, ParkingState> {
  ParkingNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'parkingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$parkingNotifierHash();

  @$internal
  @override
  ParkingNotifier create() => ParkingNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ParkingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ParkingState>(value),
    );
  }
}

String _$parkingNotifierHash() => r'4ac9fc6dcd3c035d53aa69122a378132ea7f3914';

abstract class _$ParkingNotifier extends $Notifier<ParkingState> {
  ParkingState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ParkingState, ParkingState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ParkingState, ParkingState>,
              ParkingState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
