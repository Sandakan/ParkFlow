// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_camera_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateCameraRequest {

 String? get name; String? get rtspUrl;
/// Create a copy of UpdateCameraRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateCameraRequestCopyWith<UpdateCameraRequest> get copyWith => _$UpdateCameraRequestCopyWithImpl<UpdateCameraRequest>(this as UpdateCameraRequest, _$identity);

  /// Serializes this UpdateCameraRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateCameraRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.rtspUrl, rtspUrl) || other.rtspUrl == rtspUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,rtspUrl);

@override
String toString() {
  return 'UpdateCameraRequest(name: $name, rtspUrl: $rtspUrl)';
}


}

/// @nodoc
abstract mixin class $UpdateCameraRequestCopyWith<$Res>  {
  factory $UpdateCameraRequestCopyWith(UpdateCameraRequest value, $Res Function(UpdateCameraRequest) _then) = _$UpdateCameraRequestCopyWithImpl;
@useResult
$Res call({
 String? name, String? rtspUrl
});




}
/// @nodoc
class _$UpdateCameraRequestCopyWithImpl<$Res>
    implements $UpdateCameraRequestCopyWith<$Res> {
  _$UpdateCameraRequestCopyWithImpl(this._self, this._then);

  final UpdateCameraRequest _self;
  final $Res Function(UpdateCameraRequest) _then;

/// Create a copy of UpdateCameraRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? rtspUrl = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,rtspUrl: freezed == rtspUrl ? _self.rtspUrl : rtspUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateCameraRequest].
extension UpdateCameraRequestPatterns on UpdateCameraRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateCameraRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateCameraRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateCameraRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateCameraRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateCameraRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateCameraRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? rtspUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateCameraRequest() when $default != null:
return $default(_that.name,_that.rtspUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? rtspUrl)  $default,) {final _that = this;
switch (_that) {
case _UpdateCameraRequest():
return $default(_that.name,_that.rtspUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? rtspUrl)?  $default,) {final _that = this;
switch (_that) {
case _UpdateCameraRequest() when $default != null:
return $default(_that.name,_that.rtspUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateCameraRequest implements UpdateCameraRequest {
  const _UpdateCameraRequest({this.name, this.rtspUrl});
  factory _UpdateCameraRequest.fromJson(Map<String, dynamic> json) => _$UpdateCameraRequestFromJson(json);

@override final  String? name;
@override final  String? rtspUrl;

/// Create a copy of UpdateCameraRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateCameraRequestCopyWith<_UpdateCameraRequest> get copyWith => __$UpdateCameraRequestCopyWithImpl<_UpdateCameraRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateCameraRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateCameraRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.rtspUrl, rtspUrl) || other.rtspUrl == rtspUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,rtspUrl);

@override
String toString() {
  return 'UpdateCameraRequest(name: $name, rtspUrl: $rtspUrl)';
}


}

/// @nodoc
abstract mixin class _$UpdateCameraRequestCopyWith<$Res> implements $UpdateCameraRequestCopyWith<$Res> {
  factory _$UpdateCameraRequestCopyWith(_UpdateCameraRequest value, $Res Function(_UpdateCameraRequest) _then) = __$UpdateCameraRequestCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? rtspUrl
});




}
/// @nodoc
class __$UpdateCameraRequestCopyWithImpl<$Res>
    implements _$UpdateCameraRequestCopyWith<$Res> {
  __$UpdateCameraRequestCopyWithImpl(this._self, this._then);

  final _UpdateCameraRequest _self;
  final $Res Function(_UpdateCameraRequest) _then;

/// Create a copy of UpdateCameraRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? rtspUrl = freezed,}) {
  return _then(_UpdateCameraRequest(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,rtspUrl: freezed == rtspUrl ? _self.rtspUrl : rtspUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
