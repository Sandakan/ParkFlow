import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:parkflow/utils/constants/enums/app_level.dart';
import 'package:parkflow/repositories/interfaces/env_repository_interface.dart';

class EnvRepository implements EnvRepositoryInterface {
  @override
  final AppLevelEnum level;
  final String baseUrl;
  final String webSocketUrl;

  EnvRepository._({
    required this.level,
    required this.baseUrl,
    required this.webSocketUrl,
  });

  static Future<EnvRepository> create() async {
    final level = AppLevelEnum.fromString(
      const String.fromEnvironment('env', defaultValue: 'development'),
    );

    final fileName = '.${level.name}.env';
    await dotenv.load(fileName: fileName);

    return EnvRepository._(
      level: level,
      baseUrl: _optimizeUrl(
        dotenv.get('BASE_URL', fallback: 'http://localhost:8000'),
      ),
      webSocketUrl: _optimizeUrl(
        dotenv.get('WEB_SOCKET_URL', fallback: 'http://localhost:8000'),
        isWebSocket: true,
      ),
    );
  }

  @override
  String getBaseUrl() => baseUrl;

  @override
  String getWebSocketUrl() => webSocketUrl;

  static String _optimizeUrl(String url, {bool isWebSocket = false}) {
    if (!isWebSocket) {
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        url = 'https://$url';
      }
    } else {
      if (!url.startsWith('ws://') &&
          !url.startsWith('wss://') &&
          !url.startsWith('http://') &&
          !url.startsWith('https://')) {
        url = 'ws://$url';
      }
    }

    // Some implementations prefer no trailing slash, but if needed we can add it here.
    // For dio and socket.io standardizing without trailing slash is often safer unless specifically required.
    if (url.endsWith('/')) {
      url = url.substring(0, url.length - 1);
    }
    return url;
  }
}
