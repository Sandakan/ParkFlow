// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReservationNotifier)
final reservationNotifierProvider = ReservationNotifierProvider._();

final class ReservationNotifierProvider
    extends
        $AsyncNotifierProvider<ReservationNotifier, List<ReservationModel>> {
  ReservationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reservationNotifierProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reservationNotifierHash();

  @$internal
  @override
  ReservationNotifier create() => ReservationNotifier();
}

String _$reservationNotifierHash() =>
    r'5df00a8fd8e0b4aebb8d602294fe50c06012bb0f';

abstract class _$ReservationNotifier
    extends $AsyncNotifier<List<ReservationModel>> {
  FutureOr<List<ReservationModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<ReservationModel>>, List<ReservationModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ReservationModel>>,
                List<ReservationModel>
              >,
              AsyncValue<List<ReservationModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
