// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_reservation_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateReservationRequestEntity {

@JsonKey(name: 'slot_id') String get slotId;@JsonKey(name: 'lot_id') String? get lotId; VehicleModel get vehicle;@JsonKey(name: 'start_time') String get startTime;@JsonKey(name: 'duration_minutes') int get durationMinutes;@JsonKey(name: 'payment_method') String get paymentMethod;
/// Create a copy of CreateReservationRequestEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateReservationRequestEntityCopyWith<CreateReservationRequestEntity> get copyWith => _$CreateReservationRequestEntityCopyWithImpl<CreateReservationRequestEntity>(this as CreateReservationRequestEntity, _$identity);

  /// Serializes this CreateReservationRequestEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateReservationRequestEntity&&(identical(other.slotId, slotId) || other.slotId == slotId)&&(identical(other.lotId, lotId) || other.lotId == lotId)&&(identical(other.vehicle, vehicle) || other.vehicle == vehicle)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slotId,lotId,vehicle,startTime,durationMinutes,paymentMethod);

@override
String toString() {
  return 'CreateReservationRequestEntity(slotId: $slotId, lotId: $lotId, vehicle: $vehicle, startTime: $startTime, durationMinutes: $durationMinutes, paymentMethod: $paymentMethod)';
}


}

/// @nodoc
abstract mixin class $CreateReservationRequestEntityCopyWith<$Res>  {
  factory $CreateReservationRequestEntityCopyWith(CreateReservationRequestEntity value, $Res Function(CreateReservationRequestEntity) _then) = _$CreateReservationRequestEntityCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'slot_id') String slotId,@JsonKey(name: 'lot_id') String? lotId, VehicleModel vehicle,@JsonKey(name: 'start_time') String startTime,@JsonKey(name: 'duration_minutes') int durationMinutes,@JsonKey(name: 'payment_method') String paymentMethod
});


