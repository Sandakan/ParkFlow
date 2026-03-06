// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parking_slot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ParkingSlotModel {

 String get id; String get name; bool get isOccupied;@JsonKey(name: 'lot_id') String? get lotId;@JsonKey(name: 'slot_type') String? get slotType;@JsonKey(name: 'camera_id') String? get cameraId;@JsonKey(name: 'logical_row') int get logicalRow;@JsonKey(name: 'logical_col') int get logicalCol; List<Point2D>? get coordinates; DateTime? get lastUpdated; double? get rating; int? get ratingCount;
/// Create a copy of ParkingSlotModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParkingSlotModelCopyWith<ParkingSlotModel> get copyWith => _$ParkingSlotModelCopyWithImpl<ParkingSlotModel>(this as ParkingSlotModel, _$identity);

  /// Serializes this ParkingSlotModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParkingSlotModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isOccupied, isOccupied) || other.isOccupied == isOccupied)&&(identical(other.lotId, lotId) || other.lotId == lotId)&&(identical(other.slotType, slotType) || other.slotType == slotType)&&(identical(other.cameraId, cameraId) || other.cameraId == cameraId)&&(identical(other.logicalRow, logicalRow) || other.logicalRow == logicalRow)&&(identical(other.logicalCol, logicalCol) || other.logicalCol == logicalCol)&&const DeepCollectionEquality().equals(other.coordinates, coordinates)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isOccupied,lotId,slotType,cameraId,logicalRow,logicalCol,const DeepCollectionEquality().hash(coordinates),lastUpdated,rating,ratingCount);

@override
String toString() {
  return 'ParkingSlotModel(id: $id, name: $name, isOccupied: $isOccupied, lotId: $lotId, slotType: $slotType, cameraId: $cameraId, logicalRow: $logicalRow, logicalCol: $logicalCol, coordinates: $coordinates, lastUpdated: $lastUpdated, rating: $rating, ratingCount: $ratingCount)';
}


}

