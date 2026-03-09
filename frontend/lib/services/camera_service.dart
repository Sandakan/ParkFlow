import 'package:parkflow/models/parking/camera_model.dart';
import 'package:parkflow/repositories/entities/parking/create_camera_request.dart';
import 'package:parkflow/repositories/entities/parking/update_camera_request.dart';
import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';

part 'camera_service.g.dart';

class CameraService {
  final RemoteRepositoryInterface _remote;
  final Ref _ref;

  CameraService(this._remote, this._ref);

  Future<String?> _getToken() =>
      _ref.read(authProvider.notifier).getValidAccessToken();

  Future<List<CameraModel>> fetchCameras() async {
    try {
      final response = await _remote.getCameras(accessToken: await _getToken());
      return response.cameras;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createCamera(CreateCameraRequest request) async {
    try {
      await _remote.createCamera(request, accessToken: await _getToken());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCamera(
    String cameraId,
    UpdateCameraRequest request,
  ) async {
    try {
      await _remote.updateCamera(
        cameraId,
        request,
        accessToken: await _getToken(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCamera(String cameraId) async {
    try {
      await _remote.deleteCamera(cameraId, accessToken: await _getToken());
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkCameraHealth(String cameraId) async {
    try {
      return await _remote.checkCameraHealth(
        cameraId,
        accessToken: await _getToken(),
      );
    } catch (e) {
      return false;
    }
  }
}

@Riverpod(keepAlive: true)
CameraService cameraService(Ref ref) {
  return CameraService(ref.watch(remoteRepositoryProvider), ref);
}
