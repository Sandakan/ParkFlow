// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slot_availability_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SlotAvailabilityResponseEntity {

 bool get available; String? get slotId;
/// Create a copy of SlotAvailabilityResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlotAvailabilityResponseEntityCopyWith<SlotAvailabilityResponseEntity> get copyWith => _$SlotAvailabilityResponseEntityCopyWithImpl<SlotAvailabilityResponseEntity>(this as SlotAvailabilityResponseEntity, _$identity);

  /// Serializes this SlotAvailabilityResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlotAvailabilityResponseEntity&&(identical(other.available, available) || other.available == available)&&(identical(other.slotId, slotId) || other.slotId == slotId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,available,slotId);

@override
String toString() {
  return 'SlotAvailabilityResponseEntity(available: $available, slotId: $slotId)';
}


}

/// @nodoc
abstract mixin class $SlotAvailabilityResponseEntityCopyWith<$Res>  {
  factory $SlotAvailabilityResponseEntityCopyWith(SlotAvailabilityResponseEntity value, $Res Function(SlotAvailabilityResponseEntity) _then) = _$SlotAvailabilityResponseEntityCopyWithImpl;
@useResult
$Res call({
 bool available, String? slotId
});




}
/// @nodoc
class _$SlotAvailabilityResponseEntityCopyWithImpl<$Res>
    implements $SlotAvailabilityResponseEntityCopyWith<$Res> {
  _$SlotAvailabilityResponseEntityCopyWithImpl(this._self, this._then);

  final SlotAvailabilityResponseEntity _self;
  final $Res Function(SlotAvailabilityResponseEntity) _then;

/// Create a copy of SlotAvailabilityResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? available = null,Object? slotId = freezed,}) {
  return _then(_self.copyWith(
available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,slotId: freezed == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SlotAvailabilityResponseEntity].
extension SlotAvailabilityResponseEntityPatterns on SlotAvailabilityResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SlotAvailabilityResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SlotAvailabilityResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SlotAvailabilityResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _SlotAvailabilityResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SlotAvailabilityResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SlotAvailabilityResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool available,  String? slotId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SlotAvailabilityResponseEntity() when $default != null:
return $default(_that.available,_that.slotId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool available,  String? slotId)  $default,) {final _that = this;
switch (_that) {
case _SlotAvailabilityResponseEntity():
return $default(_that.available,_that.slotId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool available,  String? slotId)?  $default,) {final _that = this;
switch (_that) {
case _SlotAvailabilityResponseEntity() when $default != null:
return $default(_that.available,_that.slotId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SlotAvailabilityResponseEntity implements SlotAvailabilityResponseEntity {
  const _SlotAvailabilityResponseEntity({required this.available, this.slotId});
  factory _SlotAvailabilityResponseEntity.fromJson(Map<String, dynamic> json) => _$SlotAvailabilityResponseEntityFromJson(json);

@override final  bool available;
@override final  String? slotId;

/// Create a copy of SlotAvailabilityResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SlotAvailabilityResponseEntityCopyWith<_SlotAvailabilityResponseEntity> get copyWith => __$SlotAvailabilityResponseEntityCopyWithImpl<_SlotAvailabilityResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SlotAvailabilityResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SlotAvailabilityResponseEntity&&(identical(other.available, available) || other.available == available)&&(identical(other.slotId, slotId) || other.slotId == slotId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,available,slotId);

@override
String toString() {
  return 'SlotAvailabilityResponseEntity(available: $available, slotId: $slotId)';
}


}

/// @nodoc
abstract mixin class _$SlotAvailabilityResponseEntityCopyWith<$Res> implements $SlotAvailabilityResponseEntityCopyWith<$Res> {
  factory _$SlotAvailabilityResponseEntityCopyWith(_SlotAvailabilityResponseEntity value, $Res Function(_SlotAvailabilityResponseEntity) _then) = __$SlotAvailabilityResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 bool available, String? slotId
});




}
/// @nodoc
class __$SlotAvailabilityResponseEntityCopyWithImpl<$Res>
    implements _$SlotAvailabilityResponseEntityCopyWith<$Res> {
  __$SlotAvailabilityResponseEntityCopyWithImpl(this._self, this._then);

  final _SlotAvailabilityResponseEntity _self;
  final $Res Function(_SlotAvailabilityResponseEntity) _then;

/// Create a copy of SlotAvailabilityResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? available = null,Object? slotId = freezed,}) {
  return _then(_SlotAvailabilityResponseEntity(
available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,slotId: freezed == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
