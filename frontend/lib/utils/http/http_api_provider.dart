import 'package:dio/dio.dart';
import 'package:parkflow/repositories/providers/env_repository_provider.dart';
import 'package:parkflow/repositories/providers/secure_storage_repository_provider.dart';
import 'package:parkflow/utils/http/http_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_api_provider.g.dart';

@riverpod
HttpApi httpApi(Ref ref) {
  final env = ref.watch(envRepositoryProvider);
  final storage = ref.watch(secureStorageRepositoryProvider);

  return HttpApi(
    dio: Dio(),
    secureStorageRepository: storage,
    envRepository: env,
    ref: ref,
  );
}
