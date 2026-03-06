// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReservationResponseEntity {

 ReservationModel get reservation;
/// Create a copy of ReservationResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReservationResponseEntityCopyWith<ReservationResponseEntity> get copyWith => _$ReservationResponseEntityCopyWithImpl<ReservationResponseEntity>(this as ReservationResponseEntity, _$identity);

  /// Serializes this ReservationResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReservationResponseEntity&&(identical(other.reservation, reservation) || other.reservation == reservation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reservation);

@override
String toString() {
  return 'ReservationResponseEntity(reservation: $reservation)';
}


}

/// @nodoc
abstract mixin class $ReservationResponseEntityCopyWith<$Res>  {
  factory $ReservationResponseEntityCopyWith(ReservationResponseEntity value, $Res Function(ReservationResponseEntity) _then) = _$ReservationResponseEntityCopyWithImpl;
@useResult
$Res call({
 ReservationModel reservation
});


$ReservationModelCopyWith<$Res> get reservation;

}
/// @nodoc
class _$ReservationResponseEntityCopyWithImpl<$Res>
    implements $ReservationResponseEntityCopyWith<$Res> {
  _$ReservationResponseEntityCopyWithImpl(this._self, this._then);

  final ReservationResponseEntity _self;
  final $Res Function(ReservationResponseEntity) _then;

/// Create a copy of ReservationResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reservation = null,}) {
  return _then(_self.copyWith(
reservation: null == reservation ? _self.reservation : reservation // ignore: cast_nullable_to_non_nullable
as ReservationModel,
  ));
}
/// Create a copy of ReservationResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReservationModelCopyWith<$Res> get reservation {
  
  return $ReservationModelCopyWith<$Res>(_self.reservation, (value) {
    return _then(_self.copyWith(reservation: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReservationResponseEntity].
extension ReservationResponseEntityPatterns on ReservationResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReservationResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReservationResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReservationResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _ReservationResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReservationResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ReservationResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReservationModel reservation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReservationResponseEntity() when $default != null:
return $default(_that.reservation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReservationModel reservation)  $default,) {final _that = this;
switch (_that) {
case _ReservationResponseEntity():
return $default(_that.reservation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReservationModel reservation)?  $default,) {final _that = this;
switch (_that) {
case _ReservationResponseEntity() when $default != null:
return $default(_that.reservation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReservationResponseEntity implements ReservationResponseEntity {
  const _ReservationResponseEntity({required this.reservation});
  factory _ReservationResponseEntity.fromJson(Map<String, dynamic> json) => _$ReservationResponseEntityFromJson(json);

@override final  ReservationModel reservation;

/// Create a copy of ReservationResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReservationResponseEntityCopyWith<_ReservationResponseEntity> get copyWith => __$ReservationResponseEntityCopyWithImpl<_ReservationResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReservationResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReservationResponseEntity&&(identical(other.reservation, reservation) || other.reservation == reservation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reservation);

@override
String toString() {
  return 'ReservationResponseEntity(reservation: $reservation)';
}


}

/// @nodoc
abstract mixin class _$ReservationResponseEntityCopyWith<$Res> implements $ReservationResponseEntityCopyWith<$Res> {
  factory _$ReservationResponseEntityCopyWith(_ReservationResponseEntity value, $Res Function(_ReservationResponseEntity) _then) = __$ReservationResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 ReservationModel reservation
});


@override $ReservationModelCopyWith<$Res> get reservation;

}
/// @nodoc
class __$ReservationResponseEntityCopyWithImpl<$Res>
    implements _$ReservationResponseEntityCopyWith<$Res> {
  __$ReservationResponseEntityCopyWithImpl(this._self, this._then);

  final _ReservationResponseEntity _self;
  final $Res Function(_ReservationResponseEntity) _then;

/// Create a copy of ReservationResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reservation = null,}) {
  return _then(_ReservationResponseEntity(
reservation: null == reservation ? _self.reservation : reservation // ignore: cast_nullable_to_non_nullable
as ReservationModel,
  ));
}

/// Create a copy of ReservationResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReservationModelCopyWith<$Res> get reservation {
  
  return $ReservationModelCopyWith<$Res>(_self.reservation, (value) {
    return _then(_self.copyWith(reservation: value));
  });
}
}

// dart format on
