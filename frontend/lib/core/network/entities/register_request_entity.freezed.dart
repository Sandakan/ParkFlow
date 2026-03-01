// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegisterRequestEntity {

@JsonKey(name: "name") String get name;@JsonKey(name: "email") String get email;@JsonKey(name: "password") String get password;
/// Create a copy of RegisterRequestEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterRequestEntityCopyWith<RegisterRequestEntity> get copyWith => _$RegisterRequestEntityCopyWithImpl<RegisterRequestEntity>(this as RegisterRequestEntity, _$identity);

  /// Serializes this RegisterRequestEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterRequestEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,email,password);

@override
String toString() {
  return 'RegisterRequestEntity(name: $name, email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $RegisterRequestEntityCopyWith<$Res>  {
  factory $RegisterRequestEntityCopyWith(RegisterRequestEntity value, $Res Function(RegisterRequestEntity) _then) = _$RegisterRequestEntityCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "name") String name,@JsonKey(name: "email") String email,@JsonKey(name: "password") String password
});




}
/// @nodoc
class _$RegisterRequestEntityCopyWithImpl<$Res>
    implements $RegisterRequestEntityCopyWith<$Res> {
  _$RegisterRequestEntityCopyWithImpl(this._self, this._then);

  final RegisterRequestEntity _self;
  final $Res Function(RegisterRequestEntity) _then;

/// Create a copy of RegisterRequestEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? email = null,Object? password = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterRequestEntity].
extension RegisterRequestEntityPatterns on RegisterRequestEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterRequestEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterRequestEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterRequestEntity value)  $default,){
final _that = this;
switch (_that) {
case _RegisterRequestEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterRequestEntity value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterRequestEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "name")  String name, @JsonKey(name: "email")  String email, @JsonKey(name: "password")  String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterRequestEntity() when $default != null:
return $default(_that.name,_that.email,_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "name")  String name, @JsonKey(name: "email")  String email, @JsonKey(name: "password")  String password)  $default,) {final _that = this;
switch (_that) {
case _RegisterRequestEntity():
return $default(_that.name,_that.email,_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "name")  String name, @JsonKey(name: "email")  String email, @JsonKey(name: "password")  String password)?  $default,) {final _that = this;
switch (_that) {
case _RegisterRequestEntity() when $default != null:
return $default(_that.name,_that.email,_that.password);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _RegisterRequestEntity extends RegisterRequestEntity {
  const _RegisterRequestEntity({@JsonKey(name: "name") required this.name, @JsonKey(name: "email") required this.email, @JsonKey(name: "password") required this.password}): super._();
  factory _RegisterRequestEntity.fromJson(Map<String, dynamic> json) => _$RegisterRequestEntityFromJson(json);

@override@JsonKey(name: "name") final  String name;
@override@JsonKey(name: "email") final  String email;
@override@JsonKey(name: "password") final  String password;

/// Create a copy of RegisterRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterRequestEntityCopyWith<_RegisterRequestEntity> get copyWith => __$RegisterRequestEntityCopyWithImpl<_RegisterRequestEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterRequestEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterRequestEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,email,password);

@override
String toString() {
  return 'RegisterRequestEntity(name: $name, email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$RegisterRequestEntityCopyWith<$Res> implements $RegisterRequestEntityCopyWith<$Res> {
  factory _$RegisterRequestEntityCopyWith(_RegisterRequestEntity value, $Res Function(_RegisterRequestEntity) _then) = __$RegisterRequestEntityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "name") String name,@JsonKey(name: "email") String email,@JsonKey(name: "password") String password
});




}
/// @nodoc
class __$RegisterRequestEntityCopyWithImpl<$Res>
    implements _$RegisterRequestEntityCopyWith<$Res> {
  __$RegisterRequestEntityCopyWithImpl(this._self, this._then);

  final _RegisterRequestEntity _self;
  final $Res Function(_RegisterRequestEntity) _then;

/// Create a copy of RegisterRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,Object? password = null,}) {
  return _then(_RegisterRequestEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
