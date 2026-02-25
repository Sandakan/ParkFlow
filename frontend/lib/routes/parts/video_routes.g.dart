// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$videoFeedRoute];

RouteBase get $videoFeedRoute => GoRouteData.$route(
  path: '/video-feed',
  factory: $VideoFeedRoute._fromState,
);

mixin $VideoFeedRoute on GoRouteData {
  static VideoFeedRoute _fromState(GoRouterState state) =>
      const VideoFeedRoute();

  @override
  String get location => GoRouteData.$location('/video-feed');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
