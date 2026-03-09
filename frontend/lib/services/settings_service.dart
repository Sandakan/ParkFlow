import 'package:parkflow/repositories/entities/settings/get_inference_settings_response_entity.dart';
import 'package:parkflow/repositories/entities/settings/update_inference_settings_request.dart';
import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';

part 'settings_service.g.dart';

class SettingsService {
  final RemoteRepositoryInterface _remote;
  final Ref _ref;

  SettingsService(this._remote, this._ref);

  Future<String?> _getToken() =>
      _ref.read(authProvider.notifier).getValidAccessToken();

  Future<GetInferenceSettingsResponseEntity> fetchInferenceSettings() async {
    try {
      return await _remote.getInferenceSettings(accessToken: await _getToken());
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<void> updateInferenceSettings(
    UpdateInferenceSettingsRequest request,
  ) async {
    try {
      await _remote.updateInferenceSettings(
        request,
        accessToken: await _getToken(),
      );
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}

@Riverpod(keepAlive: true)
SettingsService settingsService(Ref ref) {
  final remote = ref.watch(remoteRepositoryProvider);
  return SettingsService(remote, ref);
}
