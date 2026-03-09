// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parkflow/models/auth/vehicle_model.dart';
import 'package:parkflow/models/auth/payment_method_model.dart';

part 'get_user_response_entity.freezed.dart';
part 'get_user_response_entity.g.dart';

@freezed
abstract class GetUserResponseEntity with _$GetUserResponseEntity {
  const GetUserResponseEntity._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GetUserResponseEntity({
    @JsonKey(name: "id") required String id,
    @JsonKey(name: "email") required String email,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "role") required String role,
    @JsonKey(name: "vehicles") @Default([]) List<VehicleModel> vehicles,
    @JsonKey(name: "payment_methods")
    @Default([])
    List<PaymentMethodModel> paymentMethods,
  }) = _GetUserResponseEntity;

  factory GetUserResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetUserResponseEntityFromJson(json);
}
