import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parkflow/presentation/screens/home/home_screen.dart';

part 'home_routes.g.dart';

@TypedGoRoute<HomeRoute>(path: '/home')
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  static const path = '/home';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}
