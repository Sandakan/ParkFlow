import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:parkflow/utils/constants/enums/app_level.dart';
import 'package:parkflow/repositories/interfaces/env_repository_interface.dart';

class EnvRepository implements EnvRepositoryInterface {
  @override
  final AppLevelEnum level;
  final String baseUrl;

  EnvRepository._({required this.level, required this.baseUrl});

  static Future<EnvRepository> create() async {
    final level = AppLevelEnum.fromString(
      const String.fromEnvironment('env', defaultValue: 'development'),
    );

    final fileName = '.${level.name}.env';
    await dotenv.load(fileName: fileName);

    return EnvRepository._(
      level: level,
      baseUrl: _optimizeUrl(
        dotenv.get('BASE_URL', fallback: 'http://localhost:8200/api/v1'),
      ),
    );
  }

  @override
  String getBaseUrl() => baseUrl;

  static String _optimizeUrl(String url) {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      url = url.replaceAll('localhost', '10.0.2.2');
    }

    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    if (url.endsWith('/')) {
      url = url.substring(0, url.length - 1);
    }
    return url;
  }
}
