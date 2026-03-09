import 'dart:async';
import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/models/parking/parking_slot_model.dart';
import 'package:parkflow/models/parking/camera_model.dart';
import 'package:parkflow/models/parking/ai_detection_event.dart';
import 'package:parkflow/presentation/notifiers/cameras/cameras_notifier.dart';
import 'package:parkflow/services/parking_service.dart';
import 'package:parkflow/services/camera_service.dart';
import 'package:parkflow/repositories/entities/parking/create_parking_slot_request.dart';
import 'package:parkflow/repositories/entities/parking/update_camera_request.dart';
import 'package:parkflow/repositories/entities/parking/point2d.dart';
import 'package:parkflow/repositories/providers/env_repository_provider.dart';
import 'package:parkflow/repositories/providers/secure_storage_repository_provider.dart';

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

    @Default([]) List<DetectedBox> aiDetections,
    @Default({}) Map<String, bool> aiSlotHits,
    String? error,
  }) = _CameraInfoState;
}

@riverpod
class CameraInfo extends _$CameraInfo {
  StreamSubscription<String>? _sseSubscription;

  @override
  CameraInfoState build(String cameraId) {
    ref.onDispose(_stopDetectionStream);
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

  Future<void> toggleAiDetections() async {
    final newValue = !state.showAiDetections;
    state = state.copyWith(showAiDetections: newValue);

    if (newValue) {
      await _startDetectionStream();
    } else {
      _stopDetectionStream();
    }
  }

  Future<void> _startDetectionStream() async {
    await _sseSubscription?.cancel();
    _sseSubscription = null;

    // If camera has no slots, no point streaming
    if (state.slots.isEmpty) return;

    final envRepo = ref.read(envRepositoryProvider);
    final secureStorage = ref.read(secureStorageRepositoryProvider);

    final baseUrl = envRepo.getBaseUrl();
    final token = await secureStorage.getAccessToken();

    final uri = Uri.parse('$baseUrl/inference/stream/$cameraId');

    final request = http.Request('GET', uri);
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    request.headers['Accept'] = 'text/event-stream';
    request.headers['Cache-Control'] = 'no-cache';

    final client = http.Client();

    try {
      final response = await client.send(request);
      if (response.statusCode != 200) {
        client.close();
        return;
      }

      _sseSubscription = response.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .where((line) => line.startsWith('data:'))
          .map((line) => line.substring(5).trim())
          .where((data) => data.isNotEmpty)
          .listen(
            _onSseEvent,
            onError: (_) => client.close(),
            onDone: () => client.close(),
            cancelOnError: false,
          );
    } catch (_) {
      client.close();
    }
  }

  void _onSseEvent(String data) {
    try {
      final json = jsonDecode(data) as Map<String, dynamic>;
      final event = AiDetectionEvent.fromJson(json);

      final hitMap = <String, bool>{
        for (final hit in event.slotHits) hit.slotId: hit.isOccupied,
      };

      state = state.copyWith(
        aiDetections: event.detections,
        aiSlotHits: hitMap,
      );

      ref.read(camerasProvider.notifier).updateCameraHealth(cameraId, true);
    } catch (_) {}
  }

  void _stopDetectionStream() {
    _sseSubscription?.cancel();
    _sseSubscription = null;
    state = state.copyWith(aiDetections: [], aiSlotHits: {});
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

  Future<void> updateCamera(UpdateCameraRequest request) async {
    try {
      state = state.copyWith(isLoading: true);
      await ref.read(cameraServiceProvider).updateCamera(cameraId, request);
      if (state.camera != null) {
        state = state.copyWith(
          camera: state.camera!.copyWith(
            name: request.name ?? state.camera!.name,
            rtspUrl: request.rtspUrl ?? state.camera!.rtspUrl,
          ),
        );
      }
      await ref.read(camerasProvider.notifier).refresh();
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> deleteCamera() async {
    try {
      state = state.copyWith(isLoading: true);
      await ref.read(cameraServiceProvider).deleteCamera(cameraId);
      await ref.read(camerasProvider.notifier).refresh();
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }
}
