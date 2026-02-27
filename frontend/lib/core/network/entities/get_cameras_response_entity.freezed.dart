// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_cameras_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetCamerasResponseEntity {

 List<CameraModel> get cameras;
/// Create a copy of GetCamerasResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetCamerasResponseEntityCopyWith<GetCamerasResponseEntity> get copyWith => _$GetCamerasResponseEntityCopyWithImpl<GetCamerasResponseEntity>(this as GetCamerasResponseEntity, _$identity);

  /// Serializes this GetCamerasResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetCamerasResponseEntity&&const DeepCollectionEquality().equals(other.cameras, cameras));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cameras));

@override
String toString() {
  return 'GetCamerasResponseEntity(cameras: $cameras)';
}


}

/// @nodoc
abstract mixin class $GetCamerasResponseEntityCopyWith<$Res>  {
  factory $GetCamerasResponseEntityCopyWith(GetCamerasResponseEntity value, $Res Function(GetCamerasResponseEntity) _then) = _$GetCamerasResponseEntityCopyWithImpl;
@useResult
$Res call({
 List<CameraModel> cameras
});




}
/// @nodoc
class _$GetCamerasResponseEntityCopyWithImpl<$Res>
    implements $GetCamerasResponseEntityCopyWith<$Res> {
  _$GetCamerasResponseEntityCopyWithImpl(this._self, this._then);

  final GetCamerasResponseEntity _self;
  final $Res Function(GetCamerasResponseEntity) _then;

/// Create a copy of GetCamerasResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cameras = null,}) {
  return _then(_self.copyWith(
cameras: null == cameras ? _self.cameras : cameras // ignore: cast_nullable_to_non_nullable
as List<CameraModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [GetCamerasResponseEntity].
extension GetCamerasResponseEntityPatterns on GetCamerasResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetCamerasResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetCamerasResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetCamerasResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _GetCamerasResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetCamerasResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GetCamerasResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CameraModel> cameras)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetCamerasResponseEntity() when $default != null:
return $default(_that.cameras);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CameraModel> cameras)  $default,) {final _that = this;
switch (_that) {
case _GetCamerasResponseEntity():
return $default(_that.cameras);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CameraModel> cameras)?  $default,) {final _that = this;
switch (_that) {
case _GetCamerasResponseEntity() when $default != null:
return $default(_that.cameras);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetCamerasResponseEntity extends GetCamerasResponseEntity {
  const _GetCamerasResponseEntity({required final  List<CameraModel> cameras}): _cameras = cameras,super._();
  factory _GetCamerasResponseEntity.fromJson(Map<String, dynamic> json) => _$GetCamerasResponseEntityFromJson(json);

 final  List<CameraModel> _cameras;
@override List<CameraModel> get cameras {
  if (_cameras is EqualUnmodifiableListView) return _cameras;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cameras);
}


/// Create a copy of GetCamerasResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetCamerasResponseEntityCopyWith<_GetCamerasResponseEntity> get copyWith => __$GetCamerasResponseEntityCopyWithImpl<_GetCamerasResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetCamerasResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetCamerasResponseEntity&&const DeepCollectionEquality().equals(other._cameras, _cameras));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cameras));

@override
String toString() {
  return 'GetCamerasResponseEntity(cameras: $cameras)';
}


}

/// @nodoc
abstract mixin class _$GetCamerasResponseEntityCopyWith<$Res> implements $GetCamerasResponseEntityCopyWith<$Res> {
  factory _$GetCamerasResponseEntityCopyWith(_GetCamerasResponseEntity value, $Res Function(_GetCamerasResponseEntity) _then) = __$GetCamerasResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 List<CameraModel> cameras
});




}
/// @nodoc
class __$GetCamerasResponseEntityCopyWithImpl<$Res>
    implements _$GetCamerasResponseEntityCopyWith<$Res> {
  __$GetCamerasResponseEntityCopyWithImpl(this._self, this._then);

  final _GetCamerasResponseEntity _self;
  final $Res Function(_GetCamerasResponseEntity) _then;

/// Create a copy of GetCamerasResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cameras = null,}) {
  return _then(_GetCamerasResponseEntity(
cameras: null == cameras ? _self._cameras : cameras // ignore: cast_nullable_to_non_nullable
as List<CameraModel>,
  ));
}


}

// dart format on
