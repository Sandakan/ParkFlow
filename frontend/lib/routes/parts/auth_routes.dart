part of '../router_provider.dart';

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  static const path = '/login';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

@TypedGoRoute<RegisterRoute>(path: '/register')
class RegisterRoute extends GoRouteData with $RegisterRoute {
  const RegisterRoute();

  static const path = '/register';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RegisterScreen();
  }
}
