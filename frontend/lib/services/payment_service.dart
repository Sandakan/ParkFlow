import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/utils/constants/enums/app_status_code.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';

part 'payment_service.g.dart';

class PaymentService {
  final RemoteRepositoryInterface _remote;
  final Ref _ref;

  PaymentService(this._remote, this._ref);

  Future<String?> _getToken() =>
      _ref.read(authProvider.notifier).getValidAccessToken();

  Future<void> addPaymentMethod(
    String provider,
    String type, {
    String? last4,
    bool isDefault = false,
  }) async {
    try {
      if (provider.isEmpty || type.isEmpty) {
        throw const AppException(AppStatusCode.invalidResponse);
      }
      final token = await _getToken();
      await _remote.addPaymentMethod({
        'provider': provider,
        'type': type,
        'last4': last4,
        'is_default': isDefault,
      }, accessToken: token);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<void> removePaymentMethod(String methodId) async {
    try {
      if (methodId.isEmpty) {
        throw const AppException(AppStatusCode.invalidResponse);
      }
      final token = await _getToken();
      await _remote.removePaymentMethod(methodId, accessToken: token);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<void> setDefaultPaymentMethod(String methodId) async {
    try {
      if (methodId.isEmpty) {
        throw const AppException(AppStatusCode.invalidResponse);
      }
      final token = await _getToken();
      await _remote.setDefaultPaymentMethod(methodId, accessToken: token);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}

@riverpod
PaymentService paymentService(Ref ref) {
  final remote = ref.watch(remoteRepositoryProvider);
  return PaymentService(remote, ref);
}
