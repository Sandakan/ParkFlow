// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_parking_lot_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetParkingLotResponseEntity {

 String get id; String get name; String get address; double get latitude; double get longitude; int get totalSlots;@JsonKey(name: 'entrance_logical_locations') List<List<int>>? get entranceLogicalLocations;@JsonKey(name: 'slot_width_meters') double? get slotWidthMeters;@JsonKey(name: 'slot_length_meters') double? get slotLengthMeters;@JsonKey(name: 'base_rate') double? get baseRate;
/// Create a copy of GetParkingLotResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetParkingLotResponseEntityCopyWith<GetParkingLotResponseEntity> get copyWith => _$GetParkingLotResponseEntityCopyWithImpl<GetParkingLotResponseEntity>(this as GetParkingLotResponseEntity, _$identity);

  /// Serializes this GetParkingLotResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetParkingLotResponseEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.totalSlots, totalSlots) || other.totalSlots == totalSlots)&&const DeepCollectionEquality().equals(other.entranceLogicalLocations, entranceLogicalLocations)&&(identical(other.slotWidthMeters, slotWidthMeters) || other.slotWidthMeters == slotWidthMeters)&&(identical(other.slotLengthMeters, slotLengthMeters) || other.slotLengthMeters == slotLengthMeters)&&(identical(other.baseRate, baseRate) || other.baseRate == baseRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,address,latitude,longitude,totalSlots,const DeepCollectionEquality().hash(entranceLogicalLocations),slotWidthMeters,slotLengthMeters,baseRate);

@override
String toString() {
  return 'GetParkingLotResponseEntity(id: $id, name: $name, address: $address, latitude: $latitude, longitude: $longitude, totalSlots: $totalSlots, entranceLogicalLocations: $entranceLogicalLocations, slotWidthMeters: $slotWidthMeters, slotLengthMeters: $slotLengthMeters, baseRate: $baseRate)';
}


}

