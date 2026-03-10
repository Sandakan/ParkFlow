import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parkflow/models/user/notification_entity.dart';
import 'package:parkflow/presentation/notifiers/parking/parking_notifier.dart';
import 'package:parkflow/presentation/states/parking/parking_state.dart';
import 'package:parkflow/presentation/providers/locale_provider.dart';
import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/repositories/interfaces/secure_storage_repository_interface.dart';
import 'package:parkflow/repositories/interfaces/env_repository_interface.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/presentation/states/auth/auth_state.dart';
import 'package:parkflow/services/analytics_service.dart';
import 'package:parkflow/services/vehicle_service.dart';
import 'package:parkflow/services/notification_service.dart';
import 'package:parkflow/presentation/notifiers/analytics/analytics_notifier.dart';
import 'package:parkflow/presentation/notifiers/notification/notification_notifier.dart';
import 'package:parkflow/presentation/notifiers/profile/vehicle_notifier.dart';
import 'package:parkflow/presentation/states/profile/vehicle_action_state.dart';

class MockRemoteRepository extends Mock implements RemoteRepositoryInterface {}

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepositoryInterface {}

class MockEnvRepository extends Mock implements EnvRepositoryInterface {}

class MockParkingNotifier extends Notifier<ParkingState>
    with Mock
    implements ParkingNotifier {}

class MockAppLocale extends Notifier<Locale> with Mock implements AppLocale {}

class MockAuthNotifier extends Notifier<AuthState>
    with Mock
    implements AuthNotifier {}

class MockAnalyticsService extends Mock implements AnalyticsService {}

class MockVehicleService extends Mock implements VehicleService {}

class MockNotificationService extends Mock implements NotificationService {}

class MockAnalyticsNotifier extends Notifier<AnalyticsState>
    with Mock
    implements AnalyticsNotifier {}

class MockVehicleNotifier extends Notifier<VehicleActionState>
    with Mock
    implements VehicleNotifier {}

class MockNotificationNotifier
    extends AsyncNotifier<List<NotificationEntity>>
    with Mock
    implements NotificationNotifier {}

/// Helper to listen to a provider and record its states.
class ProviderListener<T> extends Mock {
  void call(T? previous, T next);
}
