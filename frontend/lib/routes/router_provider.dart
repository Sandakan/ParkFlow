import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

import 'package:parkflow/routes/parts/home_routes.dart';
import 'package:parkflow/routes/parts/auth_routes.dart';
import 'package:parkflow/routes/parts/video_routes.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';

part 'router_provider.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

@riverpod
GoRouter router(Ref ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/home',
    redirect: (context, state) {
      if (authState.isLoading) return null;

      final isAuth = authState.user != null;
      final isGoingToLogin = state.matchedLocation == '/login';

      if (!isAuth && !isGoingToLogin) {
        return '/login';
      }

      if (isAuth && isGoingToLogin) {
        return '/home';
      }

      return null;
    },
    routes: [$homeRoute, $loginRoute, $videoFeedRoute],
  );
}
