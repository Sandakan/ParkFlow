// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reset_password_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResetPasswordRequestEntity {

 String get email; String get otp; String get password;
/// Create a copy of ResetPasswordRequestEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordRequestEntityCopyWith<ResetPasswordRequestEntity> get copyWith => _$ResetPasswordRequestEntityCopyWithImpl<ResetPasswordRequestEntity>(this as ResetPasswordRequestEntity, _$identity);

  /// Serializes this ResetPasswordRequestEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordRequestEntity&&(identical(other.email, email) || other.email == email)&&(identical(other.otp, otp) || other.otp == otp)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,otp,password);

@override
String toString() {
  return 'ResetPasswordRequestEntity(email: $email, otp: $otp, password: $password)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordRequestEntityCopyWith<$Res>  {
  factory $ResetPasswordRequestEntityCopyWith(ResetPasswordRequestEntity value, $Res Function(ResetPasswordRequestEntity) _then) = _$ResetPasswordRequestEntityCopyWithImpl;
@useResult
$Res call({
 String email, String otp, String password
});




}
/// @nodoc
class _$ResetPasswordRequestEntityCopyWithImpl<$Res>
    implements $ResetPasswordRequestEntityCopyWith<$Res> {
  _$ResetPasswordRequestEntityCopyWithImpl(this._self, this._then);

  final ResetPasswordRequestEntity _self;
  final $Res Function(ResetPasswordRequestEntity) _then;

/// Create a copy of ResetPasswordRequestEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? otp = null,Object? password = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ResetPasswordRequestEntity].
extension ResetPasswordRequestEntityPatterns on ResetPasswordRequestEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResetPasswordRequestEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResetPasswordRequestEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResetPasswordRequestEntity value)  $default,){
final _that = this;
switch (_that) {
case _ResetPasswordRequestEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResetPasswordRequestEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ResetPasswordRequestEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String otp,  String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResetPasswordRequestEntity() when $default != null:
return $default(_that.email,_that.otp,_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String otp,  String password)  $default,) {final _that = this;
switch (_that) {
case _ResetPasswordRequestEntity():
return $default(_that.email,_that.otp,_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String otp,  String password)?  $default,) {final _that = this;
switch (_that) {
case _ResetPasswordRequestEntity() when $default != null:
return $default(_that.email,_that.otp,_that.password);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResetPasswordRequestEntity implements ResetPasswordRequestEntity {
  const _ResetPasswordRequestEntity({required this.email, required this.otp, required this.password});
  factory _ResetPasswordRequestEntity.fromJson(Map<String, dynamic> json) => _$ResetPasswordRequestEntityFromJson(json);

@override final  String email;
@override final  String otp;
@override final  String password;

/// Create a copy of ResetPasswordRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResetPasswordRequestEntityCopyWith<_ResetPasswordRequestEntity> get copyWith => __$ResetPasswordRequestEntityCopyWithImpl<_ResetPasswordRequestEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResetPasswordRequestEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetPasswordRequestEntity&&(identical(other.email, email) || other.email == email)&&(identical(other.otp, otp) || other.otp == otp)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,otp,password);

@override
String toString() {
  return 'ResetPasswordRequestEntity(email: $email, otp: $otp, password: $password)';
}


}

/// @nodoc
abstract mixin class _$ResetPasswordRequestEntityCopyWith<$Res> implements $ResetPasswordRequestEntityCopyWith<$Res> {
  factory _$ResetPasswordRequestEntityCopyWith(_ResetPasswordRequestEntity value, $Res Function(_ResetPasswordRequestEntity) _then) = __$ResetPasswordRequestEntityCopyWithImpl;
@override @useResult
$Res call({
 String email, String otp, String password
});




}
/// @nodoc
class __$ResetPasswordRequestEntityCopyWithImpl<$Res>
    implements _$ResetPasswordRequestEntityCopyWith<$Res> {
  __$ResetPasswordRequestEntityCopyWithImpl(this._self, this._then);

  final _ResetPasswordRequestEntity _self;
  final $Res Function(_ResetPasswordRequestEntity) _then;

/// Create a copy of ResetPasswordRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? otp = null,Object? password = null,}) {
  return _then(_ResetPasswordRequestEntity(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
