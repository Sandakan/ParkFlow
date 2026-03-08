// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parking_lot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ParkingLotModel {

 String get id; String get name; bool get isOpen; int get camerasCount; int get totalSlots; double get occupancy; int get revenueToday; double get baseRate; String get address; double get latitude; double get longitude;@JsonKey(name: 'entrance_logical_locations') List<List<int>>? get entranceLogicalLocations;@JsonKey(name: 'slot_width_meters') double? get slotWidthMeters;@JsonKey(name: 'slot_length_meters') double? get slotLengthMeters; double? get distanceMeters; double? get rating; int? get ratingCount;
/// Create a copy of ParkingLotModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParkingLotModelCopyWith<ParkingLotModel> get copyWith => _$ParkingLotModelCopyWithImpl<ParkingLotModel>(this as ParkingLotModel, _$identity);

  /// Serializes this ParkingLotModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParkingLotModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.camerasCount, camerasCount) || other.camerasCount == camerasCount)&&(identical(other.totalSlots, totalSlots) || other.totalSlots == totalSlots)&&(identical(other.occupancy, occupancy) || other.occupancy == occupancy)&&(identical(other.revenueToday, revenueToday) || other.revenueToday == revenueToday)&&(identical(other.baseRate, baseRate) || other.baseRate == baseRate)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&const DeepCollectionEquality().equals(other.entranceLogicalLocations, entranceLogicalLocations)&&(identical(other.slotWidthMeters, slotWidthMeters) || other.slotWidthMeters == slotWidthMeters)&&(identical(other.slotLengthMeters, slotLengthMeters) || other.slotLengthMeters == slotLengthMeters)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isOpen,camerasCount,totalSlots,occupancy,revenueToday,baseRate,address,latitude,longitude,const DeepCollectionEquality().hash(entranceLogicalLocations),slotWidthMeters,slotLengthMeters,distanceMeters,rating,ratingCount);

@override
String toString() {
  return 'ParkingLotModel(id: $id, name: $name, isOpen: $isOpen, camerasCount: $camerasCount, totalSlots: $totalSlots, occupancy: $occupancy, revenueToday: $revenueToday, baseRate: $baseRate, address: $address, latitude: $latitude, longitude: $longitude, entranceLogicalLocations: $entranceLogicalLocations, slotWidthMeters: $slotWidthMeters, slotLengthMeters: $slotLengthMeters, distanceMeters: $distanceMeters, rating: $rating, ratingCount: $ratingCount)';
}


}

