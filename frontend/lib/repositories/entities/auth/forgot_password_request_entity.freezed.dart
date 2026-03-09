// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgot_password_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ForgotPasswordRequestEntity {

 String get email;
/// Create a copy of ForgotPasswordRequestEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForgotPasswordRequestEntityCopyWith<ForgotPasswordRequestEntity> get copyWith => _$ForgotPasswordRequestEntityCopyWithImpl<ForgotPasswordRequestEntity>(this as ForgotPasswordRequestEntity, _$identity);

  /// Serializes this ForgotPasswordRequestEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordRequestEntity&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'ForgotPasswordRequestEntity(email: $email)';
}


}

/// @nodoc
abstract mixin class $ForgotPasswordRequestEntityCopyWith<$Res>  {
  factory $ForgotPasswordRequestEntityCopyWith(ForgotPasswordRequestEntity value, $Res Function(ForgotPasswordRequestEntity) _then) = _$ForgotPasswordRequestEntityCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$ForgotPasswordRequestEntityCopyWithImpl<$Res>
    implements $ForgotPasswordRequestEntityCopyWith<$Res> {
  _$ForgotPasswordRequestEntityCopyWithImpl(this._self, this._then);

  final ForgotPasswordRequestEntity _self;
  final $Res Function(ForgotPasswordRequestEntity) _then;

/// Create a copy of ForgotPasswordRequestEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ForgotPasswordRequestEntity].
extension ForgotPasswordRequestEntityPatterns on ForgotPasswordRequestEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ForgotPasswordRequestEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ForgotPasswordRequestEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ForgotPasswordRequestEntity value)  $default,){
final _that = this;
switch (_that) {
case _ForgotPasswordRequestEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ForgotPasswordRequestEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ForgotPasswordRequestEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ForgotPasswordRequestEntity() when $default != null:
return $default(_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email)  $default,) {final _that = this;
switch (_that) {
case _ForgotPasswordRequestEntity():
return $default(_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email)?  $default,) {final _that = this;
switch (_that) {
case _ForgotPasswordRequestEntity() when $default != null:
return $default(_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ForgotPasswordRequestEntity implements ForgotPasswordRequestEntity {
  const _ForgotPasswordRequestEntity({required this.email});
  factory _ForgotPasswordRequestEntity.fromJson(Map<String, dynamic> json) => _$ForgotPasswordRequestEntityFromJson(json);

@override final  String email;

/// Create a copy of ForgotPasswordRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForgotPasswordRequestEntityCopyWith<_ForgotPasswordRequestEntity> get copyWith => __$ForgotPasswordRequestEntityCopyWithImpl<_ForgotPasswordRequestEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ForgotPasswordRequestEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForgotPasswordRequestEntity&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'ForgotPasswordRequestEntity(email: $email)';
}


}

/// @nodoc
abstract mixin class _$ForgotPasswordRequestEntityCopyWith<$Res> implements $ForgotPasswordRequestEntityCopyWith<$Res> {
  factory _$ForgotPasswordRequestEntityCopyWith(_ForgotPasswordRequestEntity value, $Res Function(_ForgotPasswordRequestEntity) _then) = __$ForgotPasswordRequestEntityCopyWithImpl;
@override @useResult
$Res call({
 String email
});




}
/// @nodoc
class __$ForgotPasswordRequestEntityCopyWithImpl<$Res>
    implements _$ForgotPasswordRequestEntityCopyWith<$Res> {
  __$ForgotPasswordRequestEntityCopyWithImpl(this._self, this._then);

  final _ForgotPasswordRequestEntity _self;
  final $Res Function(_ForgotPasswordRequestEntity) _then;

/// Create a copy of ForgotPasswordRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_ForgotPasswordRequestEntity(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
