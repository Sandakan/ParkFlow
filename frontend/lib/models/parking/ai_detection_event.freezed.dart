// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_detection_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DetectedBox {

 String get label; double get confidence; double get x1; double get y1; double get x2; double get y2;
/// Create a copy of DetectedBox
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetectedBoxCopyWith<DetectedBox> get copyWith => _$DetectedBoxCopyWithImpl<DetectedBox>(this as DetectedBox, _$identity);

  /// Serializes this DetectedBox to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetectedBox&&(identical(other.label, label) || other.label == label)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.x1, x1) || other.x1 == x1)&&(identical(other.y1, y1) || other.y1 == y1)&&(identical(other.x2, x2) || other.x2 == x2)&&(identical(other.y2, y2) || other.y2 == y2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,confidence,x1,y1,x2,y2);

@override
String toString() {
  return 'DetectedBox(label: $label, confidence: $confidence, x1: $x1, y1: $y1, x2: $x2, y2: $y2)';
}


}

/// @nodoc
abstract mixin class $DetectedBoxCopyWith<$Res>  {
  factory $DetectedBoxCopyWith(DetectedBox value, $Res Function(DetectedBox) _then) = _$DetectedBoxCopyWithImpl;
@useResult
$Res call({
 String label, double confidence, double x1, double y1, double x2, double y2
});




}
/// @nodoc
class _$DetectedBoxCopyWithImpl<$Res>
    implements $DetectedBoxCopyWith<$Res> {
  _$DetectedBoxCopyWithImpl(this._self, this._then);

  final DetectedBox _self;
  final $Res Function(DetectedBox) _then;

/// Create a copy of DetectedBox
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? confidence = null,Object? x1 = null,Object? y1 = null,Object? x2 = null,Object? y2 = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,x1: null == x1 ? _self.x1 : x1 // ignore: cast_nullable_to_non_nullable
as double,y1: null == y1 ? _self.y1 : y1 // ignore: cast_nullable_to_non_nullable
as double,x2: null == x2 ? _self.x2 : x2 // ignore: cast_nullable_to_non_nullable
as double,y2: null == y2 ? _self.y2 : y2 // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DetectedBox].
extension DetectedBoxPatterns on DetectedBox {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DetectedBox value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DetectedBox() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DetectedBox value)  $default,){
final _that = this;
switch (_that) {
case _DetectedBox():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DetectedBox value)?  $default,){
final _that = this;
switch (_that) {
case _DetectedBox() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  double confidence,  double x1,  double y1,  double x2,  double y2)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DetectedBox() when $default != null:
return $default(_that.label,_that.confidence,_that.x1,_that.y1,_that.x2,_that.y2);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  double confidence,  double x1,  double y1,  double x2,  double y2)  $default,) {final _that = this;
switch (_that) {
case _DetectedBox():
return $default(_that.label,_that.confidence,_that.x1,_that.y1,_that.x2,_that.y2);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  double confidence,  double x1,  double y1,  double x2,  double y2)?  $default,) {final _that = this;
switch (_that) {
case _DetectedBox() when $default != null:
return $default(_that.label,_that.confidence,_that.x1,_that.y1,_that.x2,_that.y2);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DetectedBox implements DetectedBox {
  const _DetectedBox({required this.label, required this.confidence, required this.x1, required this.y1, required this.x2, required this.y2});
  factory _DetectedBox.fromJson(Map<String, dynamic> json) => _$DetectedBoxFromJson(json);

@override final  String label;
@override final  double confidence;
@override final  double x1;
@override final  double y1;
@override final  double x2;
@override final  double y2;

/// Create a copy of DetectedBox
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetectedBoxCopyWith<_DetectedBox> get copyWith => __$DetectedBoxCopyWithImpl<_DetectedBox>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DetectedBoxToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetectedBox&&(identical(other.label, label) || other.label == label)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.x1, x1) || other.x1 == x1)&&(identical(other.y1, y1) || other.y1 == y1)&&(identical(other.x2, x2) || other.x2 == x2)&&(identical(other.y2, y2) || other.y2 == y2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,confidence,x1,y1,x2,y2);

@override
String toString() {
  return 'DetectedBox(label: $label, confidence: $confidence, x1: $x1, y1: $y1, x2: $x2, y2: $y2)';
}


}

