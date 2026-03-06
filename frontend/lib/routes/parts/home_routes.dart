part of '../router_provider.dart';

class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  static const path = '/home';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

class LotDetailsRoute extends GoRouteData with $LotDetailsRoute {
  const LotDetailsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LotDetailsScreen();
  }
}
