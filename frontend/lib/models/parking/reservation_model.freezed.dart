// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReservationModel {

 String get id;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'slot_id') String get slotId;@JsonKey(name: 'start_time') DateTime get startTime;@JsonKey(name: 'end_time') DateTime get endTime; VehicleModel get vehicle;@JsonKey(name: 'duration_minutes') int get durationMinutes;@JsonKey(name: 'payment_method') String get paymentMethod;@JsonKey(name: 'total_price') double get totalPrice;@JsonKey(name: 'base_rate') double get baseRate;@JsonKey(name: 'check_in_time') DateTime? get checkInTime;@JsonKey(name: 'check_out_time') DateTime? get checkOutTime;@JsonKey(name: 'actual_end_time') DateTime get actualEndTime;@JsonKey(name: 'total_billed_price') double get totalBilledPrice; String get status;@JsonKey(name: 'qr_code_token') String get qrCodeToken;@JsonKey(name: 'has_rating') bool get hasRating;@JsonKey(name: 'lot_name') String get lotName;@JsonKey(name: 'lot_address') String get lotAddress;@JsonKey(name: 'lot_latitude') double get lotLatitude;@JsonKey(name: 'lot_longitude') double get lotLongitude;@JsonKey(name: 'slot_name') String get slotName;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of ReservationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReservationModelCopyWith<ReservationModel> get copyWith => _$ReservationModelCopyWithImpl<ReservationModel>(this as ReservationModel, _$identity);

  /// Serializes this ReservationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReservationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.slotId, slotId) || other.slotId == slotId)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.vehicle, vehicle) || other.vehicle == vehicle)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice)&&(identical(other.baseRate, baseRate) || other.baseRate == baseRate)&&(identical(other.checkInTime, checkInTime) || other.checkInTime == checkInTime)&&(identical(other.checkOutTime, checkOutTime) || other.checkOutTime == checkOutTime)&&(identical(other.actualEndTime, actualEndTime) || other.actualEndTime == actualEndTime)&&(identical(other.totalBilledPrice, totalBilledPrice) || other.totalBilledPrice == totalBilledPrice)&&(identical(other.status, status) || other.status == status)&&(identical(other.qrCodeToken, qrCodeToken) || other.qrCodeToken == qrCodeToken)&&(identical(other.hasRating, hasRating) || other.hasRating == hasRating)&&(identical(other.lotName, lotName) || other.lotName == lotName)&&(identical(other.lotAddress, lotAddress) || other.lotAddress == lotAddress)&&(identical(other.lotLatitude, lotLatitude) || other.lotLatitude == lotLatitude)&&(identical(other.lotLongitude, lotLongitude) || other.lotLongitude == lotLongitude)&&(identical(other.slotName, slotName) || other.slotName == slotName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,slotId,startTime,endTime,vehicle,durationMinutes,paymentMethod,totalPrice,baseRate,checkInTime,checkOutTime,actualEndTime,totalBilledPrice,status,qrCodeToken,hasRating,lotName,lotAddress,lotLatitude,lotLongitude,slotName,createdAt,updatedAt]);

@override
String toString() {
  return 'ReservationModel(id: $id, userId: $userId, slotId: $slotId, startTime: $startTime, endTime: $endTime, vehicle: $vehicle, durationMinutes: $durationMinutes, paymentMethod: $paymentMethod, totalPrice: $totalPrice, baseRate: $baseRate, checkInTime: $checkInTime, checkOutTime: $checkOutTime, actualEndTime: $actualEndTime, totalBilledPrice: $totalBilledPrice, status: $status, qrCodeToken: $qrCodeToken, hasRating: $hasRating, lotName: $lotName, lotAddress: $lotAddress, lotLatitude: $lotLatitude, lotLongitude: $lotLongitude, slotName: $slotName, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ReservationModelCopyWith<$Res>  {
  factory $ReservationModelCopyWith(ReservationModel value, $Res Function(ReservationModel) _then) = _$ReservationModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'slot_id') String slotId,@JsonKey(name: 'start_time') DateTime startTime,@JsonKey(name: 'end_time') DateTime endTime, VehicleModel vehicle,@JsonKey(name: 'duration_minutes') int durationMinutes,@JsonKey(name: 'payment_method') String paymentMethod,@JsonKey(name: 'total_price') double totalPrice,@JsonKey(name: 'base_rate') double baseRate,@JsonKey(name: 'check_in_time') DateTime? checkInTime,@JsonKey(name: 'check_out_time') DateTime? checkOutTime,@JsonKey(name: 'actual_end_time') DateTime actualEndTime,@JsonKey(name: 'total_billed_price') double totalBilledPrice, String status,@JsonKey(name: 'qr_code_token') String qrCodeToken,@JsonKey(name: 'has_rating') bool hasRating,@JsonKey(name: 'lot_name') String lotName,@JsonKey(name: 'lot_address') String lotAddress,@JsonKey(name: 'lot_latitude') double lotLatitude,@JsonKey(name: 'lot_longitude') double lotLongitude,@JsonKey(name: 'slot_name') String slotName,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});


