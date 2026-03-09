import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parkflow/presentation/notifiers/parking/parking_notifier.dart';
import 'package:parkflow/presentation/states/parking/parking_state.dart';
import 'package:parkflow/presentation/providers/locale_provider.dart';
import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/repositories/interfaces/secure_storage_repository_interface.dart';
import 'package:parkflow/repositories/interfaces/env_repository_interface.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/presentation/states/auth/auth_state.dart';

class MockRemoteRepository extends Mock implements RemoteRepositoryInterface {}

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepositoryInterface {}

class MockEnvRepository extends Mock implements EnvRepositoryInterface {}

class MockParkingNotifier extends Notifier<ParkingState>
    with Mock
    implements ParkingNotifier {
  @override
  ParkingState build() => const ParkingState(isLoading: false);
}

class MockAppLocale extends Notifier<Locale> with Mock implements AppLocale {
  @override
  Locale build() => const Locale('en');
}

class MockAuthNotifier extends Notifier<AuthState>
    with Mock
    implements AuthNotifier {
  @override
  AuthState build() => const AuthState.initial();
}
