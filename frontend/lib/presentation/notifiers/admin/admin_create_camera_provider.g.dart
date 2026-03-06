// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_create_camera_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdminCreateCamera)
final adminCreateCameraProvider = AdminCreateCameraProvider._();

final class AdminCreateCameraProvider
    extends $NotifierProvider<AdminCreateCamera, bool> {
  AdminCreateCameraProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminCreateCameraProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminCreateCameraHash();

  @$internal
  @override
  AdminCreateCamera create() => AdminCreateCamera();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$adminCreateCameraHash() => r'3407257ed867b34748510f1c3261614d35cbb3af';

abstract class _$AdminCreateCamera extends $Notifier<bool> {
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
