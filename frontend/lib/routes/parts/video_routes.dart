import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parkflow/presentation/screens/video_feed/video_feed_screen.dart';

part 'video_routes.g.dart';

@TypedGoRoute<VideoFeedRoute>(path: '/video-feed')
class VideoFeedRoute extends GoRouteData with $VideoFeedRoute {
  const VideoFeedRoute();

  static const path = '/video-feed';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const VideoFeedScreen();
  }
}
