// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BaseResponseEntity {

 bool get success; String get message; String get code;@JsonKey(name: 'status_code') int get statusCode; dynamic get data;
/// Create a copy of BaseResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaseResponseEntityCopyWith<BaseResponseEntity> get copyWith => _$BaseResponseEntityCopyWithImpl<BaseResponseEntity>(this as BaseResponseEntity, _$identity);

  /// Serializes this BaseResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseResponseEntity&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,code,statusCode,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'BaseResponseEntity(success: $success, message: $message, code: $code, statusCode: $statusCode, data: $data)';
}


}

/// @nodoc
abstract mixin class $BaseResponseEntityCopyWith<$Res>  {
  factory $BaseResponseEntityCopyWith(BaseResponseEntity value, $Res Function(BaseResponseEntity) _then) = _$BaseResponseEntityCopyWithImpl;
@useResult
$Res call({
 bool success, String message, String code,@JsonKey(name: 'status_code') int statusCode, dynamic data
});




}
/// @nodoc
class _$BaseResponseEntityCopyWithImpl<$Res>
    implements $BaseResponseEntityCopyWith<$Res> {
  _$BaseResponseEntityCopyWithImpl(this._self, this._then);

  final BaseResponseEntity _self;
  final $Res Function(BaseResponseEntity) _then;

/// Create a copy of BaseResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? code = null,Object? statusCode = null,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [BaseResponseEntity].
extension BaseResponseEntityPatterns on BaseResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BaseResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BaseResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BaseResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _BaseResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BaseResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BaseResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  String code, @JsonKey(name: 'status_code')  int statusCode,  dynamic data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BaseResponseEntity() when $default != null:
return $default(_that.success,_that.message,_that.code,_that.statusCode,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  String code, @JsonKey(name: 'status_code')  int statusCode,  dynamic data)  $default,) {final _that = this;
switch (_that) {
case _BaseResponseEntity():
return $default(_that.success,_that.message,_that.code,_that.statusCode,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  String code, @JsonKey(name: 'status_code')  int statusCode,  dynamic data)?  $default,) {final _that = this;
switch (_that) {
case _BaseResponseEntity() when $default != null:
return $default(_that.success,_that.message,_that.code,_that.statusCode,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BaseResponseEntity implements BaseResponseEntity {
  const _BaseResponseEntity({required this.success, required this.message, required this.code, @JsonKey(name: 'status_code') required this.statusCode, required this.data});
  factory _BaseResponseEntity.fromJson(Map<String, dynamic> json) => _$BaseResponseEntityFromJson(json);

@override final  bool success;
@override final  String message;
@override final  String code;
@override@JsonKey(name: 'status_code') final  int statusCode;
@override final  dynamic data;

/// Create a copy of BaseResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BaseResponseEntityCopyWith<_BaseResponseEntity> get copyWith => __$BaseResponseEntityCopyWithImpl<_BaseResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BaseResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BaseResponseEntity&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,code,statusCode,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'BaseResponseEntity(success: $success, message: $message, code: $code, statusCode: $statusCode, data: $data)';
}


}

/// @nodoc
abstract mixin class _$BaseResponseEntityCopyWith<$Res> implements $BaseResponseEntityCopyWith<$Res> {
  factory _$BaseResponseEntityCopyWith(_BaseResponseEntity value, $Res Function(_BaseResponseEntity) _then) = __$BaseResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, String code,@JsonKey(name: 'status_code') int statusCode, dynamic data
});




}
/// @nodoc
class __$BaseResponseEntityCopyWithImpl<$Res>
    implements _$BaseResponseEntityCopyWith<$Res> {
  __$BaseResponseEntityCopyWithImpl(this._self, this._then);

  final _BaseResponseEntity _self;
  final $Res Function(_BaseResponseEntity) _then;

/// Create a copy of BaseResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? code = null,Object? statusCode = null,Object? data = freezed,}) {
  return _then(_BaseResponseEntity(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
