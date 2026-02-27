part of '../router_provider.dart';

@TypedGoRoute<BootRoute>(path: '/boot')
class BootRoute extends GoRouteData with $BootRoute {
  const BootRoute();

  static const path = '/boot';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BootScreen();
  }
}
