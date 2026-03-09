import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:parkflow/repositories/providers/env_repository_provider.dart';
import 'package:parkflow/models/user/notification_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'notification_service.g.dart';

@riverpod
NotificationService notificationService(Ref ref) {
  return NotificationService(ref);
}

class NotificationService {
  final Ref _ref;
  final _talker = Talker();
  final _notificationsPlugin = FlutterLocalNotificationsPlugin();
  
  StreamController<NotificationEntity>? _sseController;
  http.Client? _client;

  NotificationService(this._ref) {
    _initNativeNotifications();
  }

  Future<void> _initNativeNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    
    await _notificationsPlugin.initialize(initSettings);
  }

  Future<void> showNativeNotification(NotificationEntity notification) async {
    const androidDetails = AndroidNotificationDetails(
      'parkflow_notifications',
      'ParkFlow Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    
    const iosDetails = DarwinNotificationDetails();
    
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _notificationsPlugin.show(
      notification.id.hashCode,
      notification.title,
      notification.message,
      details,
    );
  }

  Stream<NotificationEntity> connectToSse(String token) {
    _sseController?.close();
    _sseController = StreamController<NotificationEntity>.broadcast();
    _client = http.Client();

    final envRepo = _ref.watch(envRepositoryProvider);
    final baseUrl = envRepo.getBaseUrl();
    final url = Uri.parse('$baseUrl/notifications/stream');
    
    final request = http.Request('GET', url);
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'text/event-stream';
    request.headers['Cache-Control'] = 'no-cache';

    _talker.info('Connecting to SSE: $url');

    _client!.send(request).then((response) {
      response.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .listen(
        (line) {
          if (line.startsWith('data: ')) {
            final data = line.substring(6);
            if (data == 'connected') return;
            
            try {
              final json = jsonDecode(data);
              final notification = NotificationEntity.fromJson(json);
              _sseController?.add(notification);
              showNativeNotification(notification);
            } catch (e) {
              _talker.error('Error decoding SSE data: $e');
            }
          }
        },
        onError: (e) {
          _talker.error('SSE Stream Error: $e');
          _sseController?.addError(e);
        },
        onDone: () {
          _talker.info('SSE Stream Done');
          _sseController?.close();
        },
      );
    }).catchError((e) {
      _talker.error('SSE Connection Error: $e');
      _sseController?.addError(e);
    });

    return _sseController!.stream;
  }

  void disconnect() {
    _client?.close();
    _sseController?.close();
    _sseController = null;
  }
}