$VehicleModelCopyWith<$Res> get vehicle;

}
/// @nodoc
class _$ReservationModelCopyWithImpl<$Res>
    implements $ReservationModelCopyWith<$Res> {
  _$ReservationModelCopyWithImpl(this._self, this._then);

  final ReservationModel _self;
  final $Res Function(ReservationModel) _then;

/// Create a copy of ReservationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? slotId = null,Object? startTime = null,Object? endTime = null,Object? vehicle = null,Object? durationMinutes = null,Object? paymentMethod = null,Object? totalPrice = null,Object? baseRate = null,Object? checkInTime = freezed,Object? checkOutTime = freezed,Object? actualEndTime = null,Object? totalBilledPrice = null,Object? status = null,Object? qrCodeToken = null,Object? hasRating = null,Object? lotName = null,Object? lotAddress = null,Object? lotLatitude = null,Object? lotLongitude = null,Object? slotName = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,slotId: null == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,vehicle: null == vehicle ? _self.vehicle : vehicle // ignore: cast_nullable_to_non_nullable
as VehicleModel,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,totalPrice: null == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as double,baseRate: null == baseRate ? _self.baseRate : baseRate // ignore: cast_nullable_to_non_nullable
as double,checkInTime: freezed == checkInTime ? _self.checkInTime : checkInTime // ignore: cast_nullable_to_non_nullable
as DateTime?,checkOutTime: freezed == checkOutTime ? _self.checkOutTime : checkOutTime // ignore: cast_nullable_to_non_nullable
as DateTime?,actualEndTime: null == actualEndTime ? _self.actualEndTime : actualEndTime // ignore: cast_nullable_to_non_nullable
as DateTime,totalBilledPrice: null == totalBilledPrice ? _self.totalBilledPrice : totalBilledPrice // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,qrCodeToken: null == qrCodeToken ? _self.qrCodeToken : qrCodeToken // ignore: cast_nullable_to_non_nullable
as String,hasRating: null == hasRating ? _self.hasRating : hasRating // ignore: cast_nullable_to_non_nullable
as bool,lotName: null == lotName ? _self.lotName : lotName // ignore: cast_nullable_to_non_nullable
as String,lotAddress: null == lotAddress ? _self.lotAddress : lotAddress // ignore: cast_nullable_to_non_nullable
as String,lotLatitude: null == lotLatitude ? _self.lotLatitude : lotLatitude // ignore: cast_nullable_to_non_nullable
as double,lotLongitude: null == lotLongitude ? _self.lotLongitude : lotLongitude // ignore: cast_nullable_to_non_nullable
as double,slotName: null == slotName ? _self.slotName : slotName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of ReservationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VehicleModelCopyWith<$Res> get vehicle {
  
  return $VehicleModelCopyWith<$Res>(_self.vehicle, (value) {
    return _then(_self.copyWith(vehicle: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReservationModel].
extension ReservationModelPatterns on ReservationModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReservationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReservationModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReservationModel value)  $default,){
final _that = this;
switch (_that) {
case _ReservationModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReservationModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReservationModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'slot_id')  String slotId, @JsonKey(name: 'start_time')  DateTime startTime, @JsonKey(name: 'end_time')  DateTime endTime,  VehicleModel vehicle, @JsonKey(name: 'duration_minutes')  int durationMinutes, @JsonKey(name: 'payment_method')  String paymentMethod, @JsonKey(name: 'total_price')  double totalPrice, @JsonKey(name: 'base_rate')  double baseRate, @JsonKey(name: 'check_in_time')  DateTime? checkInTime, @JsonKey(name: 'check_out_time')  DateTime? checkOutTime, @JsonKey(name: 'actual_end_time')  DateTime actualEndTime, @JsonKey(name: 'total_billed_price')  double totalBilledPrice,  String status, @JsonKey(name: 'qr_code_token')  String qrCodeToken, @JsonKey(name: 'has_rating')  bool hasRating, @JsonKey(name: 'lot_name')  String lotName, @JsonKey(name: 'lot_address')  String lotAddress, @JsonKey(name: 'lot_latitude')  double lotLatitude, @JsonKey(name: 'lot_longitude')  double lotLongitude, @JsonKey(name: 'slot_name')  String slotName, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReservationModel() when $default != null:
return $default(_that.id,_that.userId,_that.slotId,_that.startTime,_that.endTime,_that.vehicle,_that.durationMinutes,_that.paymentMethod,_that.totalPrice,_that.baseRate,_that.checkInTime,_that.checkOutTime,_that.actualEndTime,_that.totalBilledPrice,_that.status,_that.qrCodeToken,_that.hasRating,_that.lotName,_that.lotAddress,_that.lotLatitude,_that.lotLongitude,_that.slotName,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'slot_id')  String slotId, @JsonKey(name: 'start_time')  DateTime startTime, @JsonKey(name: 'end_time')  DateTime endTime,  VehicleModel vehicle, @JsonKey(name: 'duration_minutes')  int durationMinutes, @JsonKey(name: 'payment_method')  String paymentMethod, @JsonKey(name: 'total_price')  double totalPrice, @JsonKey(name: 'base_rate')  double baseRate, @JsonKey(name: 'check_in_time')  DateTime? checkInTime, @JsonKey(name: 'check_out_time')  DateTime? checkOutTime, @JsonKey(name: 'actual_end_time')  DateTime actualEndTime, @JsonKey(name: 'total_billed_price')  double totalBilledPrice,  String status, @JsonKey(name: 'qr_code_token')  String qrCodeToken, @JsonKey(name: 'has_rating')  bool hasRating, @JsonKey(name: 'lot_name')  String lotName, @JsonKey(name: 'lot_address')  String lotAddress, @JsonKey(name: 'lot_latitude')  double lotLatitude, @JsonKey(name: 'lot_longitude')  double lotLongitude, @JsonKey(name: 'slot_name')  String slotName, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ReservationModel():
return $default(_that.id,_that.userId,_that.slotId,_that.startTime,_that.endTime,_that.vehicle,_that.durationMinutes,_that.paymentMethod,_that.totalPrice,_that.baseRate,_that.checkInTime,_that.checkOutTime,_that.actualEndTime,_that.totalBilledPrice,_that.status,_that.qrCodeToken,_that.hasRating,_that.lotName,_that.lotAddress,_that.lotLatitude,_that.lotLongitude,_that.slotName,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'slot_id')  String slotId, @JsonKey(name: 'start_time')  DateTime startTime, @JsonKey(name: 'end_time')  DateTime endTime,  VehicleModel vehicle, @JsonKey(name: 'duration_minutes')  int durationMinutes, @JsonKey(name: 'payment_method')  String paymentMethod, @JsonKey(name: 'total_price')  double totalPrice, @JsonKey(name: 'base_rate')  double baseRate, @JsonKey(name: 'check_in_time')  DateTime? checkInTime, @JsonKey(name: 'check_out_time')  DateTime? checkOutTime, @JsonKey(name: 'actual_end_time')  DateTime actualEndTime, @JsonKey(name: 'total_billed_price')  double totalBilledPrice,  String status, @JsonKey(name: 'qr_code_token')  String qrCodeToken, @JsonKey(name: 'has_rating')  bool hasRating, @JsonKey(name: 'lot_name')  String lotName, @JsonKey(name: 'lot_address')  String lotAddress, @JsonKey(name: 'lot_latitude')  double lotLatitude, @JsonKey(name: 'lot_longitude')  double lotLongitude, @JsonKey(name: 'slot_name')  String slotName, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ReservationModel() when $default != null:
return $default(_that.id,_that.userId,_that.slotId,_that.startTime,_that.endTime,_that.vehicle,_that.durationMinutes,_that.paymentMethod,_that.totalPrice,_that.baseRate,_that.checkInTime,_that.checkOutTime,_that.actualEndTime,_that.totalBilledPrice,_that.status,_that.qrCodeToken,_that.hasRating,_that.lotName,_that.lotAddress,_that.lotLatitude,_that.lotLongitude,_that.slotName,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReservationModel implements ReservationModel {
  const _ReservationModel({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'slot_id') required this.slotId, @JsonKey(name: 'start_time') required this.startTime, @JsonKey(name: 'end_time') required this.endTime, required this.vehicle, @JsonKey(name: 'duration_minutes') required this.durationMinutes, @JsonKey(name: 'payment_method') required this.paymentMethod, @JsonKey(name: 'total_price') required this.totalPrice, @JsonKey(name: 'base_rate') required this.baseRate, @JsonKey(name: 'check_in_time') this.checkInTime, @JsonKey(name: 'check_out_time') this.checkOutTime, @JsonKey(name: 'actual_end_time') required this.actualEndTime, @JsonKey(name: 'total_billed_price') required this.totalBilledPrice, required this.status, @JsonKey(name: 'qr_code_token') required this.qrCodeToken, @JsonKey(name: 'has_rating') required this.hasRating, @JsonKey(name: 'lot_name') required this.lotName, @JsonKey(name: 'lot_address') required this.lotAddress, @JsonKey(name: 'lot_latitude') required this.lotLatitude, @JsonKey(name: 'lot_longitude') required this.lotLongitude, @JsonKey(name: 'slot_name') required this.slotName, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _ReservationModel.fromJson(Map<String, dynamic> json) => _$ReservationModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'slot_id') final  String slotId;
@override@JsonKey(name: 'start_time') final  DateTime startTime;
@override@JsonKey(name: 'end_time') final  DateTime endTime;
@override final  VehicleModel vehicle;
@override@JsonKey(name: 'duration_minutes') final  int durationMinutes;
@override@JsonKey(name: 'payment_method') final  String paymentMethod;
@override@JsonKey(name: 'total_price') final  double totalPrice;
@override@JsonKey(name: 'base_rate') final  double baseRate;
@override@JsonKey(name: 'check_in_time') final  DateTime? checkInTime;
@override@JsonKey(name: 'check_out_time') final  DateTime? checkOutTime;
@override@JsonKey(name: 'actual_end_time') final  DateTime actualEndTime;
@override@JsonKey(name: 'total_billed_price') final  double totalBilledPrice;
@override final  String status;
@override@JsonKey(name: 'qr_code_token') final  String qrCodeToken;
@override@JsonKey(name: 'has_rating') final  bool hasRating;
@override@JsonKey(name: 'lot_name') final  String lotName;
@override@JsonKey(name: 'lot_address') final  String lotAddress;
@override@JsonKey(name: 'lot_latitude') final  double lotLatitude;
@override@JsonKey(name: 'lot_longitude') final  double lotLongitude;
@override@JsonKey(name: 'slot_name') final  String slotName;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of ReservationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReservationModelCopyWith<_ReservationModel> get copyWith => __$ReservationModelCopyWithImpl<_ReservationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReservationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReservationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.slotId, slotId) || other.slotId == slotId)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.vehicle, vehicle) || other.vehicle == vehicle)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice)&&(identical(other.baseRate, baseRate) || other.baseRate == baseRate)&&(identical(other.checkInTime, checkInTime) || other.checkInTime == checkInTime)&&(identical(other.checkOutTime, checkOutTime) || other.checkOutTime == checkOutTime)&&(identical(other.actualEndTime, actualEndTime) || other.actualEndTime == actualEndTime)&&(identical(other.totalBilledPrice, totalBilledPrice) || other.totalBilledPrice == totalBilledPrice)&&(identical(other.status, status) || other.status == status)&&(identical(other.qrCodeToken, qrCodeToken) || other.qrCodeToken == qrCodeToken)&&(identical(other.hasRating, hasRating) || other.hasRating == hasRating)&&(identical(other.lotName, lotName) || other.lotName == lotName)&&(identical(other.lotAddress, lotAddress) || other.lotAddress == lotAddress)&&(identical(other.lotLatitude, lotLatitude) || other.lotLatitude == lotLatitude)&&(identical(other.lotLongitude, lotLongitude) || other.lotLongitude == lotLongitude)&&(identical(other.slotName, slotName) || other.slotName == slotName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,slotId,startTime,endTime,vehicle,durationMinutes,paymentMethod,totalPrice,baseRate,checkInTime,checkOutTime,actualEndTime,totalBilledPrice,status,qrCodeToken,hasRating,lotName,lotAddress,lotLatitude,lotLongitude,slotName,createdAt,updatedAt]);

