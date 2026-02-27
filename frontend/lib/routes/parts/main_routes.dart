part of '../router_provider.dart';

@TypedStatefulShellRoute<AdminShellRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<AdminDashboardBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<AdminDashboardRoute>(path: AdminDashboardRoute.path),
      ],
    ),
    TypedStatefulShellBranch<VideoFeedBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<VideoFeedRoute>(path: VideoFeedRoute.path),
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

class VideoFeedBranch extends StatefulShellBranchData {
  const VideoFeedBranch();
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