$VehicleModelCopyWith<$Res> get vehicle;

}
/// @nodoc
class _$CreateReservationRequestEntityCopyWithImpl<$Res>
    implements $CreateReservationRequestEntityCopyWith<$Res> {
  _$CreateReservationRequestEntityCopyWithImpl(this._self, this._then);

  final CreateReservationRequestEntity _self;
  final $Res Function(CreateReservationRequestEntity) _then;

/// Create a copy of CreateReservationRequestEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slotId = null,Object? lotId = freezed,Object? vehicle = null,Object? startTime = null,Object? durationMinutes = null,Object? paymentMethod = null,}) {
  return _then(_self.copyWith(
slotId: null == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String,lotId: freezed == lotId ? _self.lotId : lotId // ignore: cast_nullable_to_non_nullable
as String?,vehicle: null == vehicle ? _self.vehicle : vehicle // ignore: cast_nullable_to_non_nullable
as VehicleModel,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of CreateReservationRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VehicleModelCopyWith<$Res> get vehicle {
  
  return $VehicleModelCopyWith<$Res>(_self.vehicle, (value) {
    return _then(_self.copyWith(vehicle: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreateReservationRequestEntity].
extension CreateReservationRequestEntityPatterns on CreateReservationRequestEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateReservationRequestEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateReservationRequestEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateReservationRequestEntity value)  $default,){
final _that = this;
switch (_that) {
case _CreateReservationRequestEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateReservationRequestEntity value)?  $default,){
final _that = this;
switch (_that) {
case _CreateReservationRequestEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'slot_id')  String slotId, @JsonKey(name: 'lot_id')  String? lotId,  VehicleModel vehicle, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'duration_minutes')  int durationMinutes, @JsonKey(name: 'payment_method')  String paymentMethod)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateReservationRequestEntity() when $default != null:
return $default(_that.slotId,_that.lotId,_that.vehicle,_that.startTime,_that.durationMinutes,_that.paymentMethod);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'slot_id')  String slotId, @JsonKey(name: 'lot_id')  String? lotId,  VehicleModel vehicle, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'duration_minutes')  int durationMinutes, @JsonKey(name: 'payment_method')  String paymentMethod)  $default,) {final _that = this;
switch (_that) {
case _CreateReservationRequestEntity():
return $default(_that.slotId,_that.lotId,_that.vehicle,_that.startTime,_that.durationMinutes,_that.paymentMethod);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'slot_id')  String slotId, @JsonKey(name: 'lot_id')  String? lotId,  VehicleModel vehicle, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'duration_minutes')  int durationMinutes, @JsonKey(name: 'payment_method')  String paymentMethod)?  $default,) {final _that = this;
switch (_that) {
case _CreateReservationRequestEntity() when $default != null:
return $default(_that.slotId,_that.lotId,_that.vehicle,_that.startTime,_that.durationMinutes,_that.paymentMethod);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateReservationRequestEntity implements CreateReservationRequestEntity {
  const _CreateReservationRequestEntity({@JsonKey(name: 'slot_id') required this.slotId, @JsonKey(name: 'lot_id') this.lotId, required this.vehicle, @JsonKey(name: 'start_time') required this.startTime, @JsonKey(name: 'duration_minutes') required this.durationMinutes, @JsonKey(name: 'payment_method') required this.paymentMethod});
  factory _CreateReservationRequestEntity.fromJson(Map<String, dynamic> json) => _$CreateReservationRequestEntityFromJson(json);

@override@JsonKey(name: 'slot_id') final  String slotId;
@override@JsonKey(name: 'lot_id') final  String? lotId;
@override final  VehicleModel vehicle;
@override@JsonKey(name: 'start_time') final  String startTime;
@override@JsonKey(name: 'duration_minutes') final  int durationMinutes;
@override@JsonKey(name: 'payment_method') final  String paymentMethod;

/// Create a copy of CreateReservationRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateReservationRequestEntityCopyWith<_CreateReservationRequestEntity> get copyWith => __$CreateReservationRequestEntityCopyWithImpl<_CreateReservationRequestEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateReservationRequestEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateReservationRequestEntity&&(identical(other.slotId, slotId) || other.slotId == slotId)&&(identical(other.lotId, lotId) || other.lotId == lotId)&&(identical(other.vehicle, vehicle) || other.vehicle == vehicle)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slotId,lotId,vehicle,startTime,durationMinutes,paymentMethod);

@override
String toString() {
  return 'CreateReservationRequestEntity(slotId: $slotId, lotId: $lotId, vehicle: $vehicle, startTime: $startTime, durationMinutes: $durationMinutes, paymentMethod: $paymentMethod)';
}


}

/// @nodoc
abstract mixin class _$CreateReservationRequestEntityCopyWith<$Res> implements $CreateReservationRequestEntityCopyWith<$Res> {
  factory _$CreateReservationRequestEntityCopyWith(_CreateReservationRequestEntity value, $Res Function(_CreateReservationRequestEntity) _then) = __$CreateReservationRequestEntityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'slot_id') String slotId,@JsonKey(name: 'lot_id') String? lotId, VehicleModel vehicle,@JsonKey(name: 'start_time') String startTime,@JsonKey(name: 'duration_minutes') int durationMinutes,@JsonKey(name: 'payment_method') String paymentMethod
});


@override $VehicleModelCopyWith<$Res> get vehicle;

}
/// @nodoc
class __$CreateReservationRequestEntityCopyWithImpl<$Res>
    implements _$CreateReservationRequestEntityCopyWith<$Res> {
  __$CreateReservationRequestEntityCopyWithImpl(this._self, this._then);

  final _CreateReservationRequestEntity _self;
  final $Res Function(_CreateReservationRequestEntity) _then;

/// Create a copy of CreateReservationRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slotId = null,Object? lotId = freezed,Object? vehicle = null,Object? startTime = null,Object? durationMinutes = null,Object? paymentMethod = null,}) {
  return _then(_CreateReservationRequestEntity(
slotId: null == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String,lotId: freezed == lotId ? _self.lotId : lotId // ignore: cast_nullable_to_non_nullable
as String?,vehicle: null == vehicle ? _self.vehicle : vehicle // ignore: cast_nullable_to_non_nullable
as VehicleModel,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of CreateReservationRequestEntity
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