/// @nodoc
abstract mixin class $ParkingLotModelCopyWith<$Res>  {
  factory $ParkingLotModelCopyWith(ParkingLotModel value, $Res Function(ParkingLotModel) _then) = _$ParkingLotModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, bool isOpen, int camerasCount, int totalSlots, double occupancy, int revenueToday, double baseRate, String address, double latitude, double longitude,@JsonKey(name: 'entrance_logical_locations') List<List<int>>? entranceLogicalLocations,@JsonKey(name: 'slot_width_meters') double? slotWidthMeters,@JsonKey(name: 'slot_length_meters') double? slotLengthMeters, double? distanceMeters, double? rating, int? ratingCount
});




}
/// @nodoc
class _$ParkingLotModelCopyWithImpl<$Res>
    implements $ParkingLotModelCopyWith<$Res> {
  _$ParkingLotModelCopyWithImpl(this._self, this._then);

  final ParkingLotModel _self;
  final $Res Function(ParkingLotModel) _then;

/// Create a copy of ParkingLotModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? isOpen = null,Object? camerasCount = null,Object? totalSlots = null,Object? occupancy = null,Object? revenueToday = null,Object? baseRate = null,Object? address = null,Object? latitude = null,Object? longitude = null,Object? entranceLogicalLocations = freezed,Object? slotWidthMeters = freezed,Object? slotLengthMeters = freezed,Object? distanceMeters = freezed,Object? rating = freezed,Object? ratingCount = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,camerasCount: null == camerasCount ? _self.camerasCount : camerasCount // ignore: cast_nullable_to_non_nullable
as int,totalSlots: null == totalSlots ? _self.totalSlots : totalSlots // ignore: cast_nullable_to_non_nullable
as int,occupancy: null == occupancy ? _self.occupancy : occupancy // ignore: cast_nullable_to_non_nullable
as double,revenueToday: null == revenueToday ? _self.revenueToday : revenueToday // ignore: cast_nullable_to_non_nullable
as int,baseRate: null == baseRate ? _self.baseRate : baseRate // ignore: cast_nullable_to_non_nullable
as double,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,entranceLogicalLocations: freezed == entranceLogicalLocations ? _self.entranceLogicalLocations : entranceLogicalLocations // ignore: cast_nullable_to_non_nullable
as List<List<int>>?,slotWidthMeters: freezed == slotWidthMeters ? _self.slotWidthMeters : slotWidthMeters // ignore: cast_nullable_to_non_nullable
as double?,slotLengthMeters: freezed == slotLengthMeters ? _self.slotLengthMeters : slotLengthMeters // ignore: cast_nullable_to_non_nullable
as double?,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: freezed == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ParkingLotModel].
extension ParkingLotModelPatterns on ParkingLotModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParkingLotModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParkingLotModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParkingLotModel value)  $default,){
final _that = this;
switch (_that) {
case _ParkingLotModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParkingLotModel value)?  $default,){
final _that = this;
switch (_that) {
case _ParkingLotModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  bool isOpen,  int camerasCount,  int totalSlots,  double occupancy,  int revenueToday,  double baseRate,  String address,  double latitude,  double longitude, @JsonKey(name: 'entrance_logical_locations')  List<List<int>>? entranceLogicalLocations, @JsonKey(name: 'slot_width_meters')  double? slotWidthMeters, @JsonKey(name: 'slot_length_meters')  double? slotLengthMeters,  double? distanceMeters,  double? rating,  int? ratingCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParkingLotModel() when $default != null:
return $default(_that.id,_that.name,_that.isOpen,_that.camerasCount,_that.totalSlots,_that.occupancy,_that.revenueToday,_that.baseRate,_that.address,_that.latitude,_that.longitude,_that.entranceLogicalLocations,_that.slotWidthMeters,_that.slotLengthMeters,_that.distanceMeters,_that.rating,_that.ratingCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  bool isOpen,  int camerasCount,  int totalSlots,  double occupancy,  int revenueToday,  double baseRate,  String address,  double latitude,  double longitude, @JsonKey(name: 'entrance_logical_locations')  List<List<int>>? entranceLogicalLocations, @JsonKey(name: 'slot_width_meters')  double? slotWidthMeters, @JsonKey(name: 'slot_length_meters')  double? slotLengthMeters,  double? distanceMeters,  double? rating,  int? ratingCount)  $default,) {final _that = this;
switch (_that) {
case _ParkingLotModel():
return $default(_that.id,_that.name,_that.isOpen,_that.camerasCount,_that.totalSlots,_that.occupancy,_that.revenueToday,_that.baseRate,_that.address,_that.latitude,_that.longitude,_that.entranceLogicalLocations,_that.slotWidthMeters,_that.slotLengthMeters,_that.distanceMeters,_that.rating,_that.ratingCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  bool isOpen,  int camerasCount,  int totalSlots,  double occupancy,  int revenueToday,  double baseRate,  String address,  double latitude,  double longitude, @JsonKey(name: 'entrance_logical_locations')  List<List<int>>? entranceLogicalLocations, @JsonKey(name: 'slot_width_meters')  double? slotWidthMeters, @JsonKey(name: 'slot_length_meters')  double? slotLengthMeters,  double? distanceMeters,  double? rating,  int? ratingCount)?  $default,) {final _that = this;
switch (_that) {
case _ParkingLotModel() when $default != null:
return $default(_that.id,_that.name,_that.isOpen,_that.camerasCount,_that.totalSlots,_that.occupancy,_that.revenueToday,_that.baseRate,_that.address,_that.latitude,_that.longitude,_that.entranceLogicalLocations,_that.slotWidthMeters,_that.slotLengthMeters,_that.distanceMeters,_that.rating,_that.ratingCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParkingLotModel implements ParkingLotModel {
  const _ParkingLotModel({required this.id, required this.name, required this.isOpen, required this.camerasCount, required this.totalSlots, required this.occupancy, required this.revenueToday, this.baseRate = 100.0, required this.address, required this.latitude, required this.longitude, @JsonKey(name: 'entrance_logical_locations') final  List<List<int>>? entranceLogicalLocations, @JsonKey(name: 'slot_width_meters') this.slotWidthMeters, @JsonKey(name: 'slot_length_meters') this.slotLengthMeters, this.distanceMeters, this.rating, this.ratingCount}): _entranceLogicalLocations = entranceLogicalLocations;
  factory _ParkingLotModel.fromJson(Map<String, dynamic> json) => _$ParkingLotModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  bool isOpen;
@override final  int camerasCount;
@override final  int totalSlots;
@override final  double occupancy;
@override final  int revenueToday;
@override@JsonKey() final  double baseRate;
@override final  String address;
@override final  double latitude;
@override final  double longitude;
 final  List<List<int>>? _entranceLogicalLocations;
@override@JsonKey(name: 'entrance_logical_locations') List<List<int>>? get entranceLogicalLocations {
  final value = _entranceLogicalLocations;
  if (value == null) return null;
  if (_entranceLogicalLocations is EqualUnmodifiableListView) return _entranceLogicalLocations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'slot_width_meters') final  double? slotWidthMeters;
@override@JsonKey(name: 'slot_length_meters') final  double? slotLengthMeters;
@override final  double? distanceMeters;
@override final  double? rating;
@override final  int? ratingCount;

/// Create a copy of ParkingLotModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParkingLotModelCopyWith<_ParkingLotModel> get copyWith => __$ParkingLotModelCopyWithImpl<_ParkingLotModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParkingLotModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParkingLotModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.camerasCount, camerasCount) || other.camerasCount == camerasCount)&&(identical(other.totalSlots, totalSlots) || other.totalSlots == totalSlots)&&(identical(other.occupancy, occupancy) || other.occupancy == occupancy)&&(identical(other.revenueToday, revenueToday) || other.revenueToday == revenueToday)&&(identical(other.baseRate, baseRate) || other.baseRate == baseRate)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&const DeepCollectionEquality().equals(other._entranceLogicalLocations, _entranceLogicalLocations)&&(identical(other.slotWidthMeters, slotWidthMeters) || other.slotWidthMeters == slotWidthMeters)&&(identical(other.slotLengthMeters, slotLengthMeters) || other.slotLengthMeters == slotLengthMeters)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isOpen,camerasCount,totalSlots,occupancy,revenueToday,baseRate,address,latitude,longitude,const DeepCollectionEquality().hash(_entranceLogicalLocations),slotWidthMeters,slotLengthMeters,distanceMeters,rating,ratingCount);

@override
String toString() {
  return 'ParkingLotModel(id: $id, name: $name, isOpen: $isOpen, camerasCount: $camerasCount, totalSlots: $totalSlots, occupancy: $occupancy, revenueToday: $revenueToday, baseRate: $baseRate, address: $address, latitude: $latitude, longitude: $longitude, entranceLogicalLocations: $entranceLogicalLocations, slotWidthMeters: $slotWidthMeters, slotLengthMeters: $slotLengthMeters, distanceMeters: $distanceMeters, rating: $rating, ratingCount: $ratingCount)';
}


}

/// @nodoc
abstract mixin class _$ParkingLotModelCopyWith<$Res> implements $ParkingLotModelCopyWith<$Res> {
  factory _$ParkingLotModelCopyWith(_ParkingLotModel value, $Res Function(_ParkingLotModel) _then) = __$ParkingLotModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, bool isOpen, int camerasCount, int totalSlots, double occupancy, int revenueToday, double baseRate, String address, double latitude, double longitude,@JsonKey(name: 'entrance_logical_locations') List<List<int>>? entranceLogicalLocations,@JsonKey(name: 'slot_width_meters') double? slotWidthMeters,@JsonKey(name: 'slot_length_meters') double? slotLengthMeters, double? distanceMeters, double? rating, int? ratingCount
});




}
/// @nodoc
class __$ParkingLotModelCopyWithImpl<$Res>
    implements _$ParkingLotModelCopyWith<$Res> {
  __$ParkingLotModelCopyWithImpl(this._self, this._then);

  final _ParkingLotModel _self;
  final $Res Function(_ParkingLotModel) _then;

/// Create a copy of ParkingLotModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? isOpen = null,Object? camerasCount = null,Object? totalSlots = null,Object? occupancy = null,Object? revenueToday = null,Object? baseRate = null,Object? address = null,Object? latitude = null,Object? longitude = null,Object? entranceLogicalLocations = freezed,Object? slotWidthMeters = freezed,Object? slotLengthMeters = freezed,Object? distanceMeters = freezed,Object? rating = freezed,Object? ratingCount = freezed,}) {
  return _then(_ParkingLotModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,camerasCount: null == camerasCount ? _self.camerasCount : camerasCount // ignore: cast_nullable_to_non_nullable
as int,totalSlots: null == totalSlots ? _self.totalSlots : totalSlots // ignore: cast_nullable_to_non_nullable
as int,occupancy: null == occupancy ? _self.occupancy : occupancy // ignore: cast_nullable_to_non_nullable
as double,revenueToday: null == revenueToday ? _self.revenueToday : revenueToday // ignore: cast_nullable_to_non_nullable
as int,baseRate: null == baseRate ? _self.baseRate : baseRate // ignore: cast_nullable_to_non_nullable
as double,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,entranceLogicalLocations: freezed == entranceLogicalLocations ? _self._entranceLogicalLocations : entranceLogicalLocations // ignore: cast_nullable_to_non_nullable
as List<List<int>>?,slotWidthMeters: freezed == slotWidthMeters ? _self.slotWidthMeters : slotWidthMeters // ignore: cast_nullable_to_non_nullable
as double?,slotLengthMeters: freezed == slotLengthMeters ? _self.slotLengthMeters : slotLengthMeters // ignore: cast_nullable_to_non_nullable
as double?,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: freezed == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
