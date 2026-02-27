// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_parking_lots_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetParkingLotsResponseEntity {

 List<ParkingLotModel> get lots;
/// Create a copy of GetParkingLotsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetParkingLotsResponseEntityCopyWith<GetParkingLotsResponseEntity> get copyWith => _$GetParkingLotsResponseEntityCopyWithImpl<GetParkingLotsResponseEntity>(this as GetParkingLotsResponseEntity, _$identity);

  /// Serializes this GetParkingLotsResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetParkingLotsResponseEntity&&const DeepCollectionEquality().equals(other.lots, lots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(lots));

@override
String toString() {
  return 'GetParkingLotsResponseEntity(lots: $lots)';
}


}

/// @nodoc
abstract mixin class $GetParkingLotsResponseEntityCopyWith<$Res>  {
  factory $GetParkingLotsResponseEntityCopyWith(GetParkingLotsResponseEntity value, $Res Function(GetParkingLotsResponseEntity) _then) = _$GetParkingLotsResponseEntityCopyWithImpl;
@useResult
$Res call({
 List<ParkingLotModel> lots
});




}
/// @nodoc
class _$GetParkingLotsResponseEntityCopyWithImpl<$Res>
    implements $GetParkingLotsResponseEntityCopyWith<$Res> {
  _$GetParkingLotsResponseEntityCopyWithImpl(this._self, this._then);

  final GetParkingLotsResponseEntity _self;
  final $Res Function(GetParkingLotsResponseEntity) _then;

/// Create a copy of GetParkingLotsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lots = null,}) {
  return _then(_self.copyWith(
lots: null == lots ? _self.lots : lots // ignore: cast_nullable_to_non_nullable
as List<ParkingLotModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [GetParkingLotsResponseEntity].
extension GetParkingLotsResponseEntityPatterns on GetParkingLotsResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetParkingLotsResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetParkingLotsResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetParkingLotsResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _GetParkingLotsResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetParkingLotsResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GetParkingLotsResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ParkingLotModel> lots)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetParkingLotsResponseEntity() when $default != null:
return $default(_that.lots);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ParkingLotModel> lots)  $default,) {final _that = this;
switch (_that) {
case _GetParkingLotsResponseEntity():
return $default(_that.lots);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ParkingLotModel> lots)?  $default,) {final _that = this;
switch (_that) {
case _GetParkingLotsResponseEntity() when $default != null:
return $default(_that.lots);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetParkingLotsResponseEntity extends GetParkingLotsResponseEntity {
  const _GetParkingLotsResponseEntity({required final  List<ParkingLotModel> lots}): _lots = lots,super._();
  factory _GetParkingLotsResponseEntity.fromJson(Map<String, dynamic> json) => _$GetParkingLotsResponseEntityFromJson(json);

 final  List<ParkingLotModel> _lots;
@override List<ParkingLotModel> get lots {
  if (_lots is EqualUnmodifiableListView) return _lots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lots);
}


/// Create a copy of GetParkingLotsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetParkingLotsResponseEntityCopyWith<_GetParkingLotsResponseEntity> get copyWith => __$GetParkingLotsResponseEntityCopyWithImpl<_GetParkingLotsResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetParkingLotsResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetParkingLotsResponseEntity&&const DeepCollectionEquality().equals(other._lots, _lots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_lots));

@override
String toString() {
  return 'GetParkingLotsResponseEntity(lots: $lots)';
}


}

/// @nodoc
abstract mixin class _$GetParkingLotsResponseEntityCopyWith<$Res> implements $GetParkingLotsResponseEntityCopyWith<$Res> {
  factory _$GetParkingLotsResponseEntityCopyWith(_GetParkingLotsResponseEntity value, $Res Function(_GetParkingLotsResponseEntity) _then) = __$GetParkingLotsResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 List<ParkingLotModel> lots
});




}
/// @nodoc
class __$GetParkingLotsResponseEntityCopyWithImpl<$Res>
    implements _$GetParkingLotsResponseEntityCopyWith<$Res> {
  __$GetParkingLotsResponseEntityCopyWithImpl(this._self, this._then);

  final _GetParkingLotsResponseEntity _self;
  final $Res Function(_GetParkingLotsResponseEntity) _then;

/// Create a copy of GetParkingLotsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lots = null,}) {
  return _then(_GetParkingLotsResponseEntity(
lots: null == lots ? _self._lots : lots // ignore: cast_nullable_to_non_nullable
as List<ParkingLotModel>,
  ));
}


}

// dart format on
