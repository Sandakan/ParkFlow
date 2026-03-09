// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'camera_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CameraModel {

 String get id; String get name; String get rtspUrl; String get lotId; bool get isAlive; String? get lotName; String? get createdAt; String? get updatedAt;
/// Create a copy of CameraModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CameraModelCopyWith<CameraModel> get copyWith => _$CameraModelCopyWithImpl<CameraModel>(this as CameraModel, _$identity);

  /// Serializes this CameraModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CameraModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.rtspUrl, rtspUrl) || other.rtspUrl == rtspUrl)&&(identical(other.lotId, lotId) || other.lotId == lotId)&&(identical(other.isAlive, isAlive) || other.isAlive == isAlive)&&(identical(other.lotName, lotName) || other.lotName == lotName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,rtspUrl,lotId,isAlive,lotName,createdAt,updatedAt);

@override
String toString() {
  return 'CameraModel(id: $id, name: $name, rtspUrl: $rtspUrl, lotId: $lotId, isAlive: $isAlive, lotName: $lotName, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CameraModelCopyWith<$Res>  {
  factory $CameraModelCopyWith(CameraModel value, $Res Function(CameraModel) _then) = _$CameraModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String rtspUrl, String lotId, bool isAlive, String? lotName, String? createdAt, String? updatedAt
});




}
/// @nodoc
class _$CameraModelCopyWithImpl<$Res>
    implements $CameraModelCopyWith<$Res> {
  _$CameraModelCopyWithImpl(this._self, this._then);

  final CameraModel _self;
  final $Res Function(CameraModel) _then;

/// Create a copy of CameraModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? rtspUrl = null,Object? lotId = null,Object? isAlive = null,Object? lotName = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,rtspUrl: null == rtspUrl ? _self.rtspUrl : rtspUrl // ignore: cast_nullable_to_non_nullable
as String,lotId: null == lotId ? _self.lotId : lotId // ignore: cast_nullable_to_non_nullable
as String,isAlive: null == isAlive ? _self.isAlive : isAlive // ignore: cast_nullable_to_non_nullable
as bool,lotName: freezed == lotName ? _self.lotName : lotName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CameraModel].
extension CameraModelPatterns on CameraModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CameraModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CameraModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CameraModel value)  $default,){
final _that = this;
switch (_that) {
case _CameraModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CameraModel value)?  $default,){
final _that = this;
switch (_that) {
case _CameraModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String rtspUrl,  String lotId,  bool isAlive,  String? lotName,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CameraModel() when $default != null:
return $default(_that.id,_that.name,_that.rtspUrl,_that.lotId,_that.isAlive,_that.lotName,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String rtspUrl,  String lotId,  bool isAlive,  String? lotName,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CameraModel():
return $default(_that.id,_that.name,_that.rtspUrl,_that.lotId,_that.isAlive,_that.lotName,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String rtspUrl,  String lotId,  bool isAlive,  String? lotName,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CameraModel() when $default != null:
return $default(_that.id,_that.name,_that.rtspUrl,_that.lotId,_that.isAlive,_that.lotName,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CameraModel implements CameraModel {
  const _CameraModel({required this.id, required this.name, required this.rtspUrl, required this.lotId, this.isAlive = true, this.lotName, this.createdAt, this.updatedAt});
  factory _CameraModel.fromJson(Map<String, dynamic> json) => _$CameraModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String rtspUrl;
@override final  String lotId;
@override@JsonKey() final  bool isAlive;
@override final  String? lotName;
@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of CameraModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CameraModelCopyWith<_CameraModel> get copyWith => __$CameraModelCopyWithImpl<_CameraModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CameraModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CameraModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.rtspUrl, rtspUrl) || other.rtspUrl == rtspUrl)&&(identical(other.lotId, lotId) || other.lotId == lotId)&&(identical(other.isAlive, isAlive) || other.isAlive == isAlive)&&(identical(other.lotName, lotName) || other.lotName == lotName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,rtspUrl,lotId,isAlive,lotName,createdAt,updatedAt);

@override
String toString() {
  return 'CameraModel(id: $id, name: $name, rtspUrl: $rtspUrl, lotId: $lotId, isAlive: $isAlive, lotName: $lotName, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CameraModelCopyWith<$Res> implements $CameraModelCopyWith<$Res> {
  factory _$CameraModelCopyWith(_CameraModel value, $Res Function(_CameraModel) _then) = __$CameraModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String rtspUrl, String lotId, bool isAlive, String? lotName, String? createdAt, String? updatedAt
});




}
/// @nodoc
class __$CameraModelCopyWithImpl<$Res>
    implements _$CameraModelCopyWith<$Res> {
  __$CameraModelCopyWithImpl(this._self, this._then);

  final _CameraModel _self;
  final $Res Function(_CameraModel) _then;

/// Create a copy of CameraModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? rtspUrl = null,Object? lotId = null,Object? isAlive = null,Object? lotName = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_CameraModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,rtspUrl: null == rtspUrl ? _self.rtspUrl : rtspUrl // ignore: cast_nullable_to_non_nullable
as String,lotId: null == lotId ? _self.lotId : lotId // ignore: cast_nullable_to_non_nullable
as String,isAlive: null == isAlive ? _self.isAlive : isAlive // ignore: cast_nullable_to_non_nullable
as bool,lotName: freezed == lotName ? _self.lotName : lotName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
