// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'camera_info_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CameraInfoState {

 bool get isLoading; bool get isSavingSlot; CameraModel? get camera; List<ParkingSlotModel> get slots; InteractionMode get interactionMode; String get selectedSlotType; List<Offset> get currentDrawingPoints; bool get showAiDetections; bool get isSidebarCollapsed; List<DetectedBox> get aiDetections; Map<String, bool> get aiSlotHits; String? get error;
/// Create a copy of CameraInfoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CameraInfoStateCopyWith<CameraInfoState> get copyWith => _$CameraInfoStateCopyWithImpl<CameraInfoState>(this as CameraInfoState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CameraInfoState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSavingSlot, isSavingSlot) || other.isSavingSlot == isSavingSlot)&&(identical(other.camera, camera) || other.camera == camera)&&const DeepCollectionEquality().equals(other.slots, slots)&&(identical(other.interactionMode, interactionMode) || other.interactionMode == interactionMode)&&(identical(other.selectedSlotType, selectedSlotType) || other.selectedSlotType == selectedSlotType)&&const DeepCollectionEquality().equals(other.currentDrawingPoints, currentDrawingPoints)&&(identical(other.showAiDetections, showAiDetections) || other.showAiDetections == showAiDetections)&&(identical(other.isSidebarCollapsed, isSidebarCollapsed) || other.isSidebarCollapsed == isSidebarCollapsed)&&const DeepCollectionEquality().equals(other.aiDetections, aiDetections)&&const DeepCollectionEquality().equals(other.aiSlotHits, aiSlotHits)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSavingSlot,camera,const DeepCollectionEquality().hash(slots),interactionMode,selectedSlotType,const DeepCollectionEquality().hash(currentDrawingPoints),showAiDetections,isSidebarCollapsed,const DeepCollectionEquality().hash(aiDetections),const DeepCollectionEquality().hash(aiSlotHits),error);

@override
String toString() {
  return 'CameraInfoState(isLoading: $isLoading, isSavingSlot: $isSavingSlot, camera: $camera, slots: $slots, interactionMode: $interactionMode, selectedSlotType: $selectedSlotType, currentDrawingPoints: $currentDrawingPoints, showAiDetections: $showAiDetections, isSidebarCollapsed: $isSidebarCollapsed, aiDetections: $aiDetections, aiSlotHits: $aiSlotHits, error: $error)';
}


}

/// @nodoc
abstract mixin class $CameraInfoStateCopyWith<$Res>  {
  factory $CameraInfoStateCopyWith(CameraInfoState value, $Res Function(CameraInfoState) _then) = _$CameraInfoStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isSavingSlot, CameraModel? camera, List<ParkingSlotModel> slots, InteractionMode interactionMode, String selectedSlotType, List<Offset> currentDrawingPoints, bool showAiDetections, bool isSidebarCollapsed, List<DetectedBox> aiDetections, Map<String, bool> aiSlotHits, String? error
});


$CameraModelCopyWith<$Res>? get camera;

}
/// @nodoc
class _$CameraInfoStateCopyWithImpl<$Res>
    implements $CameraInfoStateCopyWith<$Res> {
  _$CameraInfoStateCopyWithImpl(this._self, this._then);

  final CameraInfoState _self;
  final $Res Function(CameraInfoState) _then;

/// Create a copy of CameraInfoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isSavingSlot = null,Object? camera = freezed,Object? slots = null,Object? interactionMode = null,Object? selectedSlotType = null,Object? currentDrawingPoints = null,Object? showAiDetections = null,Object? isSidebarCollapsed = null,Object? aiDetections = null,Object? aiSlotHits = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSavingSlot: null == isSavingSlot ? _self.isSavingSlot : isSavingSlot // ignore: cast_nullable_to_non_nullable
as bool,camera: freezed == camera ? _self.camera : camera // ignore: cast_nullable_to_non_nullable
as CameraModel?,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as List<ParkingSlotModel>,interactionMode: null == interactionMode ? _self.interactionMode : interactionMode // ignore: cast_nullable_to_non_nullable
as InteractionMode,selectedSlotType: null == selectedSlotType ? _self.selectedSlotType : selectedSlotType // ignore: cast_nullable_to_non_nullable
as String,currentDrawingPoints: null == currentDrawingPoints ? _self.currentDrawingPoints : currentDrawingPoints // ignore: cast_nullable_to_non_nullable
as List<Offset>,showAiDetections: null == showAiDetections ? _self.showAiDetections : showAiDetections // ignore: cast_nullable_to_non_nullable
as bool,isSidebarCollapsed: null == isSidebarCollapsed ? _self.isSidebarCollapsed : isSidebarCollapsed // ignore: cast_nullable_to_non_nullable
as bool,aiDetections: null == aiDetections ? _self.aiDetections : aiDetections // ignore: cast_nullable_to_non_nullable
as List<DetectedBox>,aiSlotHits: null == aiSlotHits ? _self.aiSlotHits : aiSlotHits // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CameraInfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CameraModelCopyWith<$Res>? get camera {
    if (_self.camera == null) {
    return null;
  }

  return $CameraModelCopyWith<$Res>(_self.camera!, (value) {
    return _then(_self.copyWith(camera: value));
  });
}
}


