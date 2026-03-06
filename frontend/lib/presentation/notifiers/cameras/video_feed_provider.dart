import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_feed_provider.g.dart';

class VideoFeedState {
  final RTCVideoRenderer renderer;
  final bool isInitialized;

  VideoFeedState({required this.renderer, required this.isInitialized});
}

@riverpod
class VideoFeed extends _$VideoFeed {
  @override
  VideoFeedState build() {
    final renderer = RTCVideoRenderer();

    // Start initialization async
    _initRenderer(renderer);

    ref.onDispose(() {
      renderer.dispose();
    });

    return VideoFeedState(renderer: renderer, isInitialized: false);
  }

  Future<void> _initRenderer(RTCVideoRenderer renderer) async {
    await renderer.initialize();

    state = VideoFeedState(renderer: renderer, isInitialized: true);
  }
}
