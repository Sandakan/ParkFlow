// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_session_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RatingSessionNotifier)
final ratingSessionProvider = RatingSessionNotifierProvider._();

final class RatingSessionNotifierProvider
    extends $NotifierProvider<RatingSessionNotifier, Set<String>> {
  RatingSessionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ratingSessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ratingSessionNotifierHash();

  @$internal
  @override
  RatingSessionNotifier create() => RatingSessionNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$ratingSessionNotifierHash() =>
    r'2cd0c03cdc2cdc634f4f612125036832b9a6543d';

abstract class _$RatingSessionNotifier extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
