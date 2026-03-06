import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/repositories/interfaces/secure_storage_repository_interface.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:parkflow/repositories/providers/secure_storage_repository_provider.dart';
import 'package:parkflow/models/auth/user_model.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/utils/constants/enums/app_status_code.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';

part 'payment_service.g.dart';

class PaymentService {
  final RemoteRepositoryInterface _remote;
  final SecureStorageRepositoryInterface _storage;

  PaymentService(this._remote, this._storage);

  Future<UserModel> addPaymentMethod(
    String provider,
    String type, {
    String? last4,
    bool isDefault = false,
  }) async {
    try {
      if (provider.isEmpty || type.isEmpty) {
        throw const AppException(AppStatusCode.invalidResponse);
      }
      final token = await _storage.getAccessToken();
      final userResponse = await _remote.addPaymentMethod({
        'provider': provider,
        'type': type,
        'last4': last4,
        'is_default': isDefault,
      }, accessToken: token);

      return UserModel(
        id: userResponse.id,
        email: userResponse.email,
        name: userResponse.name,
        role: userResponse.role,
        vehicles: userResponse.vehicles,
        paymentMethods: userResponse.paymentMethods,
      );
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<UserModel> removePaymentMethod(String methodId) async {
    try {
      if (methodId.isEmpty) {
        throw const AppException(AppStatusCode.invalidResponse);
      }
      final token = await _storage.getAccessToken();
      final userResponse = await _remote.removePaymentMethod(
        methodId,
        accessToken: token,
      );

      return UserModel(
        id: userResponse.id,
        email: userResponse.email,
        name: userResponse.name,
        role: userResponse.role,
        vehicles: userResponse.vehicles,
        paymentMethods: userResponse.paymentMethods,
      );
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<UserModel> setDefaultPaymentMethod(String methodId) async {
    try {
      if (methodId.isEmpty) {
        throw const AppException(AppStatusCode.invalidResponse);
      }
      final token = await _storage.getAccessToken();
      final userResponse = await _remote.setDefaultPaymentMethod(
        methodId,
        accessToken: token,
      );

      return UserModel(
        id: userResponse.id,
        email: userResponse.email,
        name: userResponse.name,
        role: userResponse.role,
        vehicles: userResponse.vehicles,
        paymentMethods: userResponse.paymentMethods,
      );
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}

@riverpod
PaymentService paymentService(Ref ref) {
  final remote = ref.watch(remoteRepositoryProvider);
  final storage = ref.watch(secureStorageRepositoryProvider);
  return PaymentService(remote, storage);
}
