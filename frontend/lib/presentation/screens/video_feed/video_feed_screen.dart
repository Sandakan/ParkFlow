import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/utils/constants/app_colors.dart';

class VideoFeedScreen extends ConsumerStatefulWidget {
  const VideoFeedScreen({super.key});

  @override
  ConsumerState<VideoFeedScreen> createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends ConsumerState<VideoFeedScreen> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  bool _isRendererInitialized = false;

  @override
  void initState() {
    super.initState();
    _initRenderer();
  }

  Future<void> _initRenderer() async {
    await _localRenderer.initialize();
    setState(() {
      _isRendererInitialized = true;
    });
    // Placeholder logic:
    // Usually, here we'd listen for signaling states, connect sockets, ICE candidates,
    // and map remoteStream to _localRenderer.srcObject
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.liveFeed)),
      body: Center(
        child: _isRendererInitialized
            ? AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: const BoxDecoration(color: AppColors.black),
                  child: RTCVideoView(
                    _localRenderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  ),
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
