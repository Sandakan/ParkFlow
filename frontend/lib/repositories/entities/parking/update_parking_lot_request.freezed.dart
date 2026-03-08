// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_parking_lot_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateParkingLotRequest {

 String? get name; String? get address; double? get latitude; double? get longitude;@JsonKey(name: 'entrance_logical_locations') List<List<int>>? get entranceLogicalLocations;@JsonKey(name: 'slot_width_meters') double? get slotWidthMeters;@JsonKey(name: 'slot_length_meters') double? get slotLengthMeters;
/// Create a copy of UpdateParkingLotRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateParkingLotRequestCopyWith<UpdateParkingLotRequest> get copyWith => _$UpdateParkingLotRequestCopyWithImpl<UpdateParkingLotRequest>(this as UpdateParkingLotRequest, _$identity);

  /// Serializes this UpdateParkingLotRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateParkingLotRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&const DeepCollectionEquality().equals(other.entranceLogicalLocations, entranceLogicalLocations)&&(identical(other.slotWidthMeters, slotWidthMeters) || other.slotWidthMeters == slotWidthMeters)&&(identical(other.slotLengthMeters, slotLengthMeters) || other.slotLengthMeters == slotLengthMeters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,address,latitude,longitude,const DeepCollectionEquality().hash(entranceLogicalLocations),slotWidthMeters,slotLengthMeters);

@override
String toString() {
  return 'UpdateParkingLotRequest(name: $name, address: $address, latitude: $latitude, longitude: $longitude, entranceLogicalLocations: $entranceLogicalLocations, slotWidthMeters: $slotWidthMeters, slotLengthMeters: $slotLengthMeters)';
}


}

