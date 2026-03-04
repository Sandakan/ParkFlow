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

class AdminCreateParkingLotRoute extends GoRouteData
    with $AdminCreateParkingLotRoute {
  const AdminCreateParkingLotRoute();
  static const path = 'create';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminCreateParkingLotScreen();
  }
}

class AdminEditParkingLotRoute extends GoRouteData
    with $AdminEditParkingLotRoute {
  final String lotId;
  const AdminEditParkingLotRoute(this.lotId);

  static const path = 'edit/:lotId';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AdminEditParkingLotScreen(lotId: lotId);
  }
}

class AdminParkingLotDetailsRoute extends GoRouteData
    with $AdminParkingLotDetailsRoute {
  final String lotId;
  const AdminParkingLotDetailsRoute(this.lotId);

  static const path = ':lotId';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AdminParkingLotDetailsScreen(lotId: lotId);
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

class AdminCreateCameraRoute extends GoRouteData with $AdminCreateCameraRoute {
  const AdminCreateCameraRoute();
  static const path = 'create';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminCreateCameraScreen();
  }
}

class AdminCameraInfoRoute extends GoRouteData with $AdminCameraInfoRoute {
  final String cameraId;
  const AdminCameraInfoRoute(this.cameraId);

  static const path = ':cameraId';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AdminCameraInfoScreen(cameraId: cameraId);
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
