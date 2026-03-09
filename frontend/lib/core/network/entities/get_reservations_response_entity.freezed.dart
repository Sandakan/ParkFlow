// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_reservations_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetReservationsResponseEntity {

 List<ReservationModel> get reservations;
/// Create a copy of GetReservationsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetReservationsResponseEntityCopyWith<GetReservationsResponseEntity> get copyWith => _$GetReservationsResponseEntityCopyWithImpl<GetReservationsResponseEntity>(this as GetReservationsResponseEntity, _$identity);

  /// Serializes this GetReservationsResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetReservationsResponseEntity&&const DeepCollectionEquality().equals(other.reservations, reservations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(reservations));

@override
String toString() {
  return 'GetReservationsResponseEntity(reservations: $reservations)';
}


}

/// @nodoc
abstract mixin class $GetReservationsResponseEntityCopyWith<$Res>  {
  factory $GetReservationsResponseEntityCopyWith(GetReservationsResponseEntity value, $Res Function(GetReservationsResponseEntity) _then) = _$GetReservationsResponseEntityCopyWithImpl;
@useResult
$Res call({
 List<ReservationModel> reservations
});




}
/// @nodoc
class _$GetReservationsResponseEntityCopyWithImpl<$Res>
    implements $GetReservationsResponseEntityCopyWith<$Res> {
  _$GetReservationsResponseEntityCopyWithImpl(this._self, this._then);

  final GetReservationsResponseEntity _self;
  final $Res Function(GetReservationsResponseEntity) _then;

/// Create a copy of GetReservationsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reservations = null,}) {
  return _then(_self.copyWith(
reservations: null == reservations ? _self.reservations : reservations // ignore: cast_nullable_to_non_nullable
as List<ReservationModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [GetReservationsResponseEntity].
extension GetReservationsResponseEntityPatterns on GetReservationsResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetReservationsResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetReservationsResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetReservationsResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _GetReservationsResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetReservationsResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GetReservationsResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ReservationModel> reservations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetReservationsResponseEntity() when $default != null:
return $default(_that.reservations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ReservationModel> reservations)  $default,) {final _that = this;
switch (_that) {
case _GetReservationsResponseEntity():
return $default(_that.reservations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ReservationModel> reservations)?  $default,) {final _that = this;
switch (_that) {
case _GetReservationsResponseEntity() when $default != null:
return $default(_that.reservations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetReservationsResponseEntity implements GetReservationsResponseEntity {
  const _GetReservationsResponseEntity({required final  List<ReservationModel> reservations}): _reservations = reservations;
  factory _GetReservationsResponseEntity.fromJson(Map<String, dynamic> json) => _$GetReservationsResponseEntityFromJson(json);

 final  List<ReservationModel> _reservations;
@override List<ReservationModel> get reservations {
  if (_reservations is EqualUnmodifiableListView) return _reservations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reservations);
}


/// Create a copy of GetReservationsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetReservationsResponseEntityCopyWith<_GetReservationsResponseEntity> get copyWith => __$GetReservationsResponseEntityCopyWithImpl<_GetReservationsResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetReservationsResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetReservationsResponseEntity&&const DeepCollectionEquality().equals(other._reservations, _reservations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_reservations));

@override
String toString() {
  return 'GetReservationsResponseEntity(reservations: $reservations)';
}


}

/// @nodoc
abstract mixin class _$GetReservationsResponseEntityCopyWith<$Res> implements $GetReservationsResponseEntityCopyWith<$Res> {
  factory _$GetReservationsResponseEntityCopyWith(_GetReservationsResponseEntity value, $Res Function(_GetReservationsResponseEntity) _then) = __$GetReservationsResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 List<ReservationModel> reservations
});




}
/// @nodoc
class __$GetReservationsResponseEntityCopyWithImpl<$Res>
    implements _$GetReservationsResponseEntityCopyWith<$Res> {
  __$GetReservationsResponseEntityCopyWithImpl(this._self, this._then);

  final _GetReservationsResponseEntity _self;
  final $Res Function(_GetReservationsResponseEntity) _then;

/// Create a copy of GetReservationsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reservations = null,}) {
  return _then(_GetReservationsResponseEntity(
reservations: null == reservations ? _self._reservations : reservations // ignore: cast_nullable_to_non_nullable
as List<ReservationModel>,
  ));
}


}

// dart format on
