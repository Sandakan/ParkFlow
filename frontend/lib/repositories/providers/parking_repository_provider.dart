import 'package:parkflow/repositories/interfaces/parking_repository_interface.dart';
import 'package:parkflow/repositories/providers/env_repository_provider.dart';
import 'package:parkflow/repositories/repositories/parking_repository.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parking_repository_provider.g.dart';

@riverpod
ParkingRepositoryInterface parkingRepository(Ref ref) {
  final remote = ref.watch(remoteRepositoryProvider);
  final env = ref.watch(envRepositoryProvider);

  return ParkingRepository(remote, env.getWebSocketUrl());
}
