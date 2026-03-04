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

 String get id; String get name; bool get isOpen; int get camerasCount; int get totalSlots; double get occupancy; int get revenueToday; String get address;@JsonKey(name: 'entrance_logical_locations') List<List<int>>? get entranceLogicalLocations;@JsonKey(name: 'slot_width_meters') double? get slotWidthMeters;@JsonKey(name: 'slot_length_meters') double? get slotLengthMeters;
/// Create a copy of ParkingLotModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParkingLotModelCopyWith<ParkingLotModel> get copyWith => _$ParkingLotModelCopyWithImpl<ParkingLotModel>(this as ParkingLotModel, _$identity);

  /// Serializes this ParkingLotModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParkingLotModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.camerasCount, camerasCount) || other.camerasCount == camerasCount)&&(identical(other.totalSlots, totalSlots) || other.totalSlots == totalSlots)&&(identical(other.occupancy, occupancy) || other.occupancy == occupancy)&&(identical(other.revenueToday, revenueToday) || other.revenueToday == revenueToday)&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other.entranceLogicalLocations, entranceLogicalLocations)&&(identical(other.slotWidthMeters, slotWidthMeters) || other.slotWidthMeters == slotWidthMeters)&&(identical(other.slotLengthMeters, slotLengthMeters) || other.slotLengthMeters == slotLengthMeters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isOpen,camerasCount,totalSlots,occupancy,revenueToday,address,const DeepCollectionEquality().hash(entranceLogicalLocations),slotWidthMeters,slotLengthMeters);

@override
String toString() {
  return 'ParkingLotModel(id: $id, name: $name, isOpen: $isOpen, camerasCount: $camerasCount, totalSlots: $totalSlots, occupancy: $occupancy, revenueToday: $revenueToday, address: $address, entranceLogicalLocations: $entranceLogicalLocations, slotWidthMeters: $slotWidthMeters, slotLengthMeters: $slotLengthMeters)';
}


}

