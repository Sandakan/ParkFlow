// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reservationService)
final reservationServiceProvider = ReservationServiceProvider._();

final class ReservationServiceProvider
    extends
        $FunctionalProvider<
          ReservationService,
          ReservationService,
          ReservationService
        >
    with $Provider<ReservationService> {
  ReservationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reservationServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reservationServiceHash();

  @$internal
  @override
  $ProviderElement<ReservationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReservationService create(Ref ref) {
    return reservationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReservationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReservationService>(value),
    );
  }
}

String _$reservationServiceHash() =>
    r'800ec24d788d8225b12fb5574bb434511a2d38e4';
