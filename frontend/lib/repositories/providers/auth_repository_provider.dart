import 'package:parkflow/repositories/interfaces/auth_repository_interface.dart';
import 'package:parkflow/repositories/providers/secure_storage_repository_provider.dart';
import 'package:parkflow/repositories/repositories/auth_repository.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepositoryInterface authRepository(Ref ref) {
  final storage = ref.watch(secureStorageRepositoryProvider);
  final remote = ref.watch(remoteRepositoryProvider);

  return AuthRepository(remote: remote, storage: storage);
}
