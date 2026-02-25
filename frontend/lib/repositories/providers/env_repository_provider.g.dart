// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(envRepository)
final envRepositoryProvider = EnvRepositoryProvider._();

final class EnvRepositoryProvider
    extends
        $FunctionalProvider<
          EnvRepositoryInterface,
          EnvRepositoryInterface,
          EnvRepositoryInterface
        >
    with $Provider<EnvRepositoryInterface> {
  EnvRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'envRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$envRepositoryHash();

  @$internal
  @override
  $ProviderElement<EnvRepositoryInterface> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EnvRepositoryInterface create(Ref ref) {
    return envRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EnvRepositoryInterface value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EnvRepositoryInterface>(value),
    );
  }
}

String _$envRepositoryHash() => r'8f1045ecafec4296d4e782487a673d224f72bbc5';