/// Adds pattern-matching-related methods to [CameraInfoState].
extension CameraInfoStatePatterns on CameraInfoState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CameraInfoState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CameraInfoState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CameraInfoState value)  $default,){
final _that = this;
switch (_that) {
case _CameraInfoState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CameraInfoState value)?  $default,){
final _that = this;
switch (_that) {
case _CameraInfoState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isSavingSlot,  CameraModel? camera,  List<ParkingSlotModel> slots,  InteractionMode interactionMode,  String selectedSlotType,  List<Offset> currentDrawingPoints,  bool showAiDetections,  bool isSidebarCollapsed,  List<DetectedBox> aiDetections,  Map<String, bool> aiSlotHits,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CameraInfoState() when $default != null:
return $default(_that.isLoading,_that.isSavingSlot,_that.camera,_that.slots,_that.interactionMode,_that.selectedSlotType,_that.currentDrawingPoints,_that.showAiDetections,_that.isSidebarCollapsed,_that.aiDetections,_that.aiSlotHits,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isSavingSlot,  CameraModel? camera,  List<ParkingSlotModel> slots,  InteractionMode interactionMode,  String selectedSlotType,  List<Offset> currentDrawingPoints,  bool showAiDetections,  bool isSidebarCollapsed,  List<DetectedBox> aiDetections,  Map<String, bool> aiSlotHits,  String? error)  $default,) {final _that = this;
switch (_that) {
case _CameraInfoState():
return $default(_that.isLoading,_that.isSavingSlot,_that.camera,_that.slots,_that.interactionMode,_that.selectedSlotType,_that.currentDrawingPoints,_that.showAiDetections,_that.isSidebarCollapsed,_that.aiDetections,_that.aiSlotHits,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isSavingSlot,  CameraModel? camera,  List<ParkingSlotModel> slots,  InteractionMode interactionMode,  String selectedSlotType,  List<Offset> currentDrawingPoints,  bool showAiDetections,  bool isSidebarCollapsed,  List<DetectedBox> aiDetections,  Map<String, bool> aiSlotHits,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _CameraInfoState() when $default != null:
return $default(_that.isLoading,_that.isSavingSlot,_that.camera,_that.slots,_that.interactionMode,_that.selectedSlotType,_that.currentDrawingPoints,_that.showAiDetections,_that.isSidebarCollapsed,_that.aiDetections,_that.aiSlotHits,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _CameraInfoState implements CameraInfoState {
  const _CameraInfoState({this.isLoading = true, this.isSavingSlot = false, this.camera, final  List<ParkingSlotModel> slots = const [], this.interactionMode = InteractionMode.inspection, this.selectedSlotType = 'general', final  List<Offset> currentDrawingPoints = const [], this.showAiDetections = false, this.isSidebarCollapsed = false, final  List<DetectedBox> aiDetections = const [], final  Map<String, bool> aiSlotHits = const {}, this.error}): _slots = slots,_currentDrawingPoints = currentDrawingPoints,_aiDetections = aiDetections,_aiSlotHits = aiSlotHits;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSavingSlot;
@override final  CameraModel? camera;
 final  List<ParkingSlotModel> _slots;
@override@JsonKey() List<ParkingSlotModel> get slots {
  if (_slots is EqualUnmodifiableListView) return _slots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slots);
}

@override@JsonKey() final  InteractionMode interactionMode;
@override@JsonKey() final  String selectedSlotType;
 final  List<Offset> _currentDrawingPoints;
@override@JsonKey() List<Offset> get currentDrawingPoints {
  if (_currentDrawingPoints is EqualUnmodifiableListView) return _currentDrawingPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currentDrawingPoints);
}

@override@JsonKey() final  bool showAiDetections;
@override@JsonKey() final  bool isSidebarCollapsed;
 final  List<DetectedBox> _aiDetections;
@override@JsonKey() List<DetectedBox> get aiDetections {
  if (_aiDetections is EqualUnmodifiableListView) return _aiDetections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_aiDetections);
}

 final  Map<String, bool> _aiSlotHits;
@override@JsonKey() Map<String, bool> get aiSlotHits {
  if (_aiSlotHits is EqualUnmodifiableMapView) return _aiSlotHits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_aiSlotHits);
}

@override final  String? error;

/// Create a copy of CameraInfoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CameraInfoStateCopyWith<_CameraInfoState> get copyWith => __$CameraInfoStateCopyWithImpl<_CameraInfoState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CameraInfoState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSavingSlot, isSavingSlot) || other.isSavingSlot == isSavingSlot)&&(identical(other.camera, camera) || other.camera == camera)&&const DeepCollectionEquality().equals(other._slots, _slots)&&(identical(other.interactionMode, interactionMode) || other.interactionMode == interactionMode)&&(identical(other.selectedSlotType, selectedSlotType) || other.selectedSlotType == selectedSlotType)&&const DeepCollectionEquality().equals(other._currentDrawingPoints, _currentDrawingPoints)&&(identical(other.showAiDetections, showAiDetections) || other.showAiDetections == showAiDetections)&&(identical(other.isSidebarCollapsed, isSidebarCollapsed) || other.isSidebarCollapsed == isSidebarCollapsed)&&const DeepCollectionEquality().equals(other._aiDetections, _aiDetections)&&const DeepCollectionEquality().equals(other._aiSlotHits, _aiSlotHits)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSavingSlot,camera,const DeepCollectionEquality().hash(_slots),interactionMode,selectedSlotType,const DeepCollectionEquality().hash(_currentDrawingPoints),showAiDetections,isSidebarCollapsed,const DeepCollectionEquality().hash(_aiDetections),const DeepCollectionEquality().hash(_aiSlotHits),error);

@override
String toString() {
  return 'CameraInfoState(isLoading: $isLoading, isSavingSlot: $isSavingSlot, camera: $camera, slots: $slots, interactionMode: $interactionMode, selectedSlotType: $selectedSlotType, currentDrawingPoints: $currentDrawingPoints, showAiDetections: $showAiDetections, isSidebarCollapsed: $isSidebarCollapsed, aiDetections: $aiDetections, aiSlotHits: $aiSlotHits, error: $error)';
}


}

/// @nodoc
abstract mixin class _$CameraInfoStateCopyWith<$Res> implements $CameraInfoStateCopyWith<$Res> {
  factory _$CameraInfoStateCopyWith(_CameraInfoState value, $Res Function(_CameraInfoState) _then) = __$CameraInfoStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isSavingSlot, CameraModel? camera, List<ParkingSlotModel> slots, InteractionMode interactionMode, String selectedSlotType, List<Offset> currentDrawingPoints, bool showAiDetections, bool isSidebarCollapsed, List<DetectedBox> aiDetections, Map<String, bool> aiSlotHits, String? error
});


