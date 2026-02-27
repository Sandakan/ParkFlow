part of '../router_provider.dart';

@TypedStatefulShellRoute<AdminShellRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<AdminDashboardBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<AdminDashboardRoute>(path: AdminDashboardRoute.path),
      ],
    ),
    TypedStatefulShellBranch<AdminParkingLotsBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<AdminParkingLotsRoute>(
          path: AdminParkingLotsRoute.path,
          routes: [
            TypedGoRoute<AdminCreateParkingLotRoute>(path: 'create'),
            TypedGoRoute<AdminEditParkingLotRoute>(path: 'edit/:lotId'),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<AdminCamerasBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<AdminCamerasRoute>(path: AdminCamerasRoute.path),
      ],
    ),
    TypedStatefulShellBranch<AdminAnalyticsBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<AdminAnalyticsRoute>(path: AdminAnalyticsRoute.path),
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

class AdminDashboardBranch extends StatefulShellBranchData {
  const AdminDashboardBranch();
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

class ProfileBranch extends StatefulShellBranchData {
  const ProfileBranch();
}

class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();
  static const path = '/profile';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfileScreen();
  }
}