@override
String toString() {
  return 'ReservationModel(id: $id, userId: $userId, slotId: $slotId, startTime: $startTime, endTime: $endTime, vehicle: $vehicle, durationMinutes: $durationMinutes, paymentMethod: $paymentMethod, totalPrice: $totalPrice, baseRate: $baseRate, checkInTime: $checkInTime, checkOutTime: $checkOutTime, actualEndTime: $actualEndTime, totalBilledPrice: $totalBilledPrice, status: $status, qrCodeToken: $qrCodeToken, hasRating: $hasRating, lotName: $lotName, lotAddress: $lotAddress, lotLatitude: $lotLatitude, lotLongitude: $lotLongitude, slotName: $slotName, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ReservationModelCopyWith<$Res> implements $ReservationModelCopyWith<$Res> {
  factory _$ReservationModelCopyWith(_ReservationModel value, $Res Function(_ReservationModel) _then) = __$ReservationModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'slot_id') String slotId,@JsonKey(name: 'start_time') DateTime startTime,@JsonKey(name: 'end_time') DateTime endTime, VehicleModel vehicle,@JsonKey(name: 'duration_minutes') int durationMinutes,@JsonKey(name: 'payment_method') String paymentMethod,@JsonKey(name: 'total_price') double totalPrice,@JsonKey(name: 'base_rate') double baseRate,@JsonKey(name: 'check_in_time') DateTime? checkInTime,@JsonKey(name: 'check_out_time') DateTime? checkOutTime,@JsonKey(name: 'actual_end_time') DateTime actualEndTime,@JsonKey(name: 'total_billed_price') double totalBilledPrice, String status,@JsonKey(name: 'qr_code_token') String qrCodeToken,@JsonKey(name: 'has_rating') bool hasRating,@JsonKey(name: 'lot_name') String lotName,@JsonKey(name: 'lot_address') String lotAddress,@JsonKey(name: 'lot_latitude') double lotLatitude,@JsonKey(name: 'lot_longitude') double lotLongitude,@JsonKey(name: 'slot_name') String slotName,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});


