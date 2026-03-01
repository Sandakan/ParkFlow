import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/models/parking/parking_slot_model.dart';
import 'package:parkflow/models/parking/camera_model.dart';
import 'package:parkflow/presentation/notifiers/cameras/cameras_notifier.dart';
import 'package:parkflow/services/parking_service.dart';
import 'package:parkflow/repositories/entities/parking/create_parking_slot_request.dart';
import 'package:parkflow/repositories/entities/parking/point2d.dart';

part 'camera_info_notifier.freezed.dart';
part 'camera_info_notifier.g.dart';

enum InteractionMode { inspection, drawing, aiVerification }

@freezed
abstract class CameraInfoState with _$CameraInfoState {
  const factory CameraInfoState({
    @Default(true) bool isLoading,
    @Default(false) bool isSavingSlot,
    CameraModel? camera,
    @Default([]) List<ParkingSlotModel> slots,
    @Default(InteractionMode.inspection) InteractionMode interactionMode,
    @Default('general') String selectedSlotType,
    @Default([]) List<Offset> currentDrawingPoints,
    @Default(false) bool showAiDetections,
    @Default(false) bool isSidebarCollapsed,
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

      state = state.copyWith(camera: camera);

      await _fetchSlots();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> _fetchSlots() async {
    try {
      final slots = await ref
          .read(parkingServiceProvider)
          .fetchParkingSlots(cameraId: cameraId);
      state = state.copyWith(isLoading: false, slots: slots);
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

  void toggleSidebar() {
    state = state.copyWith(isSidebarCollapsed: !state.isSidebarCollapsed);
  }

  void addDrawingPoint(Offset normalizedPoint) {
    if (state.interactionMode != InteractionMode.drawing) return;
    if (state.currentDrawingPoints.length >= 4) return;

    final newPoints = List<Offset>.from(state.currentDrawingPoints)
      ..add(normalizedPoint);
    state = state.copyWith(currentDrawingPoints: newPoints);
  }

  void setSelectedSlotType(String type) {
    state = state.copyWith(selectedSlotType: type);
  }

  void resetDrawing() {
    state = state.copyWith(currentDrawingPoints: []);
  }

  Future<void> saveSlot(String slotName) async {
    if (state.camera == null) return;

    final points = state.currentDrawingPoints
        .map((p) => Point2D(x: p.dx, y: p.dy))
        .toList();

    // Create a temporary slot for optimistic rendering
    final tempSlot = ParkingSlotModel(
      id: 'temp-${DateTime.now().millisecondsSinceEpoch}',
      name: slotName,
      isOccupied: false,
      slotType: state.selectedSlotType,
      cameraId: cameraId,
      coordinates: points,
    );

    try {
      state = state.copyWith(
        isSavingSlot: true,
        slots: [...state.slots, tempSlot], // Optimistic update
        interactionMode: InteractionMode.inspection,
        currentDrawingPoints: [],
      );

      final request = CreateParkingSlotRequest(
        lotId: state.camera!.lotId,
        cameraId: cameraId,
        slotNumber: slotName,
        slotType: state.selectedSlotType,
        coordinates: points,
      );

      await ref.read(parkingServiceProvider).createParkingSlot(request);

      state = state.copyWith(isSavingSlot: false);
      await _fetchSlots();
    } catch (e) {
      // Rollback optimistic update
      state = state.copyWith(
        isSavingSlot: false,
        slots: state.slots.where((s) => s.id != tempSlot.id).toList(),
        error: e.toString(),
      );
    }
  }

  Future<void> deleteSlot(String slotId) async {
    try {
      await ref
          .read(parkingServiceProvider)
          .deleteParkingSlot(slotId, cameraId: cameraId);
      await _fetchSlots();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}