/// @nodoc
abstract mixin class $GetParkingLotResponseEntityCopyWith<$Res>  {
  factory $GetParkingLotResponseEntityCopyWith(GetParkingLotResponseEntity value, $Res Function(GetParkingLotResponseEntity) _then) = _$GetParkingLotResponseEntityCopyWithImpl;
@useResult
$Res call({
 String id, String name, String address, double latitude, double longitude, int totalSlots,@JsonKey(name: 'entrance_logical_locations') List<List<int>>? entranceLogicalLocations,@JsonKey(name: 'slot_width_meters') double? slotWidthMeters,@JsonKey(name: 'slot_length_meters') double? slotLengthMeters,@JsonKey(name: 'base_rate') double? baseRate
});




}
/// @nodoc
class _$GetParkingLotResponseEntityCopyWithImpl<$Res>
    implements $GetParkingLotResponseEntityCopyWith<$Res> {
  _$GetParkingLotResponseEntityCopyWithImpl(this._self, this._then);

  final GetParkingLotResponseEntity _self;
  final $Res Function(GetParkingLotResponseEntity) _then;

/// Create a copy of GetParkingLotResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? address = null,Object? latitude = null,Object? longitude = null,Object? totalSlots = null,Object? entranceLogicalLocations = freezed,Object? slotWidthMeters = freezed,Object? slotLengthMeters = freezed,Object? baseRate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,totalSlots: null == totalSlots ? _self.totalSlots : totalSlots // ignore: cast_nullable_to_non_nullable
as int,entranceLogicalLocations: freezed == entranceLogicalLocations ? _self.entranceLogicalLocations : entranceLogicalLocations // ignore: cast_nullable_to_non_nullable
as List<List<int>>?,slotWidthMeters: freezed == slotWidthMeters ? _self.slotWidthMeters : slotWidthMeters // ignore: cast_nullable_to_non_nullable
as double?,slotLengthMeters: freezed == slotLengthMeters ? _self.slotLengthMeters : slotLengthMeters // ignore: cast_nullable_to_non_nullable
as double?,baseRate: freezed == baseRate ? _self.baseRate : baseRate // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [GetParkingLotResponseEntity].
extension GetParkingLotResponseEntityPatterns on GetParkingLotResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetParkingLotResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetParkingLotResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetParkingLotResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _GetParkingLotResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetParkingLotResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GetParkingLotResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String address,  double latitude,  double longitude,  int totalSlots, @JsonKey(name: 'entrance_logical_locations')  List<List<int>>? entranceLogicalLocations, @JsonKey(name: 'slot_width_meters')  double? slotWidthMeters, @JsonKey(name: 'slot_length_meters')  double? slotLengthMeters, @JsonKey(name: 'base_rate')  double? baseRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetParkingLotResponseEntity() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.latitude,_that.longitude,_that.totalSlots,_that.entranceLogicalLocations,_that.slotWidthMeters,_that.slotLengthMeters,_that.baseRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String address,  double latitude,  double longitude,  int totalSlots, @JsonKey(name: 'entrance_logical_locations')  List<List<int>>? entranceLogicalLocations, @JsonKey(name: 'slot_width_meters')  double? slotWidthMeters, @JsonKey(name: 'slot_length_meters')  double? slotLengthMeters, @JsonKey(name: 'base_rate')  double? baseRate)  $default,) {final _that = this;
switch (_that) {
case _GetParkingLotResponseEntity():
return $default(_that.id,_that.name,_that.address,_that.latitude,_that.longitude,_that.totalSlots,_that.entranceLogicalLocations,_that.slotWidthMeters,_that.slotLengthMeters,_that.baseRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String address,  double latitude,  double longitude,  int totalSlots, @JsonKey(name: 'entrance_logical_locations')  List<List<int>>? entranceLogicalLocations, @JsonKey(name: 'slot_width_meters')  double? slotWidthMeters, @JsonKey(name: 'slot_length_meters')  double? slotLengthMeters, @JsonKey(name: 'base_rate')  double? baseRate)?  $default,) {final _that = this;
switch (_that) {
case _GetParkingLotResponseEntity() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.latitude,_that.longitude,_that.totalSlots,_that.entranceLogicalLocations,_that.slotWidthMeters,_that.slotLengthMeters,_that.baseRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetParkingLotResponseEntity extends GetParkingLotResponseEntity {
  const _GetParkingLotResponseEntity({required this.id, required this.name, required this.address, required this.latitude, required this.longitude, required this.totalSlots, @JsonKey(name: 'entrance_logical_locations') final  List<List<int>>? entranceLogicalLocations, @JsonKey(name: 'slot_width_meters') this.slotWidthMeters, @JsonKey(name: 'slot_length_meters') this.slotLengthMeters, @JsonKey(name: 'base_rate') this.baseRate}): _entranceLogicalLocations = entranceLogicalLocations,super._();
  factory _GetParkingLotResponseEntity.fromJson(Map<String, dynamic> json) => _$GetParkingLotResponseEntityFromJson(json);

@override final  String id;
@override final  String name;
@override final  String address;
@override final  double latitude;
@override final  double longitude;
@override final  int totalSlots;
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
@override@JsonKey(name: 'base_rate') final  double? baseRate;

/// Create a copy of GetParkingLotResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetParkingLotResponseEntityCopyWith<_GetParkingLotResponseEntity> get copyWith => __$GetParkingLotResponseEntityCopyWithImpl<_GetParkingLotResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetParkingLotResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetParkingLotResponseEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.totalSlots, totalSlots) || other.totalSlots == totalSlots)&&const DeepCollectionEquality().equals(other._entranceLogicalLocations, _entranceLogicalLocations)&&(identical(other.slotWidthMeters, slotWidthMeters) || other.slotWidthMeters == slotWidthMeters)&&(identical(other.slotLengthMeters, slotLengthMeters) || other.slotLengthMeters == slotLengthMeters)&&(identical(other.baseRate, baseRate) || other.baseRate == baseRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,address,latitude,longitude,totalSlots,const DeepCollectionEquality().hash(_entranceLogicalLocations),slotWidthMeters,slotLengthMeters,baseRate);

@override
String toString() {
  return 'GetParkingLotResponseEntity(id: $id, name: $name, address: $address, latitude: $latitude, longitude: $longitude, totalSlots: $totalSlots, entranceLogicalLocations: $entranceLogicalLocations, slotWidthMeters: $slotWidthMeters, slotLengthMeters: $slotLengthMeters, baseRate: $baseRate)';
}


}

/// @nodoc
abstract mixin class _$GetParkingLotResponseEntityCopyWith<$Res> implements $GetParkingLotResponseEntityCopyWith<$Res> {
  factory _$GetParkingLotResponseEntityCopyWith(_GetParkingLotResponseEntity value, $Res Function(_GetParkingLotResponseEntity) _then) = __$GetParkingLotResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String address, double latitude, double longitude, int totalSlots,@JsonKey(name: 'entrance_logical_locations') List<List<int>>? entranceLogicalLocations,@JsonKey(name: 'slot_width_meters') double? slotWidthMeters,@JsonKey(name: 'slot_length_meters') double? slotLengthMeters,@JsonKey(name: 'base_rate') double? baseRate
});




}
/// @nodoc
class __$GetParkingLotResponseEntityCopyWithImpl<$Res>
    implements _$GetParkingLotResponseEntityCopyWith<$Res> {
  __$GetParkingLotResponseEntityCopyWithImpl(this._self, this._then);

  final _GetParkingLotResponseEntity _self;
  final $Res Function(_GetParkingLotResponseEntity) _then;

/// Create a copy of GetParkingLotResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? address = null,Object? latitude = null,Object? longitude = null,Object? totalSlots = null,Object? entranceLogicalLocations = freezed,Object? slotWidthMeters = freezed,Object? slotLengthMeters = freezed,Object? baseRate = freezed,}) {
  return _then(_GetParkingLotResponseEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,totalSlots: null == totalSlots ? _self.totalSlots : totalSlots // ignore: cast_nullable_to_non_nullable
as int,entranceLogicalLocations: freezed == entranceLogicalLocations ? _self._entranceLogicalLocations : entranceLogicalLocations // ignore: cast_nullable_to_non_nullable
as List<List<int>>?,slotWidthMeters: freezed == slotWidthMeters ? _self.slotWidthMeters : slotWidthMeters // ignore: cast_nullable_to_non_nullable
as double?,slotLengthMeters: freezed == slotLengthMeters ? _self.slotLengthMeters : slotLengthMeters // ignore: cast_nullable_to_non_nullable
as double?,baseRate: freezed == baseRate ? _self.baseRate : baseRate // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
