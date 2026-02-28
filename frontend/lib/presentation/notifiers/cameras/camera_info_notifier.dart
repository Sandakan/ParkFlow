import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/models/parking/camera_model.dart';
import 'package:parkflow/presentation/notifiers/cameras/cameras_notifier.dart';

part 'camera_info_notifier.freezed.dart';
part 'camera_info_notifier.g.dart';

enum InteractionMode { inspection, drawing, aiVerification }

@freezed
abstract class CameraInfoState with _$CameraInfoState {
  const factory CameraInfoState({
    @Default(true) bool isLoading,
    CameraModel? camera,
    @Default(InteractionMode.inspection) InteractionMode interactionMode,
    @Default([]) List<Offset> currentDrawingPoints,
    @Default(false) bool showAiDetections,
    String? error,
  }) = _CameraInfoState;
}

@riverpod
class CameraInfo extends _$CameraInfo {
  @override
  CameraInfoState build(String cameraId) {
    Future.microtask(() => _fetchCameraInfo());
    return const CameraInfoState(isLoading: true);
  }

  Future<void> _fetchCameraInfo() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final camerasState = ref.read(camerasProvider);

      CameraModel? camera;
      try {
        camera = camerasState.cameras.firstWhere((c) => c.id == cameraId);
      } catch (_) {}

      state = state.copyWith(isLoading: false, camera: camera);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void setInteractionMode(InteractionMode mode) {
    state = state.copyWith(
      interactionMode: mode,
      currentDrawingPoints: mode == InteractionMode.drawing
          ? []
          : state.currentDrawingPoints,
    );
  }

  void toggleAiDetections() {
    state = state.copyWith(showAiDetections: !state.showAiDetections);
  }

  void addDrawingPoint(Offset point) {
    if (state.interactionMode != InteractionMode.drawing) return;
    if (state.currentDrawingPoints.length >= 4) return;

    final newPoints = List<Offset>.from(state.currentDrawingPoints)..add(point);
    state = state.copyWith(currentDrawingPoints: newPoints);

    if (newPoints.length == 4) {}
  }

  void resetDrawing() {
    state = state.copyWith(currentDrawingPoints: []);
  }

  Future<void> saveSlot(String slotName) async {
    state = state.copyWith(
      interactionMode: InteractionMode.inspection,
      currentDrawingPoints: [],
    );
  }
}
