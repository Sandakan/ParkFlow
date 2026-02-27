import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/presentation/states/auth/auth_state.dart';
import 'package:parkflow/presentation/screens/boot/boot_screen.dart';
import 'package:parkflow/presentation/screens/home/home_screen.dart';
import 'package:parkflow/presentation/screens/auth/login_screen.dart';
import 'package:parkflow/presentation/screens/auth/register_screen.dart';
import 'package:parkflow/presentation/screens/video_feed/video_feed_screen.dart';

part 'router_provider.g.dart';

part 'parts/boot_routes.dart';
part 'parts/auth_routes.dart';
part 'parts/home_routes.dart';
part 'parts/video_routes.dart';

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

      if (isBooting) {
        if (authState.isAuthenticated) return HomeRoute.path;
        if (authState.user == null &&
            !authState.isLoading &&
            authState != const AuthState.initial()) {
          return LoginRoute.path;
        }
        return null;
      }

      final isAuth = authState.user != null;

      if (!isAuth && !isGoingToLogin && !isGoingToRegister) {
        return LoginRoute.path;
      }

      if (isAuth && (isGoingToLogin || isGoingToRegister)) {
        return HomeRoute.path;
      }

      return null;
    },
    routes: $appRoutes,
  );
}
