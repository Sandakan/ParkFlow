// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_parking_slots_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetParkingSlotsResponseEntity {

@JsonKey(name: "slots") List<ParkingSlotModel> get slots;
/// Create a copy of GetParkingSlotsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetParkingSlotsResponseEntityCopyWith<GetParkingSlotsResponseEntity> get copyWith => _$GetParkingSlotsResponseEntityCopyWithImpl<GetParkingSlotsResponseEntity>(this as GetParkingSlotsResponseEntity, _$identity);

  /// Serializes this GetParkingSlotsResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetParkingSlotsResponseEntity&&const DeepCollectionEquality().equals(other.slots, slots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(slots));

@override
String toString() {
  return 'GetParkingSlotsResponseEntity(slots: $slots)';
}


}

/// @nodoc
abstract mixin class $GetParkingSlotsResponseEntityCopyWith<$Res>  {
  factory $GetParkingSlotsResponseEntityCopyWith(GetParkingSlotsResponseEntity value, $Res Function(GetParkingSlotsResponseEntity) _then) = _$GetParkingSlotsResponseEntityCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "slots") List<ParkingSlotModel> slots
});




}
/// @nodoc
class _$GetParkingSlotsResponseEntityCopyWithImpl<$Res>
    implements $GetParkingSlotsResponseEntityCopyWith<$Res> {
  _$GetParkingSlotsResponseEntityCopyWithImpl(this._self, this._then);

  final GetParkingSlotsResponseEntity _self;
  final $Res Function(GetParkingSlotsResponseEntity) _then;

/// Create a copy of GetParkingSlotsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slots = null,}) {
  return _then(_self.copyWith(
slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as List<ParkingSlotModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [GetParkingSlotsResponseEntity].
extension GetParkingSlotsResponseEntityPatterns on GetParkingSlotsResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetParkingSlotsResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetParkingSlotsResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetParkingSlotsResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _GetParkingSlotsResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetParkingSlotsResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GetParkingSlotsResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "slots")  List<ParkingSlotModel> slots)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetParkingSlotsResponseEntity() when $default != null:
return $default(_that.slots);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "slots")  List<ParkingSlotModel> slots)  $default,) {final _that = this;
switch (_that) {
case _GetParkingSlotsResponseEntity():
return $default(_that.slots);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "slots")  List<ParkingSlotModel> slots)?  $default,) {final _that = this;
switch (_that) {
case _GetParkingSlotsResponseEntity() when $default != null:
return $default(_that.slots);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _GetParkingSlotsResponseEntity extends GetParkingSlotsResponseEntity {
  const _GetParkingSlotsResponseEntity({@JsonKey(name: "slots") required final  List<ParkingSlotModel> slots}): _slots = slots,super._();
  factory _GetParkingSlotsResponseEntity.fromJson(Map<String, dynamic> json) => _$GetParkingSlotsResponseEntityFromJson(json);

 final  List<ParkingSlotModel> _slots;
@override@JsonKey(name: "slots") List<ParkingSlotModel> get slots {
  if (_slots is EqualUnmodifiableListView) return _slots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slots);
}


/// Create a copy of GetParkingSlotsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetParkingSlotsResponseEntityCopyWith<_GetParkingSlotsResponseEntity> get copyWith => __$GetParkingSlotsResponseEntityCopyWithImpl<_GetParkingSlotsResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetParkingSlotsResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetParkingSlotsResponseEntity&&const DeepCollectionEquality().equals(other._slots, _slots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_slots));

@override
String toString() {
  return 'GetParkingSlotsResponseEntity(slots: $slots)';
}


}

/// @nodoc
abstract mixin class _$GetParkingSlotsResponseEntityCopyWith<$Res> implements $GetParkingSlotsResponseEntityCopyWith<$Res> {
  factory _$GetParkingSlotsResponseEntityCopyWith(_GetParkingSlotsResponseEntity value, $Res Function(_GetParkingSlotsResponseEntity) _then) = __$GetParkingSlotsResponseEntityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "slots") List<ParkingSlotModel> slots
});




}
/// @nodoc
class __$GetParkingSlotsResponseEntityCopyWithImpl<$Res>
    implements _$GetParkingSlotsResponseEntityCopyWith<$Res> {
  __$GetParkingSlotsResponseEntityCopyWithImpl(this._self, this._then);

  final _GetParkingSlotsResponseEntity _self;
  final $Res Function(_GetParkingSlotsResponseEntity) _then;

/// Create a copy of GetParkingSlotsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slots = null,}) {
  return _then(_GetParkingSlotsResponseEntity(
slots: null == slots ? _self._slots : slots // ignore: cast_nullable_to_non_nullable
as List<ParkingSlotModel>,
  ));
}


}

// dart format on
