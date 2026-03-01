import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/repositories/providers/env_repository_provider.dart';
import 'package:parkflow/repositories/providers/secure_storage_repository_provider.dart';
import 'package:parkflow/repositories/repositories/remote_repository.dart';
import 'package:parkflow/utils/http/http_api_provider.dart';

part 'remote_repository_provider.g.dart';

@riverpod
RemoteRepositoryInterface remoteRepository(Ref ref) {
  final httpApi = ref.watch(httpApiProvider);
  final secureStorage = ref.watch(secureStorageRepositoryProvider);
  final env = ref.watch(envRepositoryProvider);

  return RemoteRepository(
    ref: ref,
    httpAPI: httpApi,
    secureStorageRepository: secureStorage,
    envRepository: env,
  );
}
