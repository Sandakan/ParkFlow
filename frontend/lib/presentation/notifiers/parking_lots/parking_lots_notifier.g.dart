// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_lots_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ParkingLotsNotifier)
final parkingLotsProvider = ParkingLotsNotifierProvider._();

final class ParkingLotsNotifierProvider
    extends $NotifierProvider<ParkingLotsNotifier, ParkingLotsState> {
  ParkingLotsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'parkingLotsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$parkingLotsNotifierHash();

  @$internal
  @override
  ParkingLotsNotifier create() => ParkingLotsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ParkingLotsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ParkingLotsState>(value),
    );
  }
}

String _$parkingLotsNotifierHash() =>
    r'4befa2df343ef64955dbae42274d282c21856409';

abstract class _$ParkingLotsNotifier extends $Notifier<ParkingLotsState> {
  ParkingLotsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ParkingLotsState, ParkingLotsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ParkingLotsState, ParkingLotsState>,
              ParkingLotsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
