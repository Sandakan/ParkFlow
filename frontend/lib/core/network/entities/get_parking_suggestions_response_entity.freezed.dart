// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_parking_suggestions_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetParkingSuggestionsResponseEntity {

 List<ParkingSuggestionEntity> get suggestions;
/// Create a copy of GetParkingSuggestionsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetParkingSuggestionsResponseEntityCopyWith<GetParkingSuggestionsResponseEntity> get copyWith => _$GetParkingSuggestionsResponseEntityCopyWithImpl<GetParkingSuggestionsResponseEntity>(this as GetParkingSuggestionsResponseEntity, _$identity);

  /// Serializes this GetParkingSuggestionsResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetParkingSuggestionsResponseEntity&&const DeepCollectionEquality().equals(other.suggestions, suggestions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(suggestions));

@override
String toString() {
  return 'GetParkingSuggestionsResponseEntity(suggestions: $suggestions)';
}


}

/// @nodoc
abstract mixin class $GetParkingSuggestionsResponseEntityCopyWith<$Res>  {
  factory $GetParkingSuggestionsResponseEntityCopyWith(GetParkingSuggestionsResponseEntity value, $Res Function(GetParkingSuggestionsResponseEntity) _then) = _$GetParkingSuggestionsResponseEntityCopyWithImpl;
@useResult
$Res call({
 List<ParkingSuggestionEntity> suggestions
});




}
/// @nodoc
class _$GetParkingSuggestionsResponseEntityCopyWithImpl<$Res>
    implements $GetParkingSuggestionsResponseEntityCopyWith<$Res> {
  _$GetParkingSuggestionsResponseEntityCopyWithImpl(this._self, this._then);

  final GetParkingSuggestionsResponseEntity _self;
  final $Res Function(GetParkingSuggestionsResponseEntity) _then;

/// Create a copy of GetParkingSuggestionsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? suggestions = null,}) {
  return _then(_self.copyWith(
suggestions: null == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<ParkingSuggestionEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [GetParkingSuggestionsResponseEntity].
extension GetParkingSuggestionsResponseEntityPatterns on GetParkingSuggestionsResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetParkingSuggestionsResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetParkingSuggestionsResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetParkingSuggestionsResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _GetParkingSuggestionsResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetParkingSuggestionsResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GetParkingSuggestionsResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ParkingSuggestionEntity> suggestions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetParkingSuggestionsResponseEntity() when $default != null:
return $default(_that.suggestions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ParkingSuggestionEntity> suggestions)  $default,) {final _that = this;
switch (_that) {
case _GetParkingSuggestionsResponseEntity():
return $default(_that.suggestions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ParkingSuggestionEntity> suggestions)?  $default,) {final _that = this;
switch (_that) {
case _GetParkingSuggestionsResponseEntity() when $default != null:
return $default(_that.suggestions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetParkingSuggestionsResponseEntity implements GetParkingSuggestionsResponseEntity {
  const _GetParkingSuggestionsResponseEntity({required final  List<ParkingSuggestionEntity> suggestions}): _suggestions = suggestions;
  factory _GetParkingSuggestionsResponseEntity.fromJson(Map<String, dynamic> json) => _$GetParkingSuggestionsResponseEntityFromJson(json);

 final  List<ParkingSuggestionEntity> _suggestions;
@override List<ParkingSuggestionEntity> get suggestions {
  if (_suggestions is EqualUnmodifiableListView) return _suggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestions);
}


/// Create a copy of GetParkingSuggestionsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetParkingSuggestionsResponseEntityCopyWith<_GetParkingSuggestionsResponseEntity> get copyWith => __$GetParkingSuggestionsResponseEntityCopyWithImpl<_GetParkingSuggestionsResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetParkingSuggestionsResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetParkingSuggestionsResponseEntity&&const DeepCollectionEquality().equals(other._suggestions, _suggestions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_suggestions));

@override
String toString() {
  return 'GetParkingSuggestionsResponseEntity(suggestions: $suggestions)';
}


}

/// @nodoc
abstract mixin class _$GetParkingSuggestionsResponseEntityCopyWith<$Res> implements $GetParkingSuggestionsResponseEntityCopyWith<$Res> {
  factory _$GetParkingSuggestionsResponseEntityCopyWith(_GetParkingSuggestionsResponseEntity value, $Res Function(_GetParkingSuggestionsResponseEntity) _then) = __$GetParkingSuggestionsResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 List<ParkingSuggestionEntity> suggestions
});




}
/// @nodoc
class __$GetParkingSuggestionsResponseEntityCopyWithImpl<$Res>
    implements _$GetParkingSuggestionsResponseEntityCopyWith<$Res> {
  __$GetParkingSuggestionsResponseEntityCopyWithImpl(this._self, this._then);

  final _GetParkingSuggestionsResponseEntity _self;
  final $Res Function(_GetParkingSuggestionsResponseEntity) _then;

/// Create a copy of GetParkingSuggestionsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? suggestions = null,}) {
  return _then(_GetParkingSuggestionsResponseEntity(
suggestions: null == suggestions ? _self._suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<ParkingSuggestionEntity>,
  ));
}


}


/// @nodoc
mixin _$ParkingSuggestionEntity {

@JsonKey(name: 'id') String get slotId;@JsonKey(name: 'name') String get slotName; double get distanceMeters; int get row; int get col; String get slotType;
/// Create a copy of ParkingSuggestionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParkingSuggestionEntityCopyWith<ParkingSuggestionEntity> get copyWith => _$ParkingSuggestionEntityCopyWithImpl<ParkingSuggestionEntity>(this as ParkingSuggestionEntity, _$identity);

  /// Serializes this ParkingSuggestionEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParkingSuggestionEntity&&(identical(other.slotId, slotId) || other.slotId == slotId)&&(identical(other.slotName, slotName) || other.slotName == slotName)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.row, row) || other.row == row)&&(identical(other.col, col) || other.col == col)&&(identical(other.slotType, slotType) || other.slotType == slotType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slotId,slotName,distanceMeters,row,col,slotType);

@override
String toString() {
  return 'ParkingSuggestionEntity(slotId: $slotId, slotName: $slotName, distanceMeters: $distanceMeters, row: $row, col: $col, slotType: $slotType)';
}


}

/// @nodoc
abstract mixin class $ParkingSuggestionEntityCopyWith<$Res>  {
  factory $ParkingSuggestionEntityCopyWith(ParkingSuggestionEntity value, $Res Function(ParkingSuggestionEntity) _then) = _$ParkingSuggestionEntityCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String slotId,@JsonKey(name: 'name') String slotName, double distanceMeters, int row, int col, String slotType
});




}
/// @nodoc
class _$ParkingSuggestionEntityCopyWithImpl<$Res>
    implements $ParkingSuggestionEntityCopyWith<$Res> {
  _$ParkingSuggestionEntityCopyWithImpl(this._self, this._then);

  final ParkingSuggestionEntity _self;
  final $Res Function(ParkingSuggestionEntity) _then;

/// Create a copy of ParkingSuggestionEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slotId = null,Object? slotName = null,Object? distanceMeters = null,Object? row = null,Object? col = null,Object? slotType = null,}) {
  return _then(_self.copyWith(
slotId: null == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String,slotName: null == slotName ? _self.slotName : slotName // ignore: cast_nullable_to_non_nullable
as String,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,row: null == row ? _self.row : row // ignore: cast_nullable_to_non_nullable
as int,col: null == col ? _self.col : col // ignore: cast_nullable_to_non_nullable
as int,slotType: null == slotType ? _self.slotType : slotType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ParkingSuggestionEntity].
extension ParkingSuggestionEntityPatterns on ParkingSuggestionEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParkingSuggestionEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParkingSuggestionEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParkingSuggestionEntity value)  $default,){
final _that = this;
switch (_that) {
case _ParkingSuggestionEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParkingSuggestionEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ParkingSuggestionEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String slotId, @JsonKey(name: 'name')  String slotName,  double distanceMeters,  int row,  int col,  String slotType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParkingSuggestionEntity() when $default != null:
return $default(_that.slotId,_that.slotName,_that.distanceMeters,_that.row,_that.col,_that.slotType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String slotId, @JsonKey(name: 'name')  String slotName,  double distanceMeters,  int row,  int col,  String slotType)  $default,) {final _that = this;
switch (_that) {
case _ParkingSuggestionEntity():
return $default(_that.slotId,_that.slotName,_that.distanceMeters,_that.row,_that.col,_that.slotType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String slotId, @JsonKey(name: 'name')  String slotName,  double distanceMeters,  int row,  int col,  String slotType)?  $default,) {final _that = this;
switch (_that) {
case _ParkingSuggestionEntity() when $default != null:
return $default(_that.slotId,_that.slotName,_that.distanceMeters,_that.row,_that.col,_that.slotType);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _ParkingSuggestionEntity implements ParkingSuggestionEntity {
  const _ParkingSuggestionEntity({@JsonKey(name: 'id') required this.slotId, @JsonKey(name: 'name') required this.slotName, required this.distanceMeters, required this.row, required this.col, required this.slotType});
  factory _ParkingSuggestionEntity.fromJson(Map<String, dynamic> json) => _$ParkingSuggestionEntityFromJson(json);

@override@JsonKey(name: 'id') final  String slotId;
@override@JsonKey(name: 'name') final  String slotName;
@override final  double distanceMeters;
@override final  int row;
@override final  int col;
@override final  String slotType;

/// Create a copy of ParkingSuggestionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParkingSuggestionEntityCopyWith<_ParkingSuggestionEntity> get copyWith => __$ParkingSuggestionEntityCopyWithImpl<_ParkingSuggestionEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParkingSuggestionEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParkingSuggestionEntity&&(identical(other.slotId, slotId) || other.slotId == slotId)&&(identical(other.slotName, slotName) || other.slotName == slotName)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.row, row) || other.row == row)&&(identical(other.col, col) || other.col == col)&&(identical(other.slotType, slotType) || other.slotType == slotType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slotId,slotName,distanceMeters,row,col,slotType);

@override
String toString() {
  return 'ParkingSuggestionEntity(slotId: $slotId, slotName: $slotName, distanceMeters: $distanceMeters, row: $row, col: $col, slotType: $slotType)';
}


}

/// @nodoc
abstract mixin class _$ParkingSuggestionEntityCopyWith<$Res> implements $ParkingSuggestionEntityCopyWith<$Res> {
  factory _$ParkingSuggestionEntityCopyWith(_ParkingSuggestionEntity value, $Res Function(_ParkingSuggestionEntity) _then) = __$ParkingSuggestionEntityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String slotId,@JsonKey(name: 'name') String slotName, double distanceMeters, int row, int col, String slotType
});




}
/// @nodoc
class __$ParkingSuggestionEntityCopyWithImpl<$Res>
    implements _$ParkingSuggestionEntityCopyWith<$Res> {
  __$ParkingSuggestionEntityCopyWithImpl(this._self, this._then);

  final _ParkingSuggestionEntity _self;
  final $Res Function(_ParkingSuggestionEntity) _then;

/// Create a copy of ParkingSuggestionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slotId = null,Object? slotName = null,Object? distanceMeters = null,Object? row = null,Object? col = null,Object? slotType = null,}) {
  return _then(_ParkingSuggestionEntity(
slotId: null == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String,slotName: null == slotName ? _self.slotName : slotName // ignore: cast_nullable_to_non_nullable
as String,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,row: null == row ? _self.row : row // ignore: cast_nullable_to_non_nullable
as int,col: null == col ? _self.col : col // ignore: cast_nullable_to_non_nullable
as int,slotType: null == slotType ? _self.slotType : slotType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
