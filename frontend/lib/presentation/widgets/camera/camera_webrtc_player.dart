import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:parkflow/services/webrtc_service.dart';
import 'package:parkflow/presentation/notifiers/cameras/cameras_notifier.dart';
import 'package:parkflow/utils/constants/app_colors.dart';

class CameraWebrtcPlayer extends ConsumerStatefulWidget {
  final String cameraId;

  const CameraWebrtcPlayer({super.key, required this.cameraId});

  @override
  ConsumerState<CameraWebrtcPlayer> createState() => _CameraWebrtcPlayerState();
}

class _CameraWebrtcPlayerState extends ConsumerState<CameraWebrtcPlayer> {
  RTCVideoRenderer? _renderer;
  RTCPeerConnection? _peerConnection;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeWebrtc();
  }

  Future<void> _initializeWebrtc() async {
    try {
      final webrtcService = ref.read(webrtcServiceProvider);
      _peerConnection = await webrtcService.createCameraConnection(
        widget.cameraId,
        (renderer) {
          if (mounted) {
            ref
                .read(camerasProvider.notifier)
                .updateCameraHealth(widget.cameraId, true);

            setState(() {
              _renderer = renderer;
              _isLoading = false;
            });
          }
        },
      );
    } catch (e) {
      if (mounted) {
        ref
            .read(camerasProvider.notifier)
            .updateCameraHealth(widget.cameraId, false);

        setState(() {
          _errorMessage = 'Failed to load camera stream: ${e.toString()}';
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _renderer?.dispose();
    _peerConnection?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 48),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }

    if (_renderer == null) {
      return const Center(
        child: Text('No video stream', style: TextStyle(color: Colors.white)),
      );
    }

    return RTCVideoView(
      _renderer!,
      objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitContain,
    );
  }
}
