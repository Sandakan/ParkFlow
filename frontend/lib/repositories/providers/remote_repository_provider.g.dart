// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(remoteRepository)
final remoteRepositoryProvider = RemoteRepositoryProvider._();

final class RemoteRepositoryProvider
    extends
        $FunctionalProvider<
          RemoteRepositoryInterface,
          RemoteRepositoryInterface,
          RemoteRepositoryInterface
        >
    with $Provider<RemoteRepositoryInterface> {
  RemoteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteRepositoryHash();

  @$internal
  @override
  $ProviderElement<RemoteRepositoryInterface> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RemoteRepositoryInterface create(Ref ref) {
    return remoteRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoteRepositoryInterface value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoteRepositoryInterface>(value),
    );
  }
}

String _$remoteRepositoryHash() => r'9e14d416f2c1bd0f87af814bf8d3cd63d350e42d';
