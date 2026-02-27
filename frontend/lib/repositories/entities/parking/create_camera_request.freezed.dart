// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_camera_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateCameraRequest {

@JsonKey(name: 'lot_id') String get lotId; String get name;@JsonKey(name: 'rtsp_url') String get rtspUrl;
/// Create a copy of CreateCameraRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateCameraRequestCopyWith<CreateCameraRequest> get copyWith => _$CreateCameraRequestCopyWithImpl<CreateCameraRequest>(this as CreateCameraRequest, _$identity);

  /// Serializes this CreateCameraRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateCameraRequest&&(identical(other.lotId, lotId) || other.lotId == lotId)&&(identical(other.name, name) || other.name == name)&&(identical(other.rtspUrl, rtspUrl) || other.rtspUrl == rtspUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lotId,name,rtspUrl);

@override
String toString() {
  return 'CreateCameraRequest(lotId: $lotId, name: $name, rtspUrl: $rtspUrl)';
}


}

/// @nodoc
abstract mixin class $CreateCameraRequestCopyWith<$Res>  {
  factory $CreateCameraRequestCopyWith(CreateCameraRequest value, $Res Function(CreateCameraRequest) _then) = _$CreateCameraRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'lot_id') String lotId, String name,@JsonKey(name: 'rtsp_url') String rtspUrl
});




}
/// @nodoc
class _$CreateCameraRequestCopyWithImpl<$Res>
    implements $CreateCameraRequestCopyWith<$Res> {
  _$CreateCameraRequestCopyWithImpl(this._self, this._then);

  final CreateCameraRequest _self;
  final $Res Function(CreateCameraRequest) _then;

/// Create a copy of CreateCameraRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lotId = null,Object? name = null,Object? rtspUrl = null,}) {
  return _then(_self.copyWith(
lotId: null == lotId ? _self.lotId : lotId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,rtspUrl: null == rtspUrl ? _self.rtspUrl : rtspUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateCameraRequest].
extension CreateCameraRequestPatterns on CreateCameraRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateCameraRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateCameraRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateCameraRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateCameraRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateCameraRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateCameraRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'lot_id')  String lotId,  String name, @JsonKey(name: 'rtsp_url')  String rtspUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateCameraRequest() when $default != null:
return $default(_that.lotId,_that.name,_that.rtspUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'lot_id')  String lotId,  String name, @JsonKey(name: 'rtsp_url')  String rtspUrl)  $default,) {final _that = this;
switch (_that) {
case _CreateCameraRequest():
return $default(_that.lotId,_that.name,_that.rtspUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'lot_id')  String lotId,  String name, @JsonKey(name: 'rtsp_url')  String rtspUrl)?  $default,) {final _that = this;
switch (_that) {
case _CreateCameraRequest() when $default != null:
return $default(_that.lotId,_that.name,_that.rtspUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateCameraRequest implements CreateCameraRequest {
  const _CreateCameraRequest({@JsonKey(name: 'lot_id') required this.lotId, required this.name, @JsonKey(name: 'rtsp_url') required this.rtspUrl});
  factory _CreateCameraRequest.fromJson(Map<String, dynamic> json) => _$CreateCameraRequestFromJson(json);

@override@JsonKey(name: 'lot_id') final  String lotId;
@override final  String name;
@override@JsonKey(name: 'rtsp_url') final  String rtspUrl;

/// Create a copy of CreateCameraRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateCameraRequestCopyWith<_CreateCameraRequest> get copyWith => __$CreateCameraRequestCopyWithImpl<_CreateCameraRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateCameraRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateCameraRequest&&(identical(other.lotId, lotId) || other.lotId == lotId)&&(identical(other.name, name) || other.name == name)&&(identical(other.rtspUrl, rtspUrl) || other.rtspUrl == rtspUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lotId,name,rtspUrl);

@override
String toString() {
  return 'CreateCameraRequest(lotId: $lotId, name: $name, rtspUrl: $rtspUrl)';
}


}

/// @nodoc
abstract mixin class _$CreateCameraRequestCopyWith<$Res> implements $CreateCameraRequestCopyWith<$Res> {
  factory _$CreateCameraRequestCopyWith(_CreateCameraRequest value, $Res Function(_CreateCameraRequest) _then) = __$CreateCameraRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'lot_id') String lotId, String name,@JsonKey(name: 'rtsp_url') String rtspUrl
});




}
/// @nodoc
class __$CreateCameraRequestCopyWithImpl<$Res>
    implements _$CreateCameraRequestCopyWith<$Res> {
  __$CreateCameraRequestCopyWithImpl(this._self, this._then);

  final _CreateCameraRequest _self;
  final $Res Function(_CreateCameraRequest) _then;

/// Create a copy of CreateCameraRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lotId = null,Object? name = null,Object? rtspUrl = null,}) {
  return _then(_CreateCameraRequest(
lotId: null == lotId ? _self.lotId : lotId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,rtspUrl: null == rtspUrl ? _self.rtspUrl : rtspUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
