import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parkflow/presentation/screens/auth/login_screen.dart';

part 'auth_routes.g.dart';

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  static const path = '/login';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}
