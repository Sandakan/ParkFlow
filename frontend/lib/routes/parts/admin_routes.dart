part of '../router_provider.dart';

class AdminDashboardRoute extends GoRouteData with $AdminDashboardRoute {
  const AdminDashboardRoute();

  static const path = '/admin';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminDashboardScreen();
  }
}
