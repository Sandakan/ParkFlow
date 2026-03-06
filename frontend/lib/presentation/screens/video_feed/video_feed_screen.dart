import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/presentation/notifiers/cameras/video_feed_provider.dart';

class VideoFeedScreen extends ConsumerWidget {
  const VideoFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(videoFeedProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.liveFeed)),
      body: Center(
        child: feedState.isInitialized
            ? AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.black),
                  child: RTCVideoView(
                    feedState.renderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  ),
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
