// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginResponseEntity {

@JsonKey(name: "access_token") String get accessToken;@JsonKey(name: "refresh_token") String get refreshToken;@JsonKey(name: "token_type") String get tokenType;
/// Create a copy of LoginResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginResponseEntityCopyWith<LoginResponseEntity> get copyWith => _$LoginResponseEntityCopyWithImpl<LoginResponseEntity>(this as LoginResponseEntity, _$identity);

  /// Serializes this LoginResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginResponseEntity&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,tokenType);

@override
String toString() {
  return 'LoginResponseEntity(accessToken: $accessToken, refreshToken: $refreshToken, tokenType: $tokenType)';
}


}

/// @nodoc
abstract mixin class $LoginResponseEntityCopyWith<$Res>  {
  factory $LoginResponseEntityCopyWith(LoginResponseEntity value, $Res Function(LoginResponseEntity) _then) = _$LoginResponseEntityCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "access_token") String accessToken,@JsonKey(name: "refresh_token") String refreshToken,@JsonKey(name: "token_type") String tokenType
});




}
/// @nodoc
class _$LoginResponseEntityCopyWithImpl<$Res>
    implements $LoginResponseEntityCopyWith<$Res> {
  _$LoginResponseEntityCopyWithImpl(this._self, this._then);

  final LoginResponseEntity _self;
  final $Res Function(LoginResponseEntity) _then;

/// Create a copy of LoginResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? refreshToken = null,Object? tokenType = null,}) {
  return _then(_self.copyWith(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,tokenType: null == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginResponseEntity].
extension LoginResponseEntityPatterns on LoginResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _LoginResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LoginResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "access_token")  String accessToken, @JsonKey(name: "refresh_token")  String refreshToken, @JsonKey(name: "token_type")  String tokenType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginResponseEntity() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.tokenType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "access_token")  String accessToken, @JsonKey(name: "refresh_token")  String refreshToken, @JsonKey(name: "token_type")  String tokenType)  $default,) {final _that = this;
switch (_that) {
case _LoginResponseEntity():
return $default(_that.accessToken,_that.refreshToken,_that.tokenType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "access_token")  String accessToken, @JsonKey(name: "refresh_token")  String refreshToken, @JsonKey(name: "token_type")  String tokenType)?  $default,) {final _that = this;
switch (_that) {
case _LoginResponseEntity() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.tokenType);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _LoginResponseEntity extends LoginResponseEntity {
  const _LoginResponseEntity({@JsonKey(name: "access_token") required this.accessToken, @JsonKey(name: "refresh_token") required this.refreshToken, @JsonKey(name: "token_type") required this.tokenType}): super._();
  factory _LoginResponseEntity.fromJson(Map<String, dynamic> json) => _$LoginResponseEntityFromJson(json);

@override@JsonKey(name: "access_token") final  String accessToken;
@override@JsonKey(name: "refresh_token") final  String refreshToken;
@override@JsonKey(name: "token_type") final  String tokenType;

/// Create a copy of LoginResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginResponseEntityCopyWith<_LoginResponseEntity> get copyWith => __$LoginResponseEntityCopyWithImpl<_LoginResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginResponseEntity&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,tokenType);

@override
String toString() {
  return 'LoginResponseEntity(accessToken: $accessToken, refreshToken: $refreshToken, tokenType: $tokenType)';
}


}

/// @nodoc
abstract mixin class _$LoginResponseEntityCopyWith<$Res> implements $LoginResponseEntityCopyWith<$Res> {
  factory _$LoginResponseEntityCopyWith(_LoginResponseEntity value, $Res Function(_LoginResponseEntity) _then) = __$LoginResponseEntityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "access_token") String accessToken,@JsonKey(name: "refresh_token") String refreshToken,@JsonKey(name: "token_type") String tokenType
});




}
/// @nodoc
class __$LoginResponseEntityCopyWithImpl<$Res>
    implements _$LoginResponseEntityCopyWith<$Res> {
  __$LoginResponseEntityCopyWithImpl(this._self, this._then);

  final _LoginResponseEntity _self;
  final $Res Function(_LoginResponseEntity) _then;

/// Create a copy of LoginResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? refreshToken = null,Object? tokenType = null,}) {
  return _then(_LoginResponseEntity(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,tokenType: null == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
