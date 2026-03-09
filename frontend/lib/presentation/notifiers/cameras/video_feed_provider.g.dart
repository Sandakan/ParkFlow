// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_feed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VideoFeed)
final videoFeedProvider = VideoFeedProvider._();

final class VideoFeedProvider
    extends $NotifierProvider<VideoFeed, VideoFeedState> {
  VideoFeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'videoFeedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$videoFeedHash();

  @$internal
  @override
  VideoFeed create() => VideoFeed();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VideoFeedState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VideoFeedState>(value),
    );
  }
}

String _$videoFeedHash() => r'17ec4bf9f6cc926e77fac8e29a9fed4d6349ebcd';

abstract class _$VideoFeed extends $Notifier<VideoFeedState> {
  VideoFeedState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<VideoFeedState, VideoFeedState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<VideoFeedState, VideoFeedState>,
              VideoFeedState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
