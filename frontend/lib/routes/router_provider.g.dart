// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router_provider.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $bootRoute,
  $loginRoute,
  $registerRoute,
  $adminShellRoute,
  $driverShellRoute,
];

RouteBase get $bootRoute =>
    GoRouteData.$route(path: '/boot', factory: $BootRoute._fromState);

mixin $BootRoute on GoRouteData {
  static BootRoute _fromState(GoRouterState state) => const BootRoute();

  @override
  String get location => GoRouteData.$location('/boot');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute =>
    GoRouteData.$route(path: '/login', factory: $LoginRoute._fromState);

mixin $LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  @override
  String get location => GoRouteData.$location('/login');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $registerRoute =>
    GoRouteData.$route(path: '/register', factory: $RegisterRoute._fromState);

mixin $RegisterRoute on GoRouteData {
  static RegisterRoute _fromState(GoRouterState state) => const RegisterRoute();

  @override
  String get location => GoRouteData.$location('/register');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $adminShellRoute => StatefulShellRouteData.$route(
  factory: $AdminShellRouteExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/admin',
          factory: $AdminAnalyticsRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/admin/parking-lots',
          factory: $AdminParkingLotsRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'create',
              factory: $AdminCreateParkingLotRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'edit/:lotId',
              factory: $AdminEditParkingLotRoute._fromState,
            ),
            GoRouteData.$route(
              path: ':lotId',
              factory: $AdminParkingLotDetailsRoute._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/admin/cameras',
          factory: $AdminCamerasRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'create',
              factory: $AdminCreateCameraRoute._fromState,
            ),
            GoRouteData.$route(
              path: ':cameraId',
              factory: $AdminCameraInfoRoute._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/admin/settings',
          factory: $AdminSettingsRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $AdminShellRouteExtension on AdminShellRoute {
  static AdminShellRoute _fromState(GoRouterState state) =>
      const AdminShellRoute();
}

mixin $AdminAnalyticsRoute on GoRouteData {
  static AdminAnalyticsRoute _fromState(GoRouterState state) =>
      const AdminAnalyticsRoute();

  @override
  String get location => GoRouteData.$location('/admin');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AdminParkingLotsRoute on GoRouteData {
  static AdminParkingLotsRoute _fromState(GoRouterState state) =>
      const AdminParkingLotsRoute();

  @override
  String get location => GoRouteData.$location('/admin/parking-lots');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AdminCreateParkingLotRoute on GoRouteData {
  static AdminCreateParkingLotRoute _fromState(GoRouterState state) =>
      const AdminCreateParkingLotRoute();

  @override
  String get location => GoRouteData.$location('/admin/parking-lots/create');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AdminEditParkingLotRoute on GoRouteData {
  static AdminEditParkingLotRoute _fromState(GoRouterState state) =>
      AdminEditParkingLotRoute(state.pathParameters['lotId']!);

  AdminEditParkingLotRoute get _self => this as AdminEditParkingLotRoute;

  @override
  String get location => GoRouteData.$location(
    '/admin/parking-lots/edit/${Uri.encodeComponent(_self.lotId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AdminParkingLotDetailsRoute on GoRouteData {
  static AdminParkingLotDetailsRoute _fromState(GoRouterState state) =>
      AdminParkingLotDetailsRoute(state.pathParameters['lotId']!);

  AdminParkingLotDetailsRoute get _self => this as AdminParkingLotDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/admin/parking-lots/${Uri.encodeComponent(_self.lotId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AdminCamerasRoute on GoRouteData {
  static AdminCamerasRoute _fromState(GoRouterState state) =>
      const AdminCamerasRoute();

  @override
  String get location => GoRouteData.$location('/admin/cameras');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AdminCreateCameraRoute on GoRouteData {
  static AdminCreateCameraRoute _fromState(GoRouterState state) =>
      const AdminCreateCameraRoute();

  @override
  String get location => GoRouteData.$location('/admin/cameras/create');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AdminCameraInfoRoute on GoRouteData {
  static AdminCameraInfoRoute _fromState(GoRouterState state) =>
      AdminCameraInfoRoute(state.pathParameters['cameraId']!);

  AdminCameraInfoRoute get _self => this as AdminCameraInfoRoute;

  @override
  String get location => GoRouteData.$location(
    '/admin/cameras/${Uri.encodeComponent(_self.cameraId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AdminSettingsRoute on GoRouteData {
  static AdminSettingsRoute _fromState(GoRouterState state) =>
      const AdminSettingsRoute();

  @override
  String get location => GoRouteData.$location('/admin/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $driverShellRoute => StatefulShellRouteData.$route(
  factory: $DriverShellRouteExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(path: '/home', factory: $HomeRoute._fromState),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(path: '/profile', factory: $ProfileRoute._fromState),
      ],
    ),
  ],
);

extension $DriverShellRouteExtension on DriverShellRoute {
  static DriverShellRoute _fromState(GoRouterState state) =>
      const DriverShellRoute();
}

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/home');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProfileRoute on GoRouteData {
  static ProfileRoute _fromState(GoRouterState state) => const ProfileRoute();

  @override
  String get location => GoRouteData.$location('/profile');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RouterListenable)
final routerListenableProvider = RouterListenableProvider._();

final class RouterListenableProvider
    extends $NotifierProvider<RouterListenable, void> {
  RouterListenableProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerListenableProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routerListenableHash();

  @$internal
  @override
  RouterListenable create() => RouterListenable();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$routerListenableHash() => r'a742137be6ab5831444d4971a01f6aadd09a3f0f';

abstract class _$RouterListenable extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(router)
final routerProvider = RouterProvider._();

final class RouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  RouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routerHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return router(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$routerHash() => r'e0a6a3f0198e95feb9fcdfb20d345b3b0a66f370';
