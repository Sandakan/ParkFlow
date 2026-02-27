// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_parking_lot_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateParkingLotRequest {

 String get name; String get address; double get latitude; double get longitude;@JsonKey(name: 'total_slots') int get totalSlots;
/// Create a copy of CreateParkingLotRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateParkingLotRequestCopyWith<CreateParkingLotRequest> get copyWith => _$CreateParkingLotRequestCopyWithImpl<CreateParkingLotRequest>(this as CreateParkingLotRequest, _$identity);

  /// Serializes this CreateParkingLotRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateParkingLotRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.totalSlots, totalSlots) || other.totalSlots == totalSlots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,address,latitude,longitude,totalSlots);

@override
String toString() {
  return 'CreateParkingLotRequest(name: $name, address: $address, latitude: $latitude, longitude: $longitude, totalSlots: $totalSlots)';
}


}

/// @nodoc
abstract mixin class $CreateParkingLotRequestCopyWith<$Res>  {
  factory $CreateParkingLotRequestCopyWith(CreateParkingLotRequest value, $Res Function(CreateParkingLotRequest) _then) = _$CreateParkingLotRequestCopyWithImpl;
@useResult
$Res call({
 String name, String address, double latitude, double longitude,@JsonKey(name: 'total_slots') int totalSlots
});




}
/// @nodoc
class _$CreateParkingLotRequestCopyWithImpl<$Res>
    implements $CreateParkingLotRequestCopyWith<$Res> {
  _$CreateParkingLotRequestCopyWithImpl(this._self, this._then);

  final CreateParkingLotRequest _self;
  final $Res Function(CreateParkingLotRequest) _then;

/// Create a copy of CreateParkingLotRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? address = null,Object? latitude = null,Object? longitude = null,Object? totalSlots = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,totalSlots: null == totalSlots ? _self.totalSlots : totalSlots // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateParkingLotRequest].
extension CreateParkingLotRequestPatterns on CreateParkingLotRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateParkingLotRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateParkingLotRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateParkingLotRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateParkingLotRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateParkingLotRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateParkingLotRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String address,  double latitude,  double longitude, @JsonKey(name: 'total_slots')  int totalSlots)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateParkingLotRequest() when $default != null:
return $default(_that.name,_that.address,_that.latitude,_that.longitude,_that.totalSlots);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String address,  double latitude,  double longitude, @JsonKey(name: 'total_slots')  int totalSlots)  $default,) {final _that = this;
switch (_that) {
case _CreateParkingLotRequest():
return $default(_that.name,_that.address,_that.latitude,_that.longitude,_that.totalSlots);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String address,  double latitude,  double longitude, @JsonKey(name: 'total_slots')  int totalSlots)?  $default,) {final _that = this;
switch (_that) {
case _CreateParkingLotRequest() when $default != null:
return $default(_that.name,_that.address,_that.latitude,_that.longitude,_that.totalSlots);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateParkingLotRequest extends CreateParkingLotRequest {
  const _CreateParkingLotRequest({required this.name, required this.address, required this.latitude, required this.longitude, @JsonKey(name: 'total_slots') required this.totalSlots}): super._();
  factory _CreateParkingLotRequest.fromJson(Map<String, dynamic> json) => _$CreateParkingLotRequestFromJson(json);

@override final  String name;
@override final  String address;
@override final  double latitude;
@override final  double longitude;
@override@JsonKey(name: 'total_slots') final  int totalSlots;

/// Create a copy of CreateParkingLotRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateParkingLotRequestCopyWith<_CreateParkingLotRequest> get copyWith => __$CreateParkingLotRequestCopyWithImpl<_CreateParkingLotRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateParkingLotRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateParkingLotRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.totalSlots, totalSlots) || other.totalSlots == totalSlots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,address,latitude,longitude,totalSlots);

@override
String toString() {
  return 'CreateParkingLotRequest(name: $name, address: $address, latitude: $latitude, longitude: $longitude, totalSlots: $totalSlots)';
}


}

/// @nodoc
abstract mixin class _$CreateParkingLotRequestCopyWith<$Res> implements $CreateParkingLotRequestCopyWith<$Res> {
  factory _$CreateParkingLotRequestCopyWith(_CreateParkingLotRequest value, $Res Function(_CreateParkingLotRequest) _then) = __$CreateParkingLotRequestCopyWithImpl;
@override @useResult
$Res call({
 String name, String address, double latitude, double longitude,@JsonKey(name: 'total_slots') int totalSlots
});




}
/// @nodoc
class __$CreateParkingLotRequestCopyWithImpl<$Res>
    implements _$CreateParkingLotRequestCopyWith<$Res> {
  __$CreateParkingLotRequestCopyWithImpl(this._self, this._then);

  final _CreateParkingLotRequest _self;
  final $Res Function(_CreateParkingLotRequest) _then;

/// Create a copy of CreateParkingLotRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? address = null,Object? latitude = null,Object? longitude = null,Object? totalSlots = null,}) {
  return _then(_CreateParkingLotRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,totalSlots: null == totalSlots ? _self.totalSlots : totalSlots // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
