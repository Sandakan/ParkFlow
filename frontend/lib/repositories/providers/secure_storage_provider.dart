import 'package:parkflow/repositories/interfaces/secure_storage_repository_interface.dart';
import 'package:parkflow/repositories/repositories/secure_storage_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_provider.g.dart';

@riverpod
SecureStorageRepositoryInterface secureStorageRepository(Ref ref) {
  return SecureStorageRepository();
}
