part of '../router_provider.dart';

class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  static const path = '/home';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

@TypedGoRoute<BookingRoute>(path: BookingRoute.path)
class BookingRoute extends GoRouteData with $BookingRoute {
  const BookingRoute();

  static const path = '/booking';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BookingScreen();
  }
}

@TypedGoRoute<DigitalTicketRoute>(path: DigitalTicketRoute.path)
class DigitalTicketRoute extends GoRouteData with $DigitalTicketRoute {
  final String reservationId;
  const DigitalTicketRoute({required this.reservationId});

  static const path = '/digital-ticket/:reservationId';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DigitalTicketScreen(reservationId: reservationId);
  }
}

@TypedGoRoute<PaymentMethodsRoute>(path: PaymentMethodsRoute.path)
class PaymentMethodsRoute extends GoRouteData with $PaymentMethodsRoute {
  const PaymentMethodsRoute();

  static const path = '/payment-methods';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PaymentMethodsScreen();
  }
}

@TypedGoRoute<AddVehicleRoute>(path: AddVehicleRoute.path)
class AddVehicleRoute extends GoRouteData with $AddVehicleRoute {
  const AddVehicleRoute();
  static const path = '/add-vehicle';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AddVehicleScreen();
  }
}

@TypedGoRoute<AddPaymentMethodRoute>(path: AddPaymentMethodRoute.path)
class AddPaymentMethodRoute extends GoRouteData with $AddPaymentMethodRoute {
  const AddPaymentMethodRoute();
  static const path = '/add-payment-method';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AddPaymentMethodScreen();
  }
}
@TypedGoRoute<MyVehicleRoute>(path: MyVehicleRoute.path)
class MyVehicleRoute extends GoRouteData with $MyVehicleRoute {
  const MyVehicleRoute();
  static const path = '/my-vehicle';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MyVehicleScreen();
  }
}
