// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secure_storage_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(secureStorageRepository)
final secureStorageRepositoryProvider = SecureStorageRepositoryProvider._();

final class SecureStorageRepositoryProvider
    extends
        $FunctionalProvider<
          SecureStorageRepositoryInterface,
          SecureStorageRepositoryInterface,
          SecureStorageRepositoryInterface
        >
    with $Provider<SecureStorageRepositoryInterface> {
  SecureStorageRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'secureStorageRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$secureStorageRepositoryHash();

  @$internal
  @override
  $ProviderElement<SecureStorageRepositoryInterface> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SecureStorageRepositoryInterface create(Ref ref) {
    return secureStorageRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SecureStorageRepositoryInterface value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SecureStorageRepositoryInterface>(
        value,
      ),
    );
  }
}

String _$secureStorageRepositoryHash() =>
    r'2b91f39bef98dbc2bef033c605f758a2a4d2b68a';