/// @nodoc
abstract mixin class $ParkingSlotModelCopyWith<$Res>  {
  factory $ParkingSlotModelCopyWith(ParkingSlotModel value, $Res Function(ParkingSlotModel) _then) = _$ParkingSlotModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, bool isOccupied,@JsonKey(name: 'lot_id') String? lotId,@JsonKey(name: 'slot_type') String? slotType,@JsonKey(name: 'camera_id') String? cameraId,@JsonKey(name: 'logical_row') int logicalRow,@JsonKey(name: 'logical_col') int logicalCol, List<Point2D>? coordinates, DateTime? lastUpdated, double? rating, int? ratingCount
});




}
/// @nodoc
class _$ParkingSlotModelCopyWithImpl<$Res>
    implements $ParkingSlotModelCopyWith<$Res> {
  _$ParkingSlotModelCopyWithImpl(this._self, this._then);

  final ParkingSlotModel _self;
  final $Res Function(ParkingSlotModel) _then;

/// Create a copy of ParkingSlotModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? isOccupied = null,Object? lotId = freezed,Object? slotType = freezed,Object? cameraId = freezed,Object? logicalRow = null,Object? logicalCol = null,Object? coordinates = freezed,Object? lastUpdated = freezed,Object? rating = freezed,Object? ratingCount = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isOccupied: null == isOccupied ? _self.isOccupied : isOccupied // ignore: cast_nullable_to_non_nullable
as bool,lotId: freezed == lotId ? _self.lotId : lotId // ignore: cast_nullable_to_non_nullable
as String?,slotType: freezed == slotType ? _self.slotType : slotType // ignore: cast_nullable_to_non_nullable
as String?,cameraId: freezed == cameraId ? _self.cameraId : cameraId // ignore: cast_nullable_to_non_nullable
as String?,logicalRow: null == logicalRow ? _self.logicalRow : logicalRow // ignore: cast_nullable_to_non_nullable
as int,logicalCol: null == logicalCol ? _self.logicalCol : logicalCol // ignore: cast_nullable_to_non_nullable
as int,coordinates: freezed == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as List<Point2D>?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: freezed == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ParkingSlotModel].
extension ParkingSlotModelPatterns on ParkingSlotModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParkingSlotModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParkingSlotModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParkingSlotModel value)  $default,){
final _that = this;
switch (_that) {
case _ParkingSlotModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParkingSlotModel value)?  $default,){
final _that = this;
switch (_that) {
case _ParkingSlotModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  bool isOccupied, @JsonKey(name: 'lot_id')  String? lotId, @JsonKey(name: 'slot_type')  String? slotType, @JsonKey(name: 'camera_id')  String? cameraId, @JsonKey(name: 'logical_row')  int logicalRow, @JsonKey(name: 'logical_col')  int logicalCol,  List<Point2D>? coordinates,  DateTime? lastUpdated,  double? rating,  int? ratingCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParkingSlotModel() when $default != null:
return $default(_that.id,_that.name,_that.isOccupied,_that.lotId,_that.slotType,_that.cameraId,_that.logicalRow,_that.logicalCol,_that.coordinates,_that.lastUpdated,_that.rating,_that.ratingCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  bool isOccupied, @JsonKey(name: 'lot_id')  String? lotId, @JsonKey(name: 'slot_type')  String? slotType, @JsonKey(name: 'camera_id')  String? cameraId, @JsonKey(name: 'logical_row')  int logicalRow, @JsonKey(name: 'logical_col')  int logicalCol,  List<Point2D>? coordinates,  DateTime? lastUpdated,  double? rating,  int? ratingCount)  $default,) {final _that = this;
switch (_that) {
case _ParkingSlotModel():
return $default(_that.id,_that.name,_that.isOccupied,_that.lotId,_that.slotType,_that.cameraId,_that.logicalRow,_that.logicalCol,_that.coordinates,_that.lastUpdated,_that.rating,_that.ratingCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  bool isOccupied, @JsonKey(name: 'lot_id')  String? lotId, @JsonKey(name: 'slot_type')  String? slotType, @JsonKey(name: 'camera_id')  String? cameraId, @JsonKey(name: 'logical_row')  int logicalRow, @JsonKey(name: 'logical_col')  int logicalCol,  List<Point2D>? coordinates,  DateTime? lastUpdated,  double? rating,  int? ratingCount)?  $default,) {final _that = this;
switch (_that) {
case _ParkingSlotModel() when $default != null:
return $default(_that.id,_that.name,_that.isOccupied,_that.lotId,_that.slotType,_that.cameraId,_that.logicalRow,_that.logicalCol,_that.coordinates,_that.lastUpdated,_that.rating,_that.ratingCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParkingSlotModel implements ParkingSlotModel {
  const _ParkingSlotModel({required this.id, required this.name, required this.isOccupied, @JsonKey(name: 'lot_id') this.lotId, @JsonKey(name: 'slot_type') this.slotType, @JsonKey(name: 'camera_id') this.cameraId, @JsonKey(name: 'logical_row') this.logicalRow = 0, @JsonKey(name: 'logical_col') this.logicalCol = 0, final  List<Point2D>? coordinates, this.lastUpdated, this.rating, this.ratingCount}): _coordinates = coordinates;
  factory _ParkingSlotModel.fromJson(Map<String, dynamic> json) => _$ParkingSlotModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  bool isOccupied;
@override@JsonKey(name: 'lot_id') final  String? lotId;
@override@JsonKey(name: 'slot_type') final  String? slotType;
@override@JsonKey(name: 'camera_id') final  String? cameraId;
@override@JsonKey(name: 'logical_row') final  int logicalRow;
@override@JsonKey(name: 'logical_col') final  int logicalCol;
 final  List<Point2D>? _coordinates;
@override List<Point2D>? get coordinates {
  final value = _coordinates;
  if (value == null) return null;
  if (_coordinates is EqualUnmodifiableListView) return _coordinates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  DateTime? lastUpdated;
@override final  double? rating;
@override final  int? ratingCount;

/// Create a copy of ParkingSlotModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParkingSlotModelCopyWith<_ParkingSlotModel> get copyWith => __$ParkingSlotModelCopyWithImpl<_ParkingSlotModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParkingSlotModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParkingSlotModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isOccupied, isOccupied) || other.isOccupied == isOccupied)&&(identical(other.lotId, lotId) || other.lotId == lotId)&&(identical(other.slotType, slotType) || other.slotType == slotType)&&(identical(other.cameraId, cameraId) || other.cameraId == cameraId)&&(identical(other.logicalRow, logicalRow) || other.logicalRow == logicalRow)&&(identical(other.logicalCol, logicalCol) || other.logicalCol == logicalCol)&&const DeepCollectionEquality().equals(other._coordinates, _coordinates)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isOccupied,lotId,slotType,cameraId,logicalRow,logicalCol,const DeepCollectionEquality().hash(_coordinates),lastUpdated,rating,ratingCount);

@override
String toString() {
  return 'ParkingSlotModel(id: $id, name: $name, isOccupied: $isOccupied, lotId: $lotId, slotType: $slotType, cameraId: $cameraId, logicalRow: $logicalRow, logicalCol: $logicalCol, coordinates: $coordinates, lastUpdated: $lastUpdated, rating: $rating, ratingCount: $ratingCount)';
}


}

/// @nodoc
abstract mixin class _$ParkingSlotModelCopyWith<$Res> implements $ParkingSlotModelCopyWith<$Res> {
  factory _$ParkingSlotModelCopyWith(_ParkingSlotModel value, $Res Function(_ParkingSlotModel) _then) = __$ParkingSlotModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, bool isOccupied,@JsonKey(name: 'lot_id') String? lotId,@JsonKey(name: 'slot_type') String? slotType,@JsonKey(name: 'camera_id') String? cameraId,@JsonKey(name: 'logical_row') int logicalRow,@JsonKey(name: 'logical_col') int logicalCol, List<Point2D>? coordinates, DateTime? lastUpdated, double? rating, int? ratingCount
});




}
/// @nodoc
class __$ParkingSlotModelCopyWithImpl<$Res>
    implements _$ParkingSlotModelCopyWith<$Res> {
  __$ParkingSlotModelCopyWithImpl(this._self, this._then);

  final _ParkingSlotModel _self;
  final $Res Function(_ParkingSlotModel) _then;

/// Create a copy of ParkingSlotModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? isOccupied = null,Object? lotId = freezed,Object? slotType = freezed,Object? cameraId = freezed,Object? logicalRow = null,Object? logicalCol = null,Object? coordinates = freezed,Object? lastUpdated = freezed,Object? rating = freezed,Object? ratingCount = freezed,}) {
  return _then(_ParkingSlotModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isOccupied: null == isOccupied ? _self.isOccupied : isOccupied // ignore: cast_nullable_to_non_nullable
as bool,lotId: freezed == lotId ? _self.lotId : lotId // ignore: cast_nullable_to_non_nullable
as String?,slotType: freezed == slotType ? _self.slotType : slotType // ignore: cast_nullable_to_non_nullable
as String?,cameraId: freezed == cameraId ? _self.cameraId : cameraId // ignore: cast_nullable_to_non_nullable
as String?,logicalRow: null == logicalRow ? _self.logicalRow : logicalRow // ignore: cast_nullable_to_non_nullable
as int,logicalCol: null == logicalCol ? _self.logicalCol : logicalCol // ignore: cast_nullable_to_non_nullable
as int,coordinates: freezed == coordinates ? _self._coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as List<Point2D>?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: freezed == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
