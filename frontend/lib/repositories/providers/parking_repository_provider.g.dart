// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(parkingRepository)
final parkingRepositoryProvider = ParkingRepositoryProvider._();

final class ParkingRepositoryProvider
    extends
        $FunctionalProvider<
          ParkingRepositoryInterface,
          ParkingRepositoryInterface,
          ParkingRepositoryInterface
        >
    with $Provider<ParkingRepositoryInterface> {
  ParkingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'parkingRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$parkingRepositoryHash();

  @$internal
  @override
  $ProviderElement<ParkingRepositoryInterface> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ParkingRepositoryInterface create(Ref ref) {
    return parkingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ParkingRepositoryInterface value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ParkingRepositoryInterface>(value),
    );
  }
}

String _$parkingRepositoryHash() => r'4b1fb14205e02606e601178f7b8d5312b2401b30';
