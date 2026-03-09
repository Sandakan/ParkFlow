import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parkflow/models/parking/camera_model.dart';
import 'package:parkflow/services/camera_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/core/app_exception.dart';

part 'cameras_notifier.freezed.dart';
part 'cameras_notifier.g.dart';

@freezed
abstract class CamerasState with _$CamerasState {
  const factory CamerasState({
    @Default([]) List<CameraModel> cameras,
    @Default([]) List<CameraModel> filteredCameras,
    @Default(true) bool isLoading,
    String? error,
    @Default('') String searchQuery,
  }) = _CamerasState;
}

@riverpod
class CamerasNotifier extends _$CamerasNotifier {
  @override
  CamerasState build() {
    Future.microtask(() => _fetchCameras());
    return const CamerasState();
  }

  Future<void> _fetchCameras() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final cameras = await ref.read(cameraServiceProvider).fetchCameras();
      state = state.copyWith(
        cameras: cameras,
        filteredCameras: _filterCameras(cameras, state.searchQuery),
        isLoading: false,
      );

      _fetchHealthStatuses();
    } on AppException catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to fetch cameras: ${e.toString()}',
        isLoading: false,
      );
    }
  }

  Future<void> _fetchHealthStatuses() async {
    final cameras = state.cameras;
    if (cameras.isEmpty) return;

    final results = await Future.wait(
      cameras.map(
        (cam) => ref.read(cameraServiceProvider).checkCameraHealth(cam.id),
      ),
    );

    final updatedCameras = [
      for (int i = 0; i < cameras.length; i++)
        cameras[i].copyWith(isAlive: results[i]),
    ];

    state = state.copyWith(
      cameras: updatedCameras,
      filteredCameras: _filterCameras(updatedCameras, state.searchQuery),
    );
  }

  Future<void> refresh() async {
    await _fetchCameras();
  }

  void updateCameraHealth(String cameraId, bool isAlive) {
    final updatedCameras = state.cameras.map((cam) {
      if (cam.id == cameraId) {
        return cam.copyWith(isAlive: isAlive);
      }
      return cam;
    }).toList();

    state = state.copyWith(
      cameras: updatedCameras,
      filteredCameras: _filterCameras(updatedCameras, state.searchQuery),
    );
  }

  void updateSearchQuery(String query) {
    state = state.copyWith(
      searchQuery: query,
      filteredCameras: _filterCameras(state.cameras, query),
    );
  }

  List<CameraModel> _filterCameras(List<CameraModel> cameras, String query) {
    if (query.isEmpty) return cameras;
    final lowerQuery = query.toLowerCase();
    return cameras
        .where(
          (cam) =>
              cam.name.toLowerCase().contains(lowerQuery) ||
              (cam.lotName ?? '').toLowerCase().contains(lowerQuery),
        )
        .toList();
  }
}
