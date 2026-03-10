// ignore_for_file: invalid_use_of_visible_for_overriding_member
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parkflow/models/user/notification_entity.dart';
import 'package:parkflow/models/auth/user_model.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/presentation/notifiers/notification/notification_notifier.dart';
import 'package:parkflow/presentation/states/auth/auth_state.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:parkflow/repositories/providers/secure_storage_provider.dart';
import 'package:parkflow/services/notification_service.dart';
import '../../helpers/test_helpers.dart';

void main() {
  late MockRemoteRepository mockRemoteRepository;
  late MockSecureStorageRepository mockSecureStorage;
  late MockAuthNotifier mockAuthNotifier;
  late MockNotificationService mockNotificationService;
  late ProviderContainer container;

  setUp(() {
    mockRemoteRepository = MockRemoteRepository();
    mockSecureStorage = MockSecureStorageRepository();
    mockAuthNotifier = MockAuthNotifier();
    mockNotificationService = MockNotificationService();

    const testUser = UserModel(
      id: 'user_123',
      email: 'test@example.com',
      name: 'Test User',
      role: 'user',
    );

    // Default: Authenticated state
    when(() => mockAuthNotifier.build()).thenReturn(
      const AuthState.authenticated(testUser),
    );

    when(() => mockSecureStorage.getAccessToken())
        .thenAnswer((_) async => 'test_token');
    
    when(() => mockAuthNotifier.getValidAccessToken())
        .thenAnswer((_) async => 'test_token');

    when(() => mockNotificationService.connectToSse(any()))
        .thenAnswer((_) => Stream.fromIterable([]));

    when(() => mockRemoteRepository.getNotifications(accessToken: any(named: 'accessToken')))
        .thenAnswer((_) async => []);

    container = ProviderContainer(
      overrides: [
        remoteRepositoryProvider.overrideWithValue(mockRemoteRepository),
        secureStorageRepositoryProvider.overrideWithValue(mockSecureStorage),
        authProvider.overrideWith(() => mockAuthNotifier),
        notificationServiceProvider.overrideWithValue(mockNotificationService),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('NotificationNotifier', () {
    test('initial state should fetch notifications if authenticated', () async {
      final mockNotification = {
        '_id': '1',
        'title': 'Test',
        'message': 'Message',
        'type': 'info',
        'created_at': DateTime.now().toIso8601String(),
      };

      when(() => mockRemoteRepository.getNotifications(accessToken: 'test_token'))
          .thenAnswer((_) async => [mockNotification]);

      await container.read(notificationProvider.future);

      final state = container.read(notificationProvider).value;
      expect(state, isNotNull);
      expect(state!.length, 1);
      expect(state.first.id, '1');
      verify(() => mockRemoteRepository.getNotifications(accessToken: 'test_token'))
          .called(1);
    });

    test('markAsRead should update state and call repository', () async {
      final notification = NotificationEntity(
        id: '1',
        title: 'Test',
        message: 'Message',
        type: NotificationType.info,
        createdAt: DateTime.now(),
      );

      when(() => mockRemoteRepository.getNotifications(accessToken: 'test_token'))
          .thenAnswer((_) async => [notification.toJson()]);
      
      when(() => mockRemoteRepository.markNotificationAsRead('1', accessToken: 'test_token'))
          .thenAnswer((_) async => {});

      final notifier = container.read(notificationProvider.notifier);
      await container.read(notificationProvider.future);

      await notifier.markAsRead('1');

      final state = container.read(notificationProvider).value;
      expect(state!.first.readAt, isNotNull);
      verify(() => mockRemoteRepository.markNotificationAsRead('1', accessToken: 'test_token'))
          .called(1);
    });

    test('unreadCount should return correct count', () async {
       final notifications = [
        NotificationEntity(id: '1', title: 'T1', message: 'M1', type: NotificationType.info, createdAt: DateTime.now()),
        NotificationEntity(id: '2', title: 'T2', message: 'M2', type: NotificationType.info, createdAt: DateTime.now(), readAt: DateTime.now()),
      ];

      when(() => mockRemoteRepository.getNotifications(accessToken: 'test_token'))
          .thenAnswer((_) async => notifications.map((n) => n.toJson()).toList());

      final notifier = container.read(notificationProvider.notifier);
      await container.read(notificationProvider.future);

      expect(notifier.unreadCount, 1);
    });
   group('SSE Integration', () {
      test('should add new notification from SSE stream to state', () async {
        final initialNotification = NotificationEntity(
          id: '1',
          title: 'Old',
          message: 'Old',
          type: NotificationType.info,
          createdAt: DateTime.now(),
        );

        final newNotification = NotificationEntity(
          id: '2',
          title: 'New',
          message: 'New',
          type: NotificationType.info,
          createdAt: DateTime.now(),
        );

        final sseController = StreamController<NotificationEntity>();

        when(() => mockRemoteRepository.getNotifications(accessToken: 'test_token'))
            .thenAnswer((_) async => [initialNotification.toJson()]);
        
        when(() => mockNotificationService.connectToSse('test_token'))
            .thenAnswer((_) => sseController.stream);

        // Access notifier to trigger listenToNotifications
        container.read(notificationProvider.notifier);
        await container.read(notificationProvider.future);

        sseController.add(newNotification);
        
        // Wait for stream to be processed
        await Future.delayed(Duration.zero);

        final state = container.read(notificationProvider).value;
        expect(state!.length, 2);
        expect(state.first.id, '2');

        await sseController.close();
      });
    });
  });
}
