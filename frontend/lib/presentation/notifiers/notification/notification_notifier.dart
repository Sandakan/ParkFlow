import 'package:parkflow/models/user/notification_entity.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/presentation/states/auth/auth_state.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:parkflow/repositories/providers/secure_storage_provider.dart';
import 'package:parkflow/services/notification_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_notifier.g.dart';

@Riverpod(keepAlive: true)
class NotificationNotifier extends _$NotificationNotifier {
  @override
  FutureOr<List<NotificationEntity>> build() async {
    final authState = ref.watch(authProvider);

    if (authState is Authenticated) {
      _listenToNotifications();
      return _fetchNotifications();
    }

    return [];
  }

  void _listenToNotifications() async {
    final storage = ref.read(secureStorageRepositoryProvider);
    final token = await storage.getAccessToken();

    if (token != null) {
      final stream = ref.read(notificationServiceProvider).connectToSse(token);
      stream.listen((notification) {
        state.whenData((notifications) {
          state = AsyncData([notification, ...notifications]);
        });
      });
    }
  }

  Future<List<NotificationEntity>> _fetchNotifications() async {
    final remoteRepo = ref.read(remoteRepositoryProvider);
    final token = await ref.read(authProvider.notifier).getValidAccessToken();
    final response = await remoteRepo.getNotifications(accessToken: token);
    return response
        .map((json) => NotificationEntity.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> markAsRead(String id) async {
    final remoteRepo = ref.read(remoteRepositoryProvider);
    final token = await ref.read(authProvider.notifier).getValidAccessToken();
    await remoteRepo.markNotificationAsRead(id, accessToken: token);
    
    state.whenData((notifications) {
      state = AsyncData(
        notifications.map((n) {
          if (n.id == id) {
            return n.copyWith(readAt: DateTime.now());
          }
          return n;
        }).toList(),
      );
    });
  }

  int get unreadCount {
    return state.asData?.value.where((n) => n.readAt == null).length ?? 0;
  }
}