/// @nodoc
abstract mixin class $UpdateParkingLotRequestCopyWith<$Res>  {
  factory $UpdateParkingLotRequestCopyWith(UpdateParkingLotRequest value, $Res Function(UpdateParkingLotRequest) _then) = _$UpdateParkingLotRequestCopyWithImpl;
@useResult
$Res call({
 String? name, String? address, double? latitude, double? longitude,@JsonKey(name: 'entrance_logical_locations') List<List<int>>? entranceLogicalLocations,@JsonKey(name: 'slot_width_meters') double? slotWidthMeters,@JsonKey(name: 'slot_length_meters') double? slotLengthMeters
});




}
/// @nodoc
class _$UpdateParkingLotRequestCopyWithImpl<$Res>
    implements $UpdateParkingLotRequestCopyWith<$Res> {
  _$UpdateParkingLotRequestCopyWithImpl(this._self, this._then);

  final UpdateParkingLotRequest _self;
  final $Res Function(UpdateParkingLotRequest) _then;

/// Create a copy of UpdateParkingLotRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? address = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? entranceLogicalLocations = freezed,Object? slotWidthMeters = freezed,Object? slotLengthMeters = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,entranceLogicalLocations: freezed == entranceLogicalLocations ? _self.entranceLogicalLocations : entranceLogicalLocations // ignore: cast_nullable_to_non_nullable
as List<List<int>>?,slotWidthMeters: freezed == slotWidthMeters ? _self.slotWidthMeters : slotWidthMeters // ignore: cast_nullable_to_non_nullable
as double?,slotLengthMeters: freezed == slotLengthMeters ? _self.slotLengthMeters : slotLengthMeters // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateParkingLotRequest].
extension UpdateParkingLotRequestPatterns on UpdateParkingLotRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateParkingLotRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateParkingLotRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateParkingLotRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateParkingLotRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateParkingLotRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateParkingLotRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? address,  double? latitude,  double? longitude, @JsonKey(name: 'entrance_logical_locations')  List<List<int>>? entranceLogicalLocations, @JsonKey(name: 'slot_width_meters')  double? slotWidthMeters, @JsonKey(name: 'slot_length_meters')  double? slotLengthMeters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateParkingLotRequest() when $default != null:
return $default(_that.name,_that.address,_that.latitude,_that.longitude,_that.entranceLogicalLocations,_that.slotWidthMeters,_that.slotLengthMeters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? address,  double? latitude,  double? longitude, @JsonKey(name: 'entrance_logical_locations')  List<List<int>>? entranceLogicalLocations, @JsonKey(name: 'slot_width_meters')  double? slotWidthMeters, @JsonKey(name: 'slot_length_meters')  double? slotLengthMeters)  $default,) {final _that = this;
switch (_that) {
case _UpdateParkingLotRequest():
return $default(_that.name,_that.address,_that.latitude,_that.longitude,_that.entranceLogicalLocations,_that.slotWidthMeters,_that.slotLengthMeters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? address,  double? latitude,  double? longitude, @JsonKey(name: 'entrance_logical_locations')  List<List<int>>? entranceLogicalLocations, @JsonKey(name: 'slot_width_meters')  double? slotWidthMeters, @JsonKey(name: 'slot_length_meters')  double? slotLengthMeters)?  $default,) {final _that = this;
switch (_that) {
case _UpdateParkingLotRequest() when $default != null:
return $default(_that.name,_that.address,_that.latitude,_that.longitude,_that.entranceLogicalLocations,_that.slotWidthMeters,_that.slotLengthMeters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateParkingLotRequest extends UpdateParkingLotRequest {
  const _UpdateParkingLotRequest({this.name, this.address, this.latitude, this.longitude, @JsonKey(name: 'entrance_logical_locations') final  List<List<int>>? entranceLogicalLocations, @JsonKey(name: 'slot_width_meters') this.slotWidthMeters, @JsonKey(name: 'slot_length_meters') this.slotLengthMeters}): _entranceLogicalLocations = entranceLogicalLocations,super._();
  factory _UpdateParkingLotRequest.fromJson(Map<String, dynamic> json) => _$UpdateParkingLotRequestFromJson(json);

@override final  String? name;
@override final  String? address;
@override final  double? latitude;
@override final  double? longitude;
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

/// Create a copy of UpdateParkingLotRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateParkingLotRequestCopyWith<_UpdateParkingLotRequest> get copyWith => __$UpdateParkingLotRequestCopyWithImpl<_UpdateParkingLotRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateParkingLotRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateParkingLotRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&const DeepCollectionEquality().equals(other._entranceLogicalLocations, _entranceLogicalLocations)&&(identical(other.slotWidthMeters, slotWidthMeters) || other.slotWidthMeters == slotWidthMeters)&&(identical(other.slotLengthMeters, slotLengthMeters) || other.slotLengthMeters == slotLengthMeters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,address,latitude,longitude,const DeepCollectionEquality().hash(_entranceLogicalLocations),slotWidthMeters,slotLengthMeters);

@override
String toString() {
  return 'UpdateParkingLotRequest(name: $name, address: $address, latitude: $latitude, longitude: $longitude, entranceLogicalLocations: $entranceLogicalLocations, slotWidthMeters: $slotWidthMeters, slotLengthMeters: $slotLengthMeters)';
}


}

/// @nodoc
abstract mixin class _$UpdateParkingLotRequestCopyWith<$Res> implements $UpdateParkingLotRequestCopyWith<$Res> {
  factory _$UpdateParkingLotRequestCopyWith(_UpdateParkingLotRequest value, $Res Function(_UpdateParkingLotRequest) _then) = __$UpdateParkingLotRequestCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? address, double? latitude, double? longitude,@JsonKey(name: 'entrance_logical_locations') List<List<int>>? entranceLogicalLocations,@JsonKey(name: 'slot_width_meters') double? slotWidthMeters,@JsonKey(name: 'slot_length_meters') double? slotLengthMeters
});




}
/// @nodoc
class __$UpdateParkingLotRequestCopyWithImpl<$Res>
    implements _$UpdateParkingLotRequestCopyWith<$Res> {
  __$UpdateParkingLotRequestCopyWithImpl(this._self, this._then);

  final _UpdateParkingLotRequest _self;
  final $Res Function(_UpdateParkingLotRequest) _then;

/// Create a copy of UpdateParkingLotRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? address = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? entranceLogicalLocations = freezed,Object? slotWidthMeters = freezed,Object? slotLengthMeters = freezed,}) {
  return _then(_UpdateParkingLotRequest(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,entranceLogicalLocations: freezed == entranceLogicalLocations ? _self._entranceLogicalLocations : entranceLogicalLocations // ignore: cast_nullable_to_non_nullable
as List<List<int>>?,slotWidthMeters: freezed == slotWidthMeters ? _self.slotWidthMeters : slotWidthMeters // ignore: cast_nullable_to_non_nullable
as double?,slotLengthMeters: freezed == slotLengthMeters ? _self.slotLengthMeters : slotLengthMeters // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
