// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(parkingService)
final parkingServiceProvider = ParkingServiceProvider._();

final class ParkingServiceProvider
    extends $FunctionalProvider<ParkingService, ParkingService, ParkingService>
    with $Provider<ParkingService> {
  ParkingServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'parkingServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$parkingServiceHash();

  @$internal
  @override
  $ProviderElement<ParkingService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ParkingService create(Ref ref) {
    return parkingService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ParkingService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ParkingService>(value),
    );
  }
}

String _$parkingServiceHash() => r'90b02f0bd0e8da62370a5d76cce0e1519b81d8de';
