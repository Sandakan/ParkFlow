import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/presentation/states/auth/auth_state.dart';
import 'package:parkflow/presentation/screens/boot/boot_screen.dart';
import 'package:parkflow/presentation/screens/dashboard/admin_dashboard_screen.dart';
import 'package:parkflow/presentation/screens/home/home_screen.dart';
import 'package:parkflow/presentation/screens/auth/login_screen.dart';
import 'package:parkflow/presentation/screens/auth/register_screen.dart';
import 'package:parkflow/presentation/screens/home/profile_screen.dart';
import 'package:parkflow/presentation/screens/main/main_layout_screen.dart';
import 'package:parkflow/presentation/screens/admin/admin_parking_lots_screen.dart';
import 'package:parkflow/presentation/screens/admin/admin_create_parking_lot_screen.dart';
import 'package:parkflow/presentation/screens/admin/admin_cameras_screen.dart';
import 'package:parkflow/presentation/screens/admin/admin_analytics_screen.dart';
import 'package:parkflow/presentation/screens/admin/admin_edit_parking_lot_screen.dart';
import 'package:parkflow/presentation/screens/admin/admin_settings_screen.dart';

part 'router_provider.g.dart';

part 'parts/boot_routes.dart';
part 'parts/auth_routes.dart';
part 'parts/home_routes.dart';
part 'parts/admin_routes.dart';
part 'parts/main_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

@riverpod
class RouterListenable extends _$RouterListenable with ChangeNotifier {
  @override
  void build() {
    ref.listen(authProvider, (_, _) => notifyListeners());
  }
}

@riverpod
GoRouter router(Ref ref) {
  final refreshListenable = ref.watch(routerListenableProvider.notifier);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: BootRoute.path,
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final authState = ref.read(authProvider);

      if (authState.isLoading) return null;

      final isGoingToLogin = state.matchedLocation == LoginRoute.path;
      final isGoingToRegister = state.matchedLocation == RegisterRoute.path;
      final isBooting = state.matchedLocation == BootRoute.path;

      final isAuth = authState.user != null;
      final isAdmin = authState.isAdmin;

      if (isBooting) {
        if (isAuth) {
          if (isAdmin) return AdminDashboardRoute.path;
          if (authState.isDriver) return HomeRoute.path;
          return HomeRoute.path;
        }
        if (!authState.isLoading && authState != const AuthState.initial()) {
          return LoginRoute.path;
        }
        return null;
      }

      if (!isAuth && !isGoingToLogin && !isGoingToRegister) {
        return LoginRoute.path;
      }

      if (isAuth) {
        if (isGoingToLogin || isGoingToRegister) {
          if (isAdmin) return AdminDashboardRoute.path;
          if (authState.isDriver) return HomeRoute.path;
          return HomeRoute.path;
        }

        final isGoingToAdmin =
            state.matchedLocation == AdminDashboardRoute.path;
        final isGoingToHome = state.matchedLocation == HomeRoute.path;

        if (isAdmin && isGoingToHome) {
          return AdminDashboardRoute.path;
        }
        if (!isAdmin && isGoingToAdmin) {
          return HomeRoute.path;
        }
      }

      return null;
    },
    routes: $appRoutes,
  );
}
