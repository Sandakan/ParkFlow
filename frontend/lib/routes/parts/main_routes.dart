part of '../router_provider.dart';

@TypedStatefulShellRoute<AdminShellRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<AdminAnalyticsBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<AdminAnalyticsRoute>(path: AdminAnalyticsRoute.path),
      ],
    ),
    TypedStatefulShellBranch<AdminParkingLotsBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<AdminParkingLotsRoute>(
          path: AdminParkingLotsRoute.path,
          routes: [
            TypedGoRoute<AdminCreateParkingLotRoute>(
              path: AdminCreateParkingLotRoute.path,
            ),
            TypedGoRoute<AdminEditParkingLotRoute>(
              path: AdminEditParkingLotRoute.path,
            ),
            TypedGoRoute<AdminParkingLotDetailsRoute>(
              path: AdminParkingLotDetailsRoute.path,
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<AdminCamerasBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<AdminCamerasRoute>(
          path: AdminCamerasRoute.path,
          routes: [
            TypedGoRoute<AdminCreateCameraRoute>(
              path: AdminCreateCameraRoute.path,
            ),
            TypedGoRoute<AdminCameraInfoRoute>(path: AdminCameraInfoRoute.path),
          ],
        ),
      ],
    ),

    TypedStatefulShellBranch<AdminSettingsBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<AdminSettingsRoute>(path: AdminSettingsRoute.path),
      ],
    ),
  ],
)
class AdminShellRoute extends StatefulShellRouteData {
  const AdminShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return MainLayoutScreen(navigationShell: navigationShell);
  }
}

class AdminParkingLotsBranch extends StatefulShellBranchData {
  const AdminParkingLotsBranch();
}

class AdminCamerasBranch extends StatefulShellBranchData {
  const AdminCamerasBranch();
}

class AdminAnalyticsBranch extends StatefulShellBranchData {
  const AdminAnalyticsBranch();
}

class AdminSettingsBranch extends StatefulShellBranchData {
  const AdminSettingsBranch();
}

@TypedStatefulShellRoute<DriverShellRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeRoute>(path: HomeRoute.path),
      ],
    ),
    TypedStatefulShellBranch<BookingsBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<BookingsRoute>(path: BookingsRoute.path),
      ],
    ),
    TypedStatefulShellBranch<MyVehicleBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<MyVehicleRoute>(path: MyVehicleRoute.path),
      ],
    ),
    TypedStatefulShellBranch<ProfileBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ProfileRoute>(path: ProfileRoute.path),
      ],
    ),
  ],
)
class DriverShellRoute extends StatefulShellRouteData {
  const DriverShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return MainLayoutScreen(navigationShell: navigationShell);
  }
}

class HomeBranch extends StatefulShellBranchData {
  const HomeBranch();
}

class BookingsBranch extends StatefulShellBranchData {
  const BookingsBranch();
}

class MyVehicleBranch extends StatefulShellBranchData {
  const MyVehicleBranch();
}

class ProfileBranch extends StatefulShellBranchData {
  const ProfileBranch();
}

class BookingsRoute extends GoRouteData with $BookingsRoute {
  const BookingsRoute();
  static const path = '/bookings';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BookingsScreen();
  }
}

class MyVehicleRoute extends GoRouteData with $MyVehicleRoute {
  const MyVehicleRoute();
  static const path = '/my-vehicle';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MyVehicleScreen();
  }
}

class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();
  static const path = '/profile';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfileScreen();
  }
}
