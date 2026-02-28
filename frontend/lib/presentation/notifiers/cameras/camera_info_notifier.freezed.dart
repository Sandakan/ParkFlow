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

 bool get isLoading; CameraModel? get camera; InteractionMode get interactionMode; List<Offset> get currentDrawingPoints; bool get showAiDetections; String? get error;
/// Create a copy of CameraInfoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CameraInfoStateCopyWith<CameraInfoState> get copyWith => _$CameraInfoStateCopyWithImpl<CameraInfoState>(this as CameraInfoState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CameraInfoState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.camera, camera) || other.camera == camera)&&(identical(other.interactionMode, interactionMode) || other.interactionMode == interactionMode)&&const DeepCollectionEquality().equals(other.currentDrawingPoints, currentDrawingPoints)&&(identical(other.showAiDetections, showAiDetections) || other.showAiDetections == showAiDetections)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,camera,interactionMode,const DeepCollectionEquality().hash(currentDrawingPoints),showAiDetections,error);

@override
String toString() {
  return 'CameraInfoState(isLoading: $isLoading, camera: $camera, interactionMode: $interactionMode, currentDrawingPoints: $currentDrawingPoints, showAiDetections: $showAiDetections, error: $error)';
}


}

/// @nodoc
abstract mixin class $CameraInfoStateCopyWith<$Res>  {
  factory $CameraInfoStateCopyWith(CameraInfoState value, $Res Function(CameraInfoState) _then) = _$CameraInfoStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, CameraModel? camera, InteractionMode interactionMode, List<Offset> currentDrawingPoints, bool showAiDetections, String? error
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
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? camera = freezed,Object? interactionMode = null,Object? currentDrawingPoints = null,Object? showAiDetections = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,camera: freezed == camera ? _self.camera : camera // ignore: cast_nullable_to_non_nullable
as CameraModel?,interactionMode: null == interactionMode ? _self.interactionMode : interactionMode // ignore: cast_nullable_to_non_nullable
as InteractionMode,currentDrawingPoints: null == currentDrawingPoints ? _self.currentDrawingPoints : currentDrawingPoints // ignore: cast_nullable_to_non_nullable
as List<Offset>,showAiDetections: null == showAiDetections ? _self.showAiDetections : showAiDetections // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  CameraModel? camera,  InteractionMode interactionMode,  List<Offset> currentDrawingPoints,  bool showAiDetections,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CameraInfoState() when $default != null:
return $default(_that.isLoading,_that.camera,_that.interactionMode,_that.currentDrawingPoints,_that.showAiDetections,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  CameraModel? camera,  InteractionMode interactionMode,  List<Offset> currentDrawingPoints,  bool showAiDetections,  String? error)  $default,) {final _that = this;
switch (_that) {
case _CameraInfoState():
return $default(_that.isLoading,_that.camera,_that.interactionMode,_that.currentDrawingPoints,_that.showAiDetections,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  CameraModel? camera,  InteractionMode interactionMode,  List<Offset> currentDrawingPoints,  bool showAiDetections,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _CameraInfoState() when $default != null:
return $default(_that.isLoading,_that.camera,_that.interactionMode,_that.currentDrawingPoints,_that.showAiDetections,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _CameraInfoState implements CameraInfoState {
  const _CameraInfoState({this.isLoading = true, this.camera, this.interactionMode = InteractionMode.inspection, final  List<Offset> currentDrawingPoints = const [], this.showAiDetections = false, this.error}): _currentDrawingPoints = currentDrawingPoints;
  

@override@JsonKey() final  bool isLoading;
@override final  CameraModel? camera;
@override@JsonKey() final  InteractionMode interactionMode;
 final  List<Offset> _currentDrawingPoints;
@override@JsonKey() List<Offset> get currentDrawingPoints {
  if (_currentDrawingPoints is EqualUnmodifiableListView) return _currentDrawingPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currentDrawingPoints);
}

@override@JsonKey() final  bool showAiDetections;
@override final  String? error;

/// Create a copy of CameraInfoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CameraInfoStateCopyWith<_CameraInfoState> get copyWith => __$CameraInfoStateCopyWithImpl<_CameraInfoState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CameraInfoState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.camera, camera) || other.camera == camera)&&(identical(other.interactionMode, interactionMode) || other.interactionMode == interactionMode)&&const DeepCollectionEquality().equals(other._currentDrawingPoints, _currentDrawingPoints)&&(identical(other.showAiDetections, showAiDetections) || other.showAiDetections == showAiDetections)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,camera,interactionMode,const DeepCollectionEquality().hash(_currentDrawingPoints),showAiDetections,error);

@override
String toString() {
  return 'CameraInfoState(isLoading: $isLoading, camera: $camera, interactionMode: $interactionMode, currentDrawingPoints: $currentDrawingPoints, showAiDetections: $showAiDetections, error: $error)';
}


}

/// @nodoc
abstract mixin class _$CameraInfoStateCopyWith<$Res> implements $CameraInfoStateCopyWith<$Res> {
  factory _$CameraInfoStateCopyWith(_CameraInfoState value, $Res Function(_CameraInfoState) _then) = __$CameraInfoStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, CameraModel? camera, InteractionMode interactionMode, List<Offset> currentDrawingPoints, bool showAiDetections, String? error
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
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? camera = freezed,Object? interactionMode = null,Object? currentDrawingPoints = null,Object? showAiDetections = null,Object? error = freezed,}) {
  return _then(_CameraInfoState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,camera: freezed == camera ? _self.camera : camera // ignore: cast_nullable_to_non_nullable
as CameraModel?,interactionMode: null == interactionMode ? _self.interactionMode : interactionMode // ignore: cast_nullable_to_non_nullable
as InteractionMode,currentDrawingPoints: null == currentDrawingPoints ? _self._currentDrawingPoints : currentDrawingPoints // ignore: cast_nullable_to_non_nullable
as List<Offset>,showAiDetections: null == showAiDetections ? _self.showAiDetections : showAiDetections // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
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
