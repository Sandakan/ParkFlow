part of '../router_provider.dart';

class AdminDashboardRoute extends GoRouteData with $AdminDashboardRoute {
  const AdminDashboardRoute();

  static const path = '/admin';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminDashboardScreen();
  }
}

class AdminParkingLotsRoute extends GoRouteData with $AdminParkingLotsRoute {
  const AdminParkingLotsRoute();
  static const path = '/admin/parking-lots';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminParkingLotsScreen();
  }
}

class AdminCamerasRoute extends GoRouteData with $AdminCamerasRoute {
  const AdminCamerasRoute();
  static const path = '/admin/cameras';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminCamerasScreen();
  }
}

class AdminAnalyticsRoute extends GoRouteData with $AdminAnalyticsRoute {
  const AdminAnalyticsRoute();
  static const path = '/admin/analytics';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminAnalyticsScreen();
  }
}

class AdminSettingsRoute extends GoRouteData with $AdminSettingsRoute {
  const AdminSettingsRoute();
  static const path = '/admin/settings';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminSettingsScreen();
  }
}