@override $CameraModelCopyWith<$Res>? get camera;

}
/// @nodoc
class __$CameraInfoStateCopyWithImpl<$Res>
    implements _$CameraInfoStateCopyWith<$Res> {
  __$CameraInfoStateCopyWithImpl(this._self, this._then);

  final _CameraInfoState _self;
  final $Res Function(_CameraInfoState) _then;

/// Create a copy of CameraInfoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isSavingSlot = null,Object? camera = freezed,Object? slots = null,Object? interactionMode = null,Object? selectedSlotType = null,Object? currentDrawingPoints = null,Object? showAiDetections = null,Object? isSidebarCollapsed = null,Object? aiDetections = null,Object? aiSlotHits = null,Object? error = freezed,}) {
  return _then(_CameraInfoState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSavingSlot: null == isSavingSlot ? _self.isSavingSlot : isSavingSlot // ignore: cast_nullable_to_non_nullable
as bool,camera: freezed == camera ? _self.camera : camera // ignore: cast_nullable_to_non_nullable
as CameraModel?,slots: null == slots ? _self._slots : slots // ignore: cast_nullable_to_non_nullable
as List<ParkingSlotModel>,interactionMode: null == interactionMode ? _self.interactionMode : interactionMode // ignore: cast_nullable_to_non_nullable
as InteractionMode,selectedSlotType: null == selectedSlotType ? _self.selectedSlotType : selectedSlotType // ignore: cast_nullable_to_non_nullable
as String,currentDrawingPoints: null == currentDrawingPoints ? _self._currentDrawingPoints : currentDrawingPoints // ignore: cast_nullable_to_non_nullable
as List<Offset>,showAiDetections: null == showAiDetections ? _self.showAiDetections : showAiDetections // ignore: cast_nullable_to_non_nullable
as bool,isSidebarCollapsed: null == isSidebarCollapsed ? _self.isSidebarCollapsed : isSidebarCollapsed // ignore: cast_nullable_to_non_nullable
as bool,aiDetections: null == aiDetections ? _self._aiDetections : aiDetections // ignore: cast_nullable_to_non_nullable
as List<DetectedBox>,aiSlotHits: null == aiSlotHits ? _self._aiSlotHits : aiSlotHits // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CameraInfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CameraModelCopyWith<$Res>? get camera {
    if (_self.camera == null) {
    return null;
  }

  return $CameraModelCopyWith<$Res>(_self.camera!, (value) {
    return _then(_self.copyWith(camera: value));
  });
}
}

// dart format on
