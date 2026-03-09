// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_create_parking_lot_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdminCreateParkingLot)
final adminCreateParkingLotProvider = AdminCreateParkingLotProvider._();

final class AdminCreateParkingLotProvider
    extends $NotifierProvider<AdminCreateParkingLot, bool> {
  AdminCreateParkingLotProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminCreateParkingLotProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminCreateParkingLotHash();

  @$internal
  @override
  AdminCreateParkingLot create() => AdminCreateParkingLot();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$adminCreateParkingLotHash() =>
    r'4251337333b541485d31bf3a50c48b10cd72e0d3';

abstract class _$AdminCreateParkingLot extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
