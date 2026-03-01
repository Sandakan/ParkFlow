// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cameras_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CamerasNotifier)
final camerasProvider = CamerasNotifierProvider._();

final class CamerasNotifierProvider
    extends $NotifierProvider<CamerasNotifier, CamerasState> {
  CamerasNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'camerasProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$camerasNotifierHash();

  @$internal
  @override
  CamerasNotifier create() => CamerasNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CamerasState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CamerasState>(value),
    );
  }
}

String _$camerasNotifierHash() => r'bfbc35810b415d259b57b6c4dae1c277b2c02b47';

abstract class _$CamerasNotifier extends $Notifier<CamerasState> {
  CamerasState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CamerasState, CamerasState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CamerasState, CamerasState>,
              CamerasState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
