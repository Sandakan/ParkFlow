part of '../router_provider.dart';

@TypedGoRoute<VideoFeedRoute>(path: '/video-feed')
class VideoFeedRoute extends GoRouteData with $VideoFeedRoute {
  const VideoFeedRoute();

  static const path = '/video-feed';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const VideoFeedScreen();
  }
}