/// @nodoc
abstract mixin class _$DetectedBoxCopyWith<$Res> implements $DetectedBoxCopyWith<$Res> {
  factory _$DetectedBoxCopyWith(_DetectedBox value, $Res Function(_DetectedBox) _then) = __$DetectedBoxCopyWithImpl;
@override @useResult
$Res call({
 String label, double confidence, double x1, double y1, double x2, double y2
});




}
/// @nodoc
class __$DetectedBoxCopyWithImpl<$Res>
    implements _$DetectedBoxCopyWith<$Res> {
  __$DetectedBoxCopyWithImpl(this._self, this._then);

  final _DetectedBox _self;
  final $Res Function(_DetectedBox) _then;

/// Create a copy of DetectedBox
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? confidence = null,Object? x1 = null,Object? y1 = null,Object? x2 = null,Object? y2 = null,}) {
  return _then(_DetectedBox(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,x1: null == x1 ? _self.x1 : x1 // ignore: cast_nullable_to_non_nullable
as double,y1: null == y1 ? _self.y1 : y1 // ignore: cast_nullable_to_non_nullable
as double,x2: null == x2 ? _self.x2 : x2 // ignore: cast_nullable_to_non_nullable
as double,y2: null == y2 ? _self.y2 : y2 // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$SlotHit {

@JsonKey(name: 'slot_id') String get slotId;@JsonKey(name: 'mapping_id') String get mappingId;@JsonKey(name: 'is_occupied') bool get isOccupied;
/// Create a copy of SlotHit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlotHitCopyWith<SlotHit> get copyWith => _$SlotHitCopyWithImpl<SlotHit>(this as SlotHit, _$identity);

  /// Serializes this SlotHit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlotHit&&(identical(other.slotId, slotId) || other.slotId == slotId)&&(identical(other.mappingId, mappingId) || other.mappingId == mappingId)&&(identical(other.isOccupied, isOccupied) || other.isOccupied == isOccupied));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slotId,mappingId,isOccupied);

@override
String toString() {
  return 'SlotHit(slotId: $slotId, mappingId: $mappingId, isOccupied: $isOccupied)';
}


}

/// @nodoc
abstract mixin class $SlotHitCopyWith<$Res>  {
  factory $SlotHitCopyWith(SlotHit value, $Res Function(SlotHit) _then) = _$SlotHitCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'slot_id') String slotId,@JsonKey(name: 'mapping_id') String mappingId,@JsonKey(name: 'is_occupied') bool isOccupied
});




}
/// @nodoc
class _$SlotHitCopyWithImpl<$Res>
    implements $SlotHitCopyWith<$Res> {
  _$SlotHitCopyWithImpl(this._self, this._then);

  final SlotHit _self;
  final $Res Function(SlotHit) _then;

/// Create a copy of SlotHit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slotId = null,Object? mappingId = null,Object? isOccupied = null,}) {
  return _then(_self.copyWith(
slotId: null == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String,mappingId: null == mappingId ? _self.mappingId : mappingId // ignore: cast_nullable_to_non_nullable
as String,isOccupied: null == isOccupied ? _self.isOccupied : isOccupied // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SlotHit].
extension SlotHitPatterns on SlotHit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SlotHit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SlotHit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SlotHit value)  $default,){
final _that = this;
switch (_that) {
case _SlotHit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SlotHit value)?  $default,){
final _that = this;
switch (_that) {
case _SlotHit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'slot_id')  String slotId, @JsonKey(name: 'mapping_id')  String mappingId, @JsonKey(name: 'is_occupied')  bool isOccupied)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SlotHit() when $default != null:
return $default(_that.slotId,_that.mappingId,_that.isOccupied);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'slot_id')  String slotId, @JsonKey(name: 'mapping_id')  String mappingId, @JsonKey(name: 'is_occupied')  bool isOccupied)  $default,) {final _that = this;
switch (_that) {
case _SlotHit():
return $default(_that.slotId,_that.mappingId,_that.isOccupied);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'slot_id')  String slotId, @JsonKey(name: 'mapping_id')  String mappingId, @JsonKey(name: 'is_occupied')  bool isOccupied)?  $default,) {final _that = this;
switch (_that) {
case _SlotHit() when $default != null:
return $default(_that.slotId,_that.mappingId,_that.isOccupied);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SlotHit implements SlotHit {
  const _SlotHit({@JsonKey(name: 'slot_id') required this.slotId, @JsonKey(name: 'mapping_id') required this.mappingId, @JsonKey(name: 'is_occupied') required this.isOccupied});
  factory _SlotHit.fromJson(Map<String, dynamic> json) => _$SlotHitFromJson(json);

@override@JsonKey(name: 'slot_id') final  String slotId;
@override@JsonKey(name: 'mapping_id') final  String mappingId;
@override@JsonKey(name: 'is_occupied') final  bool isOccupied;

/// Create a copy of SlotHit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SlotHitCopyWith<_SlotHit> get copyWith => __$SlotHitCopyWithImpl<_SlotHit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SlotHitToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SlotHit&&(identical(other.slotId, slotId) || other.slotId == slotId)&&(identical(other.mappingId, mappingId) || other.mappingId == mappingId)&&(identical(other.isOccupied, isOccupied) || other.isOccupied == isOccupied));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slotId,mappingId,isOccupied);

@override
String toString() {
  return 'SlotHit(slotId: $slotId, mappingId: $mappingId, isOccupied: $isOccupied)';
}


}

/// @nodoc
abstract mixin class _$SlotHitCopyWith<$Res> implements $SlotHitCopyWith<$Res> {
  factory _$SlotHitCopyWith(_SlotHit value, $Res Function(_SlotHit) _then) = __$SlotHitCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'slot_id') String slotId,@JsonKey(name: 'mapping_id') String mappingId,@JsonKey(name: 'is_occupied') bool isOccupied
});




}
/// @nodoc
class __$SlotHitCopyWithImpl<$Res>
    implements _$SlotHitCopyWith<$Res> {
  __$SlotHitCopyWithImpl(this._self, this._then);

  final _SlotHit _self;
  final $Res Function(_SlotHit) _then;

/// Create a copy of SlotHit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slotId = null,Object? mappingId = null,Object? isOccupied = null,}) {
  return _then(_SlotHit(
slotId: null == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String,mappingId: null == mappingId ? _self.mappingId : mappingId // ignore: cast_nullable_to_non_nullable
as String,isOccupied: null == isOccupied ? _self.isOccupied : isOccupied // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AiDetectionEvent {

@JsonKey(name: 'camera_id') String get cameraId; String get timestamp; List<DetectedBox> get detections;@JsonKey(name: 'slot_hits') List<SlotHit> get slotHits;
/// Create a copy of AiDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiDetectionEventCopyWith<AiDetectionEvent> get copyWith => _$AiDetectionEventCopyWithImpl<AiDetectionEvent>(this as AiDetectionEvent, _$identity);

  /// Serializes this AiDetectionEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiDetectionEvent&&(identical(other.cameraId, cameraId) || other.cameraId == cameraId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.detections, detections)&&const DeepCollectionEquality().equals(other.slotHits, slotHits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cameraId,timestamp,const DeepCollectionEquality().hash(detections),const DeepCollectionEquality().hash(slotHits));

@override
String toString() {
  return 'AiDetectionEvent(cameraId: $cameraId, timestamp: $timestamp, detections: $detections, slotHits: $slotHits)';
}


}

/// @nodoc
abstract mixin class $AiDetectionEventCopyWith<$Res>  {
  factory $AiDetectionEventCopyWith(AiDetectionEvent value, $Res Function(AiDetectionEvent) _then) = _$AiDetectionEventCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'camera_id') String cameraId, String timestamp, List<DetectedBox> detections,@JsonKey(name: 'slot_hits') List<SlotHit> slotHits
});




}
/// @nodoc
class _$AiDetectionEventCopyWithImpl<$Res>
    implements $AiDetectionEventCopyWith<$Res> {
  _$AiDetectionEventCopyWithImpl(this._self, this._then);

  final AiDetectionEvent _self;
  final $Res Function(AiDetectionEvent) _then;

/// Create a copy of AiDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cameraId = null,Object? timestamp = null,Object? detections = null,Object? slotHits = null,}) {
  return _then(_self.copyWith(
cameraId: null == cameraId ? _self.cameraId : cameraId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,detections: null == detections ? _self.detections : detections // ignore: cast_nullable_to_non_nullable
as List<DetectedBox>,slotHits: null == slotHits ? _self.slotHits : slotHits // ignore: cast_nullable_to_non_nullable
as List<SlotHit>,
  ));
}

}


