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
        $StreamNotifierProvider<ReservationNotifier, List<ReservationModel>> {
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
    r'd54d76dac7603fc1c1aaab7a17da011abc9fd3b2';

abstract class _$ReservationNotifier
    extends $StreamNotifier<List<ReservationModel>> {
  Stream<List<ReservationModel>> build();
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
