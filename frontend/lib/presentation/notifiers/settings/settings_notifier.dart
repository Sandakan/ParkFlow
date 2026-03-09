import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parkflow/repositories/entities/settings/update_inference_settings_request.dart';
import 'package:parkflow/services/settings_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/core/app_exception.dart';

part 'settings_notifier.freezed.dart';
part 'settings_notifier.g.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(0.25) double confidenceThreshold,
    @Default(0.45) double iouThreshold,
    @Default(1) int frameSkip,
    @Default(3) int stabilityBuffer,
    @Default(false) bool globalInferenceEnabled,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    String? error,
    @Default(false) bool saveSuccess,
  }) = _SettingsState;
}

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  SettingsState build() {
    Future.microtask(() => fetchSettings());
    return const SettingsState();
  }

  Future<void> fetchSettings() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final settings = await ref
          .read(settingsServiceProvider)
          .fetchInferenceSettings();
      state = state.copyWith(
        confidenceThreshold: settings.confidenceThreshold,
        iouThreshold: settings.iouThreshold,
        frameSkip: settings.frameSkip,
        stabilityBuffer: settings.stabilityBuffer,
        globalInferenceEnabled: settings.globalInferenceEnabled,
        isLoading: false,
      );
    } on AppException catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to load settings: $e',
        isLoading: false,
      );
    }
  }

  void updateConfidenceThreshold(double value) {
    state = state.copyWith(confidenceThreshold: value, saveSuccess: false);
  }

  void updateIouThreshold(double value) {
    state = state.copyWith(iouThreshold: value, saveSuccess: false);
  }

  void updateFrameSkip(int value) {
    state = state.copyWith(frameSkip: value, saveSuccess: false);
  }

  void updateStabilityBuffer(int value) {
    state = state.copyWith(stabilityBuffer: value, saveSuccess: false);
  }

  void updateGlobalInferenceEnabled(bool value) {
    state = state.copyWith(globalInferenceEnabled: value, saveSuccess: false);
  }

  Future<void> saveSettings() async {
    state = state.copyWith(isSaving: true, error: null, saveSuccess: false);
    try {
      final request = UpdateInferenceSettingsRequest(
        confidenceThreshold: state.confidenceThreshold,
        iouThreshold: state.iouThreshold,
        frameSkip: state.frameSkip,
        stabilityBuffer: state.stabilityBuffer,
        globalInferenceEnabled: state.globalInferenceEnabled,
      );
      await ref.read(settingsServiceProvider).updateInferenceSettings(request);
      state = state.copyWith(isSaving: false, saveSuccess: true);
    } on AppException catch (e) {
      state = state.copyWith(error: e.toString(), isSaving: false);
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to save settings: $e',
        isSaving: false,
      );
    }
  }
}