/// Adds pattern-matching-related methods to [AiDetectionEvent].
extension AiDetectionEventPatterns on AiDetectionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiDetectionEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiDetectionEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiDetectionEvent value)  $default,){
final _that = this;
switch (_that) {
case _AiDetectionEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiDetectionEvent value)?  $default,){
final _that = this;
switch (_that) {
case _AiDetectionEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'camera_id')  String cameraId,  String timestamp,  List<DetectedBox> detections, @JsonKey(name: 'slot_hits')  List<SlotHit> slotHits)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiDetectionEvent() when $default != null:
return $default(_that.cameraId,_that.timestamp,_that.detections,_that.slotHits);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'camera_id')  String cameraId,  String timestamp,  List<DetectedBox> detections, @JsonKey(name: 'slot_hits')  List<SlotHit> slotHits)  $default,) {final _that = this;
switch (_that) {
case _AiDetectionEvent():
return $default(_that.cameraId,_that.timestamp,_that.detections,_that.slotHits);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'camera_id')  String cameraId,  String timestamp,  List<DetectedBox> detections, @JsonKey(name: 'slot_hits')  List<SlotHit> slotHits)?  $default,) {final _that = this;
switch (_that) {
case _AiDetectionEvent() when $default != null:
return $default(_that.cameraId,_that.timestamp,_that.detections,_that.slotHits);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiDetectionEvent implements AiDetectionEvent {
  const _AiDetectionEvent({@JsonKey(name: 'camera_id') required this.cameraId, required this.timestamp, final  List<DetectedBox> detections = const [], @JsonKey(name: 'slot_hits') final  List<SlotHit> slotHits = const []}): _detections = detections,_slotHits = slotHits;
  factory _AiDetectionEvent.fromJson(Map<String, dynamic> json) => _$AiDetectionEventFromJson(json);

@override@JsonKey(name: 'camera_id') final  String cameraId;
@override final  String timestamp;
 final  List<DetectedBox> _detections;
@override@JsonKey() List<DetectedBox> get detections {
  if (_detections is EqualUnmodifiableListView) return _detections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_detections);
}

 final  List<SlotHit> _slotHits;
@override@JsonKey(name: 'slot_hits') List<SlotHit> get slotHits {
  if (_slotHits is EqualUnmodifiableListView) return _slotHits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slotHits);
}


/// Create a copy of AiDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiDetectionEventCopyWith<_AiDetectionEvent> get copyWith => __$AiDetectionEventCopyWithImpl<_AiDetectionEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiDetectionEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiDetectionEvent&&(identical(other.cameraId, cameraId) || other.cameraId == cameraId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._detections, _detections)&&const DeepCollectionEquality().equals(other._slotHits, _slotHits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cameraId,timestamp,const DeepCollectionEquality().hash(_detections),const DeepCollectionEquality().hash(_slotHits));

@override
String toString() {
  return 'AiDetectionEvent(cameraId: $cameraId, timestamp: $timestamp, detections: $detections, slotHits: $slotHits)';
}


}