/// @nodoc
abstract mixin class $ParkingLotModelCopyWith<$Res>  {
  factory $ParkingLotModelCopyWith(ParkingLotModel value, $Res Function(ParkingLotModel) _then) = _$ParkingLotModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, bool isOpen, int camerasCount, int totalSlots, double occupancy, int revenueToday, String address,@JsonKey(name: 'entrance_logical_locations') List<List<int>>? entranceLogicalLocations,@JsonKey(name: 'slot_width_meters') double? slotWidthMeters,@JsonKey(name: 'slot_length_meters') double? slotLengthMeters
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? isOpen = null,Object? camerasCount = null,Object? totalSlots = null,Object? occupancy = null,Object? revenueToday = null,Object? address = null,Object? entranceLogicalLocations = freezed,Object? slotWidthMeters = freezed,Object? slotLengthMeters = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,camerasCount: null == camerasCount ? _self.camerasCount : camerasCount // ignore: cast_nullable_to_non_nullable
as int,totalSlots: null == totalSlots ? _self.totalSlots : totalSlots // ignore: cast_nullable_to_non_nullable
as int,occupancy: null == occupancy ? _self.occupancy : occupancy // ignore: cast_nullable_to_non_nullable
as double,revenueToday: null == revenueToday ? _self.revenueToday : revenueToday // ignore: cast_nullable_to_non_nullable
as int,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,entranceLogicalLocations: freezed == entranceLogicalLocations ? _self.entranceLogicalLocations : entranceLogicalLocations // ignore: cast_nullable_to_non_nullable
as List<List<int>>?,slotWidthMeters: freezed == slotWidthMeters ? _self.slotWidthMeters : slotWidthMeters // ignore: cast_nullable_to_non_nullable
as double?,slotLengthMeters: freezed == slotLengthMeters ? _self.slotLengthMeters : slotLengthMeters // ignore: cast_nullable_to_non_nullable
as double?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  bool isOpen,  int camerasCount,  int totalSlots,  double occupancy,  int revenueToday,  String address, @JsonKey(name: 'entrance_logical_locations')  List<List<int>>? entranceLogicalLocations, @JsonKey(name: 'slot_width_meters')  double? slotWidthMeters, @JsonKey(name: 'slot_length_meters')  double? slotLengthMeters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParkingLotModel() when $default != null:
return $default(_that.id,_that.name,_that.isOpen,_that.camerasCount,_that.totalSlots,_that.occupancy,_that.revenueToday,_that.address,_that.entranceLogicalLocations,_that.slotWidthMeters,_that.slotLengthMeters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  bool isOpen,  int camerasCount,  int totalSlots,  double occupancy,  int revenueToday,  String address, @JsonKey(name: 'entrance_logical_locations')  List<List<int>>? entranceLogicalLocations, @JsonKey(name: 'slot_width_meters')  double? slotWidthMeters, @JsonKey(name: 'slot_length_meters')  double? slotLengthMeters)  $default,) {final _that = this;
switch (_that) {
case _ParkingLotModel():
return $default(_that.id,_that.name,_that.isOpen,_that.camerasCount,_that.totalSlots,_that.occupancy,_that.revenueToday,_that.address,_that.entranceLogicalLocations,_that.slotWidthMeters,_that.slotLengthMeters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  bool isOpen,  int camerasCount,  int totalSlots,  double occupancy,  int revenueToday,  String address, @JsonKey(name: 'entrance_logical_locations')  List<List<int>>? entranceLogicalLocations, @JsonKey(name: 'slot_width_meters')  double? slotWidthMeters, @JsonKey(name: 'slot_length_meters')  double? slotLengthMeters)?  $default,) {final _that = this;
switch (_that) {
case _ParkingLotModel() when $default != null:
return $default(_that.id,_that.name,_that.isOpen,_that.camerasCount,_that.totalSlots,_that.occupancy,_that.revenueToday,_that.address,_that.entranceLogicalLocations,_that.slotWidthMeters,_that.slotLengthMeters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParkingLotModel implements ParkingLotModel {
  const _ParkingLotModel({required this.id, required this.name, required this.isOpen, required this.camerasCount, required this.totalSlots, required this.occupancy, required this.revenueToday, required this.address, @JsonKey(name: 'entrance_logical_locations') final  List<List<int>>? entranceLogicalLocations, @JsonKey(name: 'slot_width_meters') this.slotWidthMeters, @JsonKey(name: 'slot_length_meters') this.slotLengthMeters}): _entranceLogicalLocations = entranceLogicalLocations;
  factory _ParkingLotModel.fromJson(Map<String, dynamic> json) => _$ParkingLotModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  bool isOpen;
@override final  int camerasCount;
@override final  int totalSlots;
@override final  double occupancy;
@override final  int revenueToday;
@override final  String address;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParkingLotModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.camerasCount, camerasCount) || other.camerasCount == camerasCount)&&(identical(other.totalSlots, totalSlots) || other.totalSlots == totalSlots)&&(identical(other.occupancy, occupancy) || other.occupancy == occupancy)&&(identical(other.revenueToday, revenueToday) || other.revenueToday == revenueToday)&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other._entranceLogicalLocations, _entranceLogicalLocations)&&(identical(other.slotWidthMeters, slotWidthMeters) || other.slotWidthMeters == slotWidthMeters)&&(identical(other.slotLengthMeters, slotLengthMeters) || other.slotLengthMeters == slotLengthMeters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isOpen,camerasCount,totalSlots,occupancy,revenueToday,address,const DeepCollectionEquality().hash(_entranceLogicalLocations),slotWidthMeters,slotLengthMeters);

@override
String toString() {
  return 'ParkingLotModel(id: $id, name: $name, isOpen: $isOpen, camerasCount: $camerasCount, totalSlots: $totalSlots, occupancy: $occupancy, revenueToday: $revenueToday, address: $address, entranceLogicalLocations: $entranceLogicalLocations, slotWidthMeters: $slotWidthMeters, slotLengthMeters: $slotLengthMeters)';
}


}

/// @nodoc
abstract mixin class _$ParkingLotModelCopyWith<$Res> implements $ParkingLotModelCopyWith<$Res> {
  factory _$ParkingLotModelCopyWith(_ParkingLotModel value, $Res Function(_ParkingLotModel) _then) = __$ParkingLotModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, bool isOpen, int camerasCount, int totalSlots, double occupancy, int revenueToday, String address,@JsonKey(name: 'entrance_logical_locations') List<List<int>>? entranceLogicalLocations,@JsonKey(name: 'slot_width_meters') double? slotWidthMeters,@JsonKey(name: 'slot_length_meters') double? slotLengthMeters
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? isOpen = null,Object? camerasCount = null,Object? totalSlots = null,Object? occupancy = null,Object? revenueToday = null,Object? address = null,Object? entranceLogicalLocations = freezed,Object? slotWidthMeters = freezed,Object? slotLengthMeters = freezed,}) {
  return _then(_ParkingLotModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,camerasCount: null == camerasCount ? _self.camerasCount : camerasCount // ignore: cast_nullable_to_non_nullable
as int,totalSlots: null == totalSlots ? _self.totalSlots : totalSlots // ignore: cast_nullable_to_non_nullable
as int,occupancy: null == occupancy ? _self.occupancy : occupancy // ignore: cast_nullable_to_non_nullable
as double,revenueToday: null == revenueToday ? _self.revenueToday : revenueToday // ignore: cast_nullable_to_non_nullable
as int,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,entranceLogicalLocations: freezed == entranceLogicalLocations ? _self._entranceLogicalLocations : entranceLogicalLocations // ignore: cast_nullable_to_non_nullable
as List<List<int>>?,slotWidthMeters: freezed == slotWidthMeters ? _self.slotWidthMeters : slotWidthMeters // ignore: cast_nullable_to_non_nullable
as double?,slotLengthMeters: freezed == slotLengthMeters ? _self.slotLengthMeters : slotLengthMeters // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
