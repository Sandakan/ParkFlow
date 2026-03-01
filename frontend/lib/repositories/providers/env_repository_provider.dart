import 'package:parkflow/repositories/interfaces/env_repository_interface.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'env_repository_provider.g.dart';

@riverpod
EnvRepositoryInterface envRepository(Ref ref) {
  throw UnimplementedError('envRepositoryProvider must be overridden');
}