/// @nodoc
abstract mixin class _$AiDetectionEventCopyWith<$Res> implements $AiDetectionEventCopyWith<$Res> {
  factory _$AiDetectionEventCopyWith(_AiDetectionEvent value, $Res Function(_AiDetectionEvent) _then) = __$AiDetectionEventCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'camera_id') String cameraId, String timestamp, List<DetectedBox> detections,@JsonKey(name: 'slot_hits') List<SlotHit> slotHits
});




}
/// @nodoc
class __$AiDetectionEventCopyWithImpl<$Res>
    implements _$AiDetectionEventCopyWith<$Res> {
  __$AiDetectionEventCopyWithImpl(this._self, this._then);

  final _AiDetectionEvent _self;
  final $Res Function(_AiDetectionEvent) _then;

/// Create a copy of AiDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cameraId = null,Object? timestamp = null,Object? detections = null,Object? slotHits = null,}) {
  return _then(_AiDetectionEvent(
cameraId: null == cameraId ? _self.cameraId : cameraId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,detections: null == detections ? _self._detections : detections // ignore: cast_nullable_to_non_nullable
as List<DetectedBox>,slotHits: null == slotHits ? _self._slotHits : slotHits // ignore: cast_nullable_to_non_nullable
as List<SlotHit>,
  ));
}


}

// dart format on
