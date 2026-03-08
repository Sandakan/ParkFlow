// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_otp_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VerifyOtpRequestEntity {

 String get email; String get otp;
/// Create a copy of VerifyOtpRequestEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyOtpRequestEntityCopyWith<VerifyOtpRequestEntity> get copyWith => _$VerifyOtpRequestEntityCopyWithImpl<VerifyOtpRequestEntity>(this as VerifyOtpRequestEntity, _$identity);

  /// Serializes this VerifyOtpRequestEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpRequestEntity&&(identical(other.email, email) || other.email == email)&&(identical(other.otp, otp) || other.otp == otp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,otp);

@override
String toString() {
  return 'VerifyOtpRequestEntity(email: $email, otp: $otp)';
}


}

/// @nodoc
abstract mixin class $VerifyOtpRequestEntityCopyWith<$Res>  {
  factory $VerifyOtpRequestEntityCopyWith(VerifyOtpRequestEntity value, $Res Function(VerifyOtpRequestEntity) _then) = _$VerifyOtpRequestEntityCopyWithImpl;
@useResult
$Res call({
 String email, String otp
});




}
/// @nodoc
class _$VerifyOtpRequestEntityCopyWithImpl<$Res>
    implements $VerifyOtpRequestEntityCopyWith<$Res> {
  _$VerifyOtpRequestEntityCopyWithImpl(this._self, this._then);

  final VerifyOtpRequestEntity _self;
  final $Res Function(VerifyOtpRequestEntity) _then;

/// Create a copy of VerifyOtpRequestEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? otp = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyOtpRequestEntity].
extension VerifyOtpRequestEntityPatterns on VerifyOtpRequestEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyOtpRequestEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyOtpRequestEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyOtpRequestEntity value)  $default,){
final _that = this;
switch (_that) {
case _VerifyOtpRequestEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyOtpRequestEntity value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyOtpRequestEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String otp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyOtpRequestEntity() when $default != null:
return $default(_that.email,_that.otp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String otp)  $default,) {final _that = this;
switch (_that) {
case _VerifyOtpRequestEntity():
return $default(_that.email,_that.otp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String otp)?  $default,) {final _that = this;
switch (_that) {
case _VerifyOtpRequestEntity() when $default != null:
return $default(_that.email,_that.otp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyOtpRequestEntity implements VerifyOtpRequestEntity {
  const _VerifyOtpRequestEntity({required this.email, required this.otp});
  factory _VerifyOtpRequestEntity.fromJson(Map<String, dynamic> json) => _$VerifyOtpRequestEntityFromJson(json);

@override final  String email;
@override final  String otp;

/// Create a copy of VerifyOtpRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyOtpRequestEntityCopyWith<_VerifyOtpRequestEntity> get copyWith => __$VerifyOtpRequestEntityCopyWithImpl<_VerifyOtpRequestEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyOtpRequestEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyOtpRequestEntity&&(identical(other.email, email) || other.email == email)&&(identical(other.otp, otp) || other.otp == otp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,otp);

@override
String toString() {
  return 'VerifyOtpRequestEntity(email: $email, otp: $otp)';
}


}

/// @nodoc
abstract mixin class _$VerifyOtpRequestEntityCopyWith<$Res> implements $VerifyOtpRequestEntityCopyWith<$Res> {
  factory _$VerifyOtpRequestEntityCopyWith(_VerifyOtpRequestEntity value, $Res Function(_VerifyOtpRequestEntity) _then) = __$VerifyOtpRequestEntityCopyWithImpl;
@override @useResult
$Res call({
 String email, String otp
});




}
/// @nodoc
class __$VerifyOtpRequestEntityCopyWithImpl<$Res>
    implements _$VerifyOtpRequestEntityCopyWith<$Res> {
  __$VerifyOtpRequestEntityCopyWithImpl(this._self, this._then);

  final _VerifyOtpRequestEntity _self;
  final $Res Function(_VerifyOtpRequestEntity) _then;

/// Create a copy of VerifyOtpRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? otp = null,}) {
  return _then(_VerifyOtpRequestEntity(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
