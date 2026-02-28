// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AnalyticsNotifier)
final analyticsProvider = AnalyticsNotifierProvider._();

final class AnalyticsNotifierProvider
    extends $NotifierProvider<AnalyticsNotifier, AnalyticsState> {
  AnalyticsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyticsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$analyticsNotifierHash();

  @$internal
  @override
  AnalyticsNotifier create() => AnalyticsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnalyticsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnalyticsState>(value),
    );
  }
}

String _$analyticsNotifierHash() => r'9bf46d68c7bfcfeea83d56fd795314015bb59532';

abstract class _$AnalyticsNotifier extends $Notifier<AnalyticsState> {
  AnalyticsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AnalyticsState, AnalyticsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AnalyticsState, AnalyticsState>,
              AnalyticsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
