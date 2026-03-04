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
        isAutoDispose: false,
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

String _$parkingServiceHash() => r'a2136251529bec53eeff2fb47c5cee2c7f5de458';
