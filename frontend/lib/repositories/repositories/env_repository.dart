import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:device_info_plus/device_info_plus.dart';

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
    try {
      await dotenv.load(fileName: fileName);
    } catch (e) {
      if (kDebugMode) {
        print('Error loading $fileName: $e');
      }
    }

    // Prioritize BASE_URL from --dart-define
    String baseUrl = const String.fromEnvironment('BASE_URL');

    // Fallback to .env if not provided via --dart-define
    if (baseUrl.isEmpty) {
      baseUrl = dotenv.get('BASE_URL', fallback: 'http://localhost:8200/api/v1');
    }

    // Optimize URL based on platform and device type
    baseUrl = await _optimizeUrl(baseUrl);

    return EnvRepository._(
      level: level,
      baseUrl: baseUrl,
    );
  }

  @override
  String getBaseUrl() => baseUrl;

  static Future<String> _optimizeUrl(String url) async {
    // 1. Handle Android Emulator (localhost -> 10.0.2.2)
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      final isPhysicalDevice = await _checkIsPhysicalDevice();
      if (!isPhysicalDevice) {
        url = url.replaceAll('localhost', '10.0.2.2');
      }
    }

    // 2. Ensure protocol
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'http://$url'; // Default to http for local dev if not specified
    }

    // 3. Remove trailing slash
    if (url.endsWith('/')) {
      url = url.substring(0, url.length - 1);
    }

    if (kDebugMode) {
      print('ParkFlow: Using Base URL: $url');
    }

    return url;
  }

  static Future<bool> _checkIsPhysicalDevice() async {
    if (kIsWeb) return true;
    final deviceInfo = DeviceInfoPlugin();
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.isPhysicalDevice;
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.isPhysicalDevice;
      }
    } catch (e) {
        if (kDebugMode) {
          print('Error checking physical device: $e');
        }
    }
    return true; // Default to true if check fails
  }
}
