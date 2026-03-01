// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_webrtc_offer_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetWebrtcOfferResponseEntity {

 String get sdp; String get type;
/// Create a copy of GetWebrtcOfferResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetWebrtcOfferResponseEntityCopyWith<GetWebrtcOfferResponseEntity> get copyWith => _$GetWebrtcOfferResponseEntityCopyWithImpl<GetWebrtcOfferResponseEntity>(this as GetWebrtcOfferResponseEntity, _$identity);

  /// Serializes this GetWebrtcOfferResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetWebrtcOfferResponseEntity&&(identical(other.sdp, sdp) || other.sdp == sdp)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sdp,type);

@override
String toString() {
  return 'GetWebrtcOfferResponseEntity(sdp: $sdp, type: $type)';
}


}

/// @nodoc
abstract mixin class $GetWebrtcOfferResponseEntityCopyWith<$Res>  {
  factory $GetWebrtcOfferResponseEntityCopyWith(GetWebrtcOfferResponseEntity value, $Res Function(GetWebrtcOfferResponseEntity) _then) = _$GetWebrtcOfferResponseEntityCopyWithImpl;
@useResult
$Res call({
 String sdp, String type
});




}
/// @nodoc
class _$GetWebrtcOfferResponseEntityCopyWithImpl<$Res>
    implements $GetWebrtcOfferResponseEntityCopyWith<$Res> {
  _$GetWebrtcOfferResponseEntityCopyWithImpl(this._self, this._then);

  final GetWebrtcOfferResponseEntity _self;
  final $Res Function(GetWebrtcOfferResponseEntity) _then;

/// Create a copy of GetWebrtcOfferResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sdp = null,Object? type = null,}) {
  return _then(_self.copyWith(
sdp: null == sdp ? _self.sdp : sdp // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GetWebrtcOfferResponseEntity].
extension GetWebrtcOfferResponseEntityPatterns on GetWebrtcOfferResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetWebrtcOfferResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetWebrtcOfferResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetWebrtcOfferResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _GetWebrtcOfferResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetWebrtcOfferResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GetWebrtcOfferResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sdp,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetWebrtcOfferResponseEntity() when $default != null:
return $default(_that.sdp,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sdp,  String type)  $default,) {final _that = this;
switch (_that) {
case _GetWebrtcOfferResponseEntity():
return $default(_that.sdp,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sdp,  String type)?  $default,) {final _that = this;
switch (_that) {
case _GetWebrtcOfferResponseEntity() when $default != null:
return $default(_that.sdp,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetWebrtcOfferResponseEntity implements GetWebrtcOfferResponseEntity {
  const _GetWebrtcOfferResponseEntity({required this.sdp, required this.type});
  factory _GetWebrtcOfferResponseEntity.fromJson(Map<String, dynamic> json) => _$GetWebrtcOfferResponseEntityFromJson(json);

@override final  String sdp;
@override final  String type;

/// Create a copy of GetWebrtcOfferResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetWebrtcOfferResponseEntityCopyWith<_GetWebrtcOfferResponseEntity> get copyWith => __$GetWebrtcOfferResponseEntityCopyWithImpl<_GetWebrtcOfferResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetWebrtcOfferResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetWebrtcOfferResponseEntity&&(identical(other.sdp, sdp) || other.sdp == sdp)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sdp,type);

@override
String toString() {
  return 'GetWebrtcOfferResponseEntity(sdp: $sdp, type: $type)';
}


}

/// @nodoc
abstract mixin class _$GetWebrtcOfferResponseEntityCopyWith<$Res> implements $GetWebrtcOfferResponseEntityCopyWith<$Res> {
  factory _$GetWebrtcOfferResponseEntityCopyWith(_GetWebrtcOfferResponseEntity value, $Res Function(_GetWebrtcOfferResponseEntity) _then) = __$GetWebrtcOfferResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 String sdp, String type
});




}
/// @nodoc
class __$GetWebrtcOfferResponseEntityCopyWithImpl<$Res>
    implements _$GetWebrtcOfferResponseEntityCopyWith<$Res> {
  __$GetWebrtcOfferResponseEntityCopyWithImpl(this._self, this._then);

  final _GetWebrtcOfferResponseEntity _self;
  final $Res Function(_GetWebrtcOfferResponseEntity) _then;

/// Create a copy of GetWebrtcOfferResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sdp = null,Object? type = null,}) {
  return _then(_GetWebrtcOfferResponseEntity(
sdp: null == sdp ? _self.sdp : sdp // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
