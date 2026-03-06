import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/repositories/entities/parking/create_camera_request.dart';
import 'package:parkflow/services/camera_service.dart';
import 'package:parkflow/presentation/notifiers/cameras/cameras_notifier.dart';

part 'admin_create_camera_provider.g.dart';

@riverpod
class AdminCreateCamera extends _$AdminCreateCamera {
  @override
  bool build() {
    return false;
  }

  Future<void> submit(CreateCameraRequest request) async {
    state = true;
    try {
      await ref.read(cameraServiceProvider).createCamera(request);
      await ref.read(camerasProvider.notifier).refresh();
    } finally {
      state = false;
    }
  }
}
