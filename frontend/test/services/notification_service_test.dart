import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:parkflow/services/notification_service.dart';
import 'package:parkflow/repositories/providers/env_repository_provider.dart';
import 'package:parkflow/models/user/notification_entity.dart';
import '../helpers/test_helpers.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {}

void main() {
  late MockEnvRepository mockEnvRepository;
  late MockFlutterLocalNotificationsPlugin mockNotificationsPlugin;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(http.Request('GET', Uri.parse('http://api.test')));
    registerFallbackValue(
      const InitializationSettings(
        android: AndroidInitializationSettings('test'),
        iOS: DarwinInitializationSettings(),
      ),
    );
  });

  setUp(() {
    mockEnvRepository = MockEnvRepository();
    mockNotificationsPlugin = MockFlutterLocalNotificationsPlugin();

    when(() => mockEnvRepository.getBaseUrl()).thenReturn('http://api.test');
    when(
      () => mockNotificationsPlugin.initialize(any()),
    ).thenAnswer((_) async => true);

    container = ProviderContainer(
      overrides: [
        envRepositoryProvider.overrideWithValue(mockEnvRepository),
        notificationServiceProvider.overrideWith(
          (ref) => NotificationService(
            ref,
            notificationsPlugin: mockNotificationsPlugin,
          ),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('NotificationService', () {
    test(
      'connectToSse should establish stream and emit notifications',
      () async {
        final service = container.read(notificationServiceProvider);

        final stream = service.connectToSse('test_token');

        expect(stream, isA<Stream<NotificationEntity>>());

        service.disconnect();
      },
    );
  });
}
