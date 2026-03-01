// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_api_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(httpApi)
final httpApiProvider = HttpApiProvider._();

final class HttpApiProvider
    extends $FunctionalProvider<HttpApi, HttpApi, HttpApi>
    with $Provider<HttpApi> {
  HttpApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'httpApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$httpApiHash();

  @$internal
  @override
  $ProviderElement<HttpApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HttpApi create(Ref ref) {
    return httpApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HttpApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HttpApi>(value),
    );
  }
}

String _$httpApiHash() => r'27f8d5c4ca06048ad7456bf2373b567f7d41267d';
