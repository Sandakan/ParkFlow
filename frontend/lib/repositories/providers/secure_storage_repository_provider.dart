import 'package:parkflow/repositories/repositories/secure_storage_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_repository_provider.g.dart';

@riverpod
SecureStorageRepository secureStorageRepository(Ref ref) {
  return SecureStorageRepository();
}
