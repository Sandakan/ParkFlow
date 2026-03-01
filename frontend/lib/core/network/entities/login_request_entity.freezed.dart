// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginRequestEntity {

@JsonKey(name: "email") String get email;@JsonKey(name: "password") String get password;
/// Create a copy of LoginRequestEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginRequestEntityCopyWith<LoginRequestEntity> get copyWith => _$LoginRequestEntityCopyWithImpl<LoginRequestEntity>(this as LoginRequestEntity, _$identity);

  /// Serializes this LoginRequestEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginRequestEntity&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'LoginRequestEntity(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $LoginRequestEntityCopyWith<$Res>  {
  factory $LoginRequestEntityCopyWith(LoginRequestEntity value, $Res Function(LoginRequestEntity) _then) = _$LoginRequestEntityCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "email") String email,@JsonKey(name: "password") String password
});




}
/// @nodoc
class _$LoginRequestEntityCopyWithImpl<$Res>
    implements $LoginRequestEntityCopyWith<$Res> {
  _$LoginRequestEntityCopyWithImpl(this._self, this._then);

  final LoginRequestEntity _self;
  final $Res Function(LoginRequestEntity) _then;

/// Create a copy of LoginRequestEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginRequestEntity].
extension LoginRequestEntityPatterns on LoginRequestEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginRequestEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginRequestEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginRequestEntity value)  $default,){
final _that = this;
switch (_that) {
case _LoginRequestEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginRequestEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LoginRequestEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "email")  String email, @JsonKey(name: "password")  String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginRequestEntity() when $default != null:
return $default(_that.email,_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "email")  String email, @JsonKey(name: "password")  String password)  $default,) {final _that = this;
switch (_that) {
case _LoginRequestEntity():
return $default(_that.email,_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "email")  String email, @JsonKey(name: "password")  String password)?  $default,) {final _that = this;
switch (_that) {
case _LoginRequestEntity() when $default != null:
return $default(_that.email,_that.password);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _LoginRequestEntity extends LoginRequestEntity {
  const _LoginRequestEntity({@JsonKey(name: "email") required this.email, @JsonKey(name: "password") required this.password}): super._();
  factory _LoginRequestEntity.fromJson(Map<String, dynamic> json) => _$LoginRequestEntityFromJson(json);

@override@JsonKey(name: "email") final  String email;
@override@JsonKey(name: "password") final  String password;

/// Create a copy of LoginRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginRequestEntityCopyWith<_LoginRequestEntity> get copyWith => __$LoginRequestEntityCopyWithImpl<_LoginRequestEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginRequestEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginRequestEntity&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'LoginRequestEntity(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$LoginRequestEntityCopyWith<$Res> implements $LoginRequestEntityCopyWith<$Res> {
  factory _$LoginRequestEntityCopyWith(_LoginRequestEntity value, $Res Function(_LoginRequestEntity) _then) = __$LoginRequestEntityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "email") String email,@JsonKey(name: "password") String password
});




}
/// @nodoc
class __$LoginRequestEntityCopyWithImpl<$Res>
    implements _$LoginRequestEntityCopyWith<$Res> {
  __$LoginRequestEntityCopyWithImpl(this._self, this._then);

  final _LoginRequestEntity _self;
  final $Res Function(_LoginRequestEntity) _then;

/// Create a copy of LoginRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(_LoginRequestEntity(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
