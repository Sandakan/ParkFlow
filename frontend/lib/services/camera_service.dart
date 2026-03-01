import 'package:parkflow/models/parking/camera_model.dart';
import 'package:parkflow/repositories/entities/parking/create_camera_request.dart';
import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'camera_service.g.dart';

class CameraService {
  final RemoteRepositoryInterface _remote;

  CameraService(this._remote);

  Future<List<CameraModel>> fetchCameras() async {
    try {
      final response = await _remote.getCameras();
      return response.cameras;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createCamera(CreateCameraRequest request) async {
    try {
      await _remote.createCamera(request);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkCameraHealth(String cameraId) async {
    try {
      return await _remote.checkCameraHealth(cameraId);
    } catch (e) {
      return false;
    }
  }
}

@riverpod
CameraService cameraService(Ref ref) {
  return CameraService(ref.watch(remoteRepositoryProvider));
}
