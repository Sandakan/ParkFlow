// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_info_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CameraInfo)
final cameraInfoProvider = CameraInfoFamily._();

final class CameraInfoProvider
    extends $NotifierProvider<CameraInfo, CameraInfoState> {
  CameraInfoProvider._({
    required CameraInfoFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'cameraInfoProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$cameraInfoHash();

  @override
  String toString() {
    return r'cameraInfoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CameraInfo create() => CameraInfo();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CameraInfoState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CameraInfoState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CameraInfoProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$cameraInfoHash() => r'13ff263be61ee54121941e1b4d54101cdaaa0eaa';

final class CameraInfoFamily extends $Family
    with
        $ClassFamilyOverride<
          CameraInfo,
          CameraInfoState,
          CameraInfoState,
          CameraInfoState,
          String
        > {
  CameraInfoFamily._()
    : super(
        retry: null,
        name: r'cameraInfoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CameraInfoProvider call(String cameraId) =>
      CameraInfoProvider._(argument: cameraId, from: this);

  @override
  String toString() => r'cameraInfoProvider';
}

abstract class _$CameraInfo extends $Notifier<CameraInfoState> {
  late final _$args = ref.$arg as String;
  String get cameraId => _$args;

  CameraInfoState build(String cameraId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CameraInfoState, CameraInfoState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CameraInfoState, CameraInfoState>,
              CameraInfoState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
