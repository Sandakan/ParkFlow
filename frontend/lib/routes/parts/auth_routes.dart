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

@TypedGoRoute<ForgotPasswordRoute>(path: '/forgot-password')
class ForgotPasswordRoute extends GoRouteData with $ForgotPasswordRoute {
  const ForgotPasswordRoute();

  static const path = '/forgot-password';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ForgotPasswordScreen();
  }
}

@TypedGoRoute<VerifyOtpRoute>(path: '/verify-otp')
class VerifyOtpRoute extends GoRouteData with $VerifyOtpRoute {
  final String email;

  const VerifyOtpRoute({required this.email});

  static const path = '/verify-otp';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VerifyOtpScreen(email: email);
  }
}

@TypedGoRoute<ResetPasswordRoute>(path: '/reset-password')
class ResetPasswordRoute extends GoRouteData with $ResetPasswordRoute {
  final String email;
  final String otp;

  const ResetPasswordRoute({required this.email, required this.otp});

  static const path = '/reset-password';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ResetPasswordScreen(email: email, otp: otp);
  }
}
