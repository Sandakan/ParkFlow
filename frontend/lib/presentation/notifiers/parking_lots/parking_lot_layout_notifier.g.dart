// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_lot_layout_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ParkingLotLayout)
final parkingLotLayoutProvider = ParkingLotLayoutFamily._();

final class ParkingLotLayoutProvider
    extends $NotifierProvider<ParkingLotLayout, ParkingState> {
  ParkingLotLayoutProvider._({
    required ParkingLotLayoutFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'parkingLotLayoutProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$parkingLotLayoutHash();

  @override
  String toString() {
    return r'parkingLotLayoutProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ParkingLotLayout create() => ParkingLotLayout();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ParkingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ParkingState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ParkingLotLayoutProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$parkingLotLayoutHash() => r'9fb8ad3b0f19bef783c62cc512248c07c3618018';

final class ParkingLotLayoutFamily extends $Family
    with
        $ClassFamilyOverride<
          ParkingLotLayout,
          ParkingState,
          ParkingState,
          ParkingState,
          String
        > {
  ParkingLotLayoutFamily._()
    : super(
        retry: null,
        name: r'parkingLotLayoutProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ParkingLotLayoutProvider call(String lotId) =>
      ParkingLotLayoutProvider._(argument: lotId, from: this);

  @override
  String toString() => r'parkingLotLayoutProvider';
}

abstract class _$ParkingLotLayout extends $Notifier<ParkingState> {
  late final _$args = ref.$arg as String;
  String get lotId => _$args;

  ParkingState build(String lotId);
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
    element.handleCreate(ref, () => build(_$args));
  }
}
