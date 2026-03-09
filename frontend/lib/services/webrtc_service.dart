import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:parkflow/repositories/entities/camera/create_webrtc_offer_request.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';

class WebRTCService {
  final Ref ref;

  WebRTCService(this.ref);

  Future<RTCPeerConnection> createCameraConnection(
    String cameraId,
    Function(RTCVideoRenderer) onTrack,
  ) async {
    // ICE (Interactive Connectivity Establishment) configuration.
    // This setup allows the app to find the best path for video data to travel
    // from the backend/MediaMTX to the frontend, even through strict firewalls or NATs.
    final configuration = {
      'iceServers': [
        // STUN (Session Traversal Utilities for NAT):
        // Helps the device discover its own public IP address.
        {'urls': 'stun:stun.l.google.com:19302'},

        // TURN (Traversal Using Relays around NAT):
        // Relays video data through a third-party server if a direct peer-to-peer
        // connection is blocked by strict firewalls (e.g. corporate or 5G networks).
        {
          'urls': 'turn:openrelay.metered.ca:80',
          'username': 'openrelayproject',
          'credential': 'openrelayproject',
        },
        {
          'urls': 'turn:openrelay.metered.ca:443',
          'username': 'openrelayproject',
          'credential': 'openrelayproject',
        },
        {
          'urls': 'turn:openrelay.metered.ca:443?transport=tcp',
          'username': 'openrelayproject',
          'credential': 'openrelayproject',
        },
      ],
    };

    final pc = await createPeerConnection(configuration);

    pc.onTrack = (RTCTrackEvent event) {
      if (event.track.kind == 'video') {
        final renderer = RTCVideoRenderer();
        renderer.initialize().then((_) {
          renderer.srcObject = event.streams.isNotEmpty
              ? event.streams[0]
              : null;
          onTrack(renderer);
        });
      }
    };

    // Add a transceiver to receive video
    await pc.addTransceiver(
      kind: RTCRtpMediaType.RTCRtpMediaTypeVideo,
      init: RTCRtpTransceiverInit(direction: TransceiverDirection.RecvOnly),
    );

    // Add audio transceiver as well just in case the backend sends it
    await pc.addTransceiver(
      kind: RTCRtpMediaType.RTCRtpMediaTypeAudio,
      init: RTCRtpTransceiverInit(direction: TransceiverDirection.RecvOnly),
    );

    final offer = await pc.createOffer();
    await pc.setLocalDescription(offer);

    // Wait for ICE gathering to complete (up to 8 seconds) so the generated SDP contains all candidates natively.
    // Metred TURN servers can take a few seconds to respond.
    int elapsed = 0;
    while (pc.iceGatheringState !=
            RTCIceGatheringState.RTCIceGatheringStateComplete &&
        elapsed < 80) {
      await Future.delayed(const Duration(milliseconds: 100));
      elapsed++;
    }

    // Get the final offer with candidates built-in
    final finalOffer = await pc.getLocalDescription();

    final remote = ref.read(remoteRepositoryProvider);
    final token = await ref.read(authProvider.notifier).getValidAccessToken();

    try {
      final response = await remote.sendWebrtcOffer(
        cameraId,
        CreateWebrtcOfferRequest(
          sdp: finalOffer?.sdp ?? offer.sdp ?? '',
          type: finalOffer?.type ?? offer.type ?? '',
        ),
        accessToken: token,
      );

      final answer = RTCSessionDescription(response.sdp, response.type);
      await pc.setRemoteDescription(answer);
    } catch (e) {
      await pc.dispose();
      rethrow;
    }

    return pc;
  }
}

final webrtcServiceProvider = Provider<WebRTCService>((ref) {
  return WebRTCService(ref);
});
