// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_parking_slot_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateParkingSlotRequest {

 String get lotId; String get cameraId; String get slotNumber; String get slotType; List<Point2D> get coordinates;
/// Create a copy of CreateParkingSlotRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateParkingSlotRequestCopyWith<CreateParkingSlotRequest> get copyWith => _$CreateParkingSlotRequestCopyWithImpl<CreateParkingSlotRequest>(this as CreateParkingSlotRequest, _$identity);

  /// Serializes this CreateParkingSlotRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateParkingSlotRequest&&(identical(other.lotId, lotId) || other.lotId == lotId)&&(identical(other.cameraId, cameraId) || other.cameraId == cameraId)&&(identical(other.slotNumber, slotNumber) || other.slotNumber == slotNumber)&&(identical(other.slotType, slotType) || other.slotType == slotType)&&const DeepCollectionEquality().equals(other.coordinates, coordinates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lotId,cameraId,slotNumber,slotType,const DeepCollectionEquality().hash(coordinates));

@override
String toString() {
  return 'CreateParkingSlotRequest(lotId: $lotId, cameraId: $cameraId, slotNumber: $slotNumber, slotType: $slotType, coordinates: $coordinates)';
}


}

/// @nodoc
abstract mixin class $CreateParkingSlotRequestCopyWith<$Res>  {
  factory $CreateParkingSlotRequestCopyWith(CreateParkingSlotRequest value, $Res Function(CreateParkingSlotRequest) _then) = _$CreateParkingSlotRequestCopyWithImpl;
@useResult
$Res call({
 String lotId, String cameraId, String slotNumber, String slotType, List<Point2D> coordinates
});




}
/// @nodoc
class _$CreateParkingSlotRequestCopyWithImpl<$Res>
    implements $CreateParkingSlotRequestCopyWith<$Res> {
  _$CreateParkingSlotRequestCopyWithImpl(this._self, this._then);

  final CreateParkingSlotRequest _self;
  final $Res Function(CreateParkingSlotRequest) _then;

/// Create a copy of CreateParkingSlotRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lotId = null,Object? cameraId = null,Object? slotNumber = null,Object? slotType = null,Object? coordinates = null,}) {
  return _then(_self.copyWith(
lotId: null == lotId ? _self.lotId : lotId // ignore: cast_nullable_to_non_nullable
as String,cameraId: null == cameraId ? _self.cameraId : cameraId // ignore: cast_nullable_to_non_nullable
as String,slotNumber: null == slotNumber ? _self.slotNumber : slotNumber // ignore: cast_nullable_to_non_nullable
as String,slotType: null == slotType ? _self.slotType : slotType // ignore: cast_nullable_to_non_nullable
as String,coordinates: null == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as List<Point2D>,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateParkingSlotRequest].
extension CreateParkingSlotRequestPatterns on CreateParkingSlotRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateParkingSlotRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateParkingSlotRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateParkingSlotRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateParkingSlotRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateParkingSlotRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateParkingSlotRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String lotId,  String cameraId,  String slotNumber,  String slotType,  List<Point2D> coordinates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateParkingSlotRequest() when $default != null:
return $default(_that.lotId,_that.cameraId,_that.slotNumber,_that.slotType,_that.coordinates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String lotId,  String cameraId,  String slotNumber,  String slotType,  List<Point2D> coordinates)  $default,) {final _that = this;
switch (_that) {
case _CreateParkingSlotRequest():
return $default(_that.lotId,_that.cameraId,_that.slotNumber,_that.slotType,_that.coordinates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String lotId,  String cameraId,  String slotNumber,  String slotType,  List<Point2D> coordinates)?  $default,) {final _that = this;
switch (_that) {
case _CreateParkingSlotRequest() when $default != null:
return $default(_that.lotId,_that.cameraId,_that.slotNumber,_that.slotType,_that.coordinates);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _CreateParkingSlotRequest implements CreateParkingSlotRequest {
  const _CreateParkingSlotRequest({required this.lotId, required this.cameraId, required this.slotNumber, this.slotType = 'general', required final  List<Point2D> coordinates}): _coordinates = coordinates;
  factory _CreateParkingSlotRequest.fromJson(Map<String, dynamic> json) => _$CreateParkingSlotRequestFromJson(json);

@override final  String lotId;
@override final  String cameraId;
@override final  String slotNumber;
@override@JsonKey() final  String slotType;
 final  List<Point2D> _coordinates;
@override List<Point2D> get coordinates {
  if (_coordinates is EqualUnmodifiableListView) return _coordinates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_coordinates);
}


/// Create a copy of CreateParkingSlotRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateParkingSlotRequestCopyWith<_CreateParkingSlotRequest> get copyWith => __$CreateParkingSlotRequestCopyWithImpl<_CreateParkingSlotRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateParkingSlotRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateParkingSlotRequest&&(identical(other.lotId, lotId) || other.lotId == lotId)&&(identical(other.cameraId, cameraId) || other.cameraId == cameraId)&&(identical(other.slotNumber, slotNumber) || other.slotNumber == slotNumber)&&(identical(other.slotType, slotType) || other.slotType == slotType)&&const DeepCollectionEquality().equals(other._coordinates, _coordinates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lotId,cameraId,slotNumber,slotType,const DeepCollectionEquality().hash(_coordinates));

@override
String toString() {
  return 'CreateParkingSlotRequest(lotId: $lotId, cameraId: $cameraId, slotNumber: $slotNumber, slotType: $slotType, coordinates: $coordinates)';
}


}

/// @nodoc
abstract mixin class _$CreateParkingSlotRequestCopyWith<$Res> implements $CreateParkingSlotRequestCopyWith<$Res> {
  factory _$CreateParkingSlotRequestCopyWith(_CreateParkingSlotRequest value, $Res Function(_CreateParkingSlotRequest) _then) = __$CreateParkingSlotRequestCopyWithImpl;
@override @useResult
$Res call({
 String lotId, String cameraId, String slotNumber, String slotType, List<Point2D> coordinates
});




}
/// @nodoc
class __$CreateParkingSlotRequestCopyWithImpl<$Res>
    implements _$CreateParkingSlotRequestCopyWith<$Res> {
  __$CreateParkingSlotRequestCopyWithImpl(this._self, this._then);

  final _CreateParkingSlotRequest _self;
  final $Res Function(_CreateParkingSlotRequest) _then;

/// Create a copy of CreateParkingSlotRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lotId = null,Object? cameraId = null,Object? slotNumber = null,Object? slotType = null,Object? coordinates = null,}) {
  return _then(_CreateParkingSlotRequest(
lotId: null == lotId ? _self.lotId : lotId // ignore: cast_nullable_to_non_nullable
as String,cameraId: null == cameraId ? _self.cameraId : cameraId // ignore: cast_nullable_to_non_nullable
as String,slotNumber: null == slotNumber ? _self.slotNumber : slotNumber // ignore: cast_nullable_to_non_nullable
as String,slotType: null == slotType ? _self.slotType : slotType // ignore: cast_nullable_to_non_nullable
as String,coordinates: null == coordinates ? _self._coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as List<Point2D>,
  ));
}


}

// dart format on
