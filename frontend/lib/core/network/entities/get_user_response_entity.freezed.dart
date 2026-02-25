// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_user_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetUserResponseEntity {

@JsonKey(name: "id") String get id;@JsonKey(name: "email") String get email;@JsonKey(name: "name") String get name;@JsonKey(name: "role") String get role;
/// Create a copy of GetUserResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetUserResponseEntityCopyWith<GetUserResponseEntity> get copyWith => _$GetUserResponseEntityCopyWithImpl<GetUserResponseEntity>(this as GetUserResponseEntity, _$identity);

  /// Serializes this GetUserResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetUserResponseEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,name,role);

@override
String toString() {
  return 'GetUserResponseEntity(id: $id, email: $email, name: $name, role: $role)';
}


}

/// @nodoc
abstract mixin class $GetUserResponseEntityCopyWith<$Res>  {
  factory $GetUserResponseEntityCopyWith(GetUserResponseEntity value, $Res Function(GetUserResponseEntity) _then) = _$GetUserResponseEntityCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "id") String id,@JsonKey(name: "email") String email,@JsonKey(name: "name") String name,@JsonKey(name: "role") String role
});




}
/// @nodoc
class _$GetUserResponseEntityCopyWithImpl<$Res>
    implements $GetUserResponseEntityCopyWith<$Res> {
  _$GetUserResponseEntityCopyWithImpl(this._self, this._then);

  final GetUserResponseEntity _self;
  final $Res Function(GetUserResponseEntity) _then;

/// Create a copy of GetUserResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? name = null,Object? role = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GetUserResponseEntity].
extension GetUserResponseEntityPatterns on GetUserResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetUserResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetUserResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetUserResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _GetUserResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetUserResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GetUserResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  String id, @JsonKey(name: "email")  String email, @JsonKey(name: "name")  String name, @JsonKey(name: "role")  String role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetUserResponseEntity() when $default != null:
return $default(_that.id,_that.email,_that.name,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  String id, @JsonKey(name: "email")  String email, @JsonKey(name: "name")  String name, @JsonKey(name: "role")  String role)  $default,) {final _that = this;
switch (_that) {
case _GetUserResponseEntity():
return $default(_that.id,_that.email,_that.name,_that.role);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "id")  String id, @JsonKey(name: "email")  String email, @JsonKey(name: "name")  String name, @JsonKey(name: "role")  String role)?  $default,) {final _that = this;
switch (_that) {
case _GetUserResponseEntity() when $default != null:
return $default(_that.id,_that.email,_that.name,_that.role);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _GetUserResponseEntity extends GetUserResponseEntity {
  const _GetUserResponseEntity({@JsonKey(name: "id") required this.id, @JsonKey(name: "email") required this.email, @JsonKey(name: "name") required this.name, @JsonKey(name: "role") required this.role}): super._();
  factory _GetUserResponseEntity.fromJson(Map<String, dynamic> json) => _$GetUserResponseEntityFromJson(json);

@override@JsonKey(name: "id") final  String id;
@override@JsonKey(name: "email") final  String email;
@override@JsonKey(name: "name") final  String name;
@override@JsonKey(name: "role") final  String role;

/// Create a copy of GetUserResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetUserResponseEntityCopyWith<_GetUserResponseEntity> get copyWith => __$GetUserResponseEntityCopyWithImpl<_GetUserResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetUserResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetUserResponseEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,name,role);

@override
String toString() {
  return 'GetUserResponseEntity(id: $id, email: $email, name: $name, role: $role)';
}


}

/// @nodoc
abstract mixin class _$GetUserResponseEntityCopyWith<$Res> implements $GetUserResponseEntityCopyWith<$Res> {
  factory _$GetUserResponseEntityCopyWith(_GetUserResponseEntity value, $Res Function(_GetUserResponseEntity) _then) = __$GetUserResponseEntityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "id") String id,@JsonKey(name: "email") String email,@JsonKey(name: "name") String name,@JsonKey(name: "role") String role
});




}
/// @nodoc
class __$GetUserResponseEntityCopyWithImpl<$Res>
    implements _$GetUserResponseEntityCopyWith<$Res> {
  __$GetUserResponseEntityCopyWithImpl(this._self, this._then);

  final _GetUserResponseEntity _self;
  final $Res Function(_GetUserResponseEntity) _then;

/// Create a copy of GetUserResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? name = null,Object? role = null,}) {
  return _then(_GetUserResponseEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
