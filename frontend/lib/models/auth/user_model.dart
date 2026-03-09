import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:parkflow/models/auth/payment_method_model.dart';
import 'package:parkflow/models/auth/vehicle_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String name,
    required String role,
    @Default([]) List<VehicleModel> vehicles,
    @Default([]) List<PaymentMethodModel> paymentMethods,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
