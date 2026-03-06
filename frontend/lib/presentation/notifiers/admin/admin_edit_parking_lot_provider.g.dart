// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_edit_parking_lot_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdminEditParkingLot)
final adminEditParkingLotProvider = AdminEditParkingLotFamily._();

final class AdminEditParkingLotProvider
    extends $NotifierProvider<AdminEditParkingLot, AdminEditParkingLotState> {
  AdminEditParkingLotProvider._({
    required AdminEditParkingLotFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'adminEditParkingLotProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$adminEditParkingLotHash();

  @override
  String toString() {
    return r'adminEditParkingLotProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AdminEditParkingLot create() => AdminEditParkingLot();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminEditParkingLotState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminEditParkingLotState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AdminEditParkingLotProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminEditParkingLotHash() =>
    r'ffca7f3e5ac57ce2b3190a368be8696d31bfa132';

final class AdminEditParkingLotFamily extends $Family
    with
        $ClassFamilyOverride<
          AdminEditParkingLot,
          AdminEditParkingLotState,
          AdminEditParkingLotState,
          AdminEditParkingLotState,
          String
        > {
  AdminEditParkingLotFamily._()
    : super(
        retry: null,
        name: r'adminEditParkingLotProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AdminEditParkingLotProvider call(String lotId) =>
      AdminEditParkingLotProvider._(argument: lotId, from: this);

  @override
  String toString() => r'adminEditParkingLotProvider';
}

abstract class _$AdminEditParkingLot
    extends $Notifier<AdminEditParkingLotState> {
  late final _$args = ref.$arg as String;
  String get lotId => _$args;

  AdminEditParkingLotState build(String lotId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AdminEditParkingLotState, AdminEditParkingLotState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AdminEditParkingLotState, AdminEditParkingLotState>,
              AdminEditParkingLotState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