@override $VehicleModelCopyWith<$Res> get vehicle;

}
/// @nodoc
class __$ReservationModelCopyWithImpl<$Res>
    implements _$ReservationModelCopyWith<$Res> {
  __$ReservationModelCopyWithImpl(this._self, this._then);

  final _ReservationModel _self;
  final $Res Function(_ReservationModel) _then;

/// Create a copy of ReservationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? slotId = null,Object? startTime = null,Object? endTime = null,Object? vehicle = null,Object? durationMinutes = null,Object? paymentMethod = null,Object? totalPrice = null,Object? baseRate = null,Object? checkInTime = freezed,Object? checkOutTime = freezed,Object? actualEndTime = null,Object? totalBilledPrice = null,Object? status = null,Object? qrCodeToken = null,Object? hasRating = null,Object? lotName = null,Object? lotAddress = null,Object? lotLatitude = null,Object? lotLongitude = null,Object? slotName = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_ReservationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,slotId: null == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,vehicle: null == vehicle ? _self.vehicle : vehicle // ignore: cast_nullable_to_non_nullable
as VehicleModel,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,totalPrice: null == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as double,baseRate: null == baseRate ? _self.baseRate : baseRate // ignore: cast_nullable_to_non_nullable
as double,checkInTime: freezed == checkInTime ? _self.checkInTime : checkInTime // ignore: cast_nullable_to_non_nullable
as DateTime?,checkOutTime: freezed == checkOutTime ? _self.checkOutTime : checkOutTime // ignore: cast_nullable_to_non_nullable
as DateTime?,actualEndTime: null == actualEndTime ? _self.actualEndTime : actualEndTime // ignore: cast_nullable_to_non_nullable
as DateTime,totalBilledPrice: null == totalBilledPrice ? _self.totalBilledPrice : totalBilledPrice // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,qrCodeToken: null == qrCodeToken ? _self.qrCodeToken : qrCodeToken // ignore: cast_nullable_to_non_nullable
as String,hasRating: null == hasRating ? _self.hasRating : hasRating // ignore: cast_nullable_to_non_nullable
as bool,lotName: null == lotName ? _self.lotName : lotName // ignore: cast_nullable_to_non_nullable
as String,lotAddress: null == lotAddress ? _self.lotAddress : lotAddress // ignore: cast_nullable_to_non_nullable
as String,lotLatitude: null == lotLatitude ? _self.lotLatitude : lotLatitude // ignore: cast_nullable_to_non_nullable
as double,lotLongitude: null == lotLongitude ? _self.lotLongitude : lotLongitude // ignore: cast_nullable_to_non_nullable
as double,slotName: null == slotName ? _self.slotName : slotName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of ReservationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VehicleModelCopyWith<$Res> get vehicle {
  
  return $VehicleModelCopyWith<$Res>(_self.vehicle, (value) {
    return _then(_self.copyWith(vehicle: value));
  });
}
}

// dart format on
