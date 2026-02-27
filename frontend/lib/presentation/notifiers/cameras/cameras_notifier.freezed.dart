// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cameras_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CamerasState {

 List<CameraModel> get cameras; List<CameraModel> get filteredCameras; bool get isLoading; String? get error; String get searchQuery;
/// Create a copy of CamerasState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CamerasStateCopyWith<CamerasState> get copyWith => _$CamerasStateCopyWithImpl<CamerasState>(this as CamerasState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CamerasState&&const DeepCollectionEquality().equals(other.cameras, cameras)&&const DeepCollectionEquality().equals(other.filteredCameras, filteredCameras)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cameras),const DeepCollectionEquality().hash(filteredCameras),isLoading,error,searchQuery);

@override
String toString() {
  return 'CamerasState(cameras: $cameras, filteredCameras: $filteredCameras, isLoading: $isLoading, error: $error, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class $CamerasStateCopyWith<$Res>  {
  factory $CamerasStateCopyWith(CamerasState value, $Res Function(CamerasState) _then) = _$CamerasStateCopyWithImpl;
@useResult
$Res call({
 List<CameraModel> cameras, List<CameraModel> filteredCameras, bool isLoading, String? error, String searchQuery
});




}
/// @nodoc
class _$CamerasStateCopyWithImpl<$Res>
    implements $CamerasStateCopyWith<$Res> {
  _$CamerasStateCopyWithImpl(this._self, this._then);

  final CamerasState _self;
  final $Res Function(CamerasState) _then;

/// Create a copy of CamerasState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cameras = null,Object? filteredCameras = null,Object? isLoading = null,Object? error = freezed,Object? searchQuery = null,}) {
  return _then(_self.copyWith(
cameras: null == cameras ? _self.cameras : cameras // ignore: cast_nullable_to_non_nullable
as List<CameraModel>,filteredCameras: null == filteredCameras ? _self.filteredCameras : filteredCameras // ignore: cast_nullable_to_non_nullable
as List<CameraModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CamerasState].
extension CamerasStatePatterns on CamerasState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CamerasState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CamerasState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CamerasState value)  $default,){
final _that = this;
switch (_that) {
case _CamerasState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CamerasState value)?  $default,){
final _that = this;
switch (_that) {
case _CamerasState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CameraModel> cameras,  List<CameraModel> filteredCameras,  bool isLoading,  String? error,  String searchQuery)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CamerasState() when $default != null:
return $default(_that.cameras,_that.filteredCameras,_that.isLoading,_that.error,_that.searchQuery);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CameraModel> cameras,  List<CameraModel> filteredCameras,  bool isLoading,  String? error,  String searchQuery)  $default,) {final _that = this;
switch (_that) {
case _CamerasState():
return $default(_that.cameras,_that.filteredCameras,_that.isLoading,_that.error,_that.searchQuery);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CameraModel> cameras,  List<CameraModel> filteredCameras,  bool isLoading,  String? error,  String searchQuery)?  $default,) {final _that = this;
switch (_that) {
case _CamerasState() when $default != null:
return $default(_that.cameras,_that.filteredCameras,_that.isLoading,_that.error,_that.searchQuery);case _:
  return null;

}
}

}

/// @nodoc


class _CamerasState implements CamerasState {
  const _CamerasState({final  List<CameraModel> cameras = const [], final  List<CameraModel> filteredCameras = const [], this.isLoading = true, this.error, this.searchQuery = ''}): _cameras = cameras,_filteredCameras = filteredCameras;
  

 final  List<CameraModel> _cameras;
@override@JsonKey() List<CameraModel> get cameras {
  if (_cameras is EqualUnmodifiableListView) return _cameras;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cameras);
}

 final  List<CameraModel> _filteredCameras;
@override@JsonKey() List<CameraModel> get filteredCameras {
  if (_filteredCameras is EqualUnmodifiableListView) return _filteredCameras;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredCameras);
}

@override@JsonKey() final  bool isLoading;
@override final  String? error;
@override@JsonKey() final  String searchQuery;

/// Create a copy of CamerasState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CamerasStateCopyWith<_CamerasState> get copyWith => __$CamerasStateCopyWithImpl<_CamerasState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CamerasState&&const DeepCollectionEquality().equals(other._cameras, _cameras)&&const DeepCollectionEquality().equals(other._filteredCameras, _filteredCameras)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cameras),const DeepCollectionEquality().hash(_filteredCameras),isLoading,error,searchQuery);

@override
String toString() {
  return 'CamerasState(cameras: $cameras, filteredCameras: $filteredCameras, isLoading: $isLoading, error: $error, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class _$CamerasStateCopyWith<$Res> implements $CamerasStateCopyWith<$Res> {
  factory _$CamerasStateCopyWith(_CamerasState value, $Res Function(_CamerasState) _then) = __$CamerasStateCopyWithImpl;
@override @useResult
$Res call({
 List<CameraModel> cameras, List<CameraModel> filteredCameras, bool isLoading, String? error, String searchQuery
});




}
/// @nodoc
class __$CamerasStateCopyWithImpl<$Res>
    implements _$CamerasStateCopyWith<$Res> {
  __$CamerasStateCopyWithImpl(this._self, this._then);

  final _CamerasState _self;
  final $Res Function(_CamerasState) _then;

/// Create a copy of CamerasState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cameras = null,Object? filteredCameras = null,Object? isLoading = null,Object? error = freezed,Object? searchQuery = null,}) {
  return _then(_CamerasState(
cameras: null == cameras ? _self._cameras : cameras // ignore: cast_nullable_to_non_nullable
as List<CameraModel>,filteredCameras: null == filteredCameras ? _self._filteredCameras : filteredCameras // ignore: cast_nullable_to_non_nullable
as List<CameraModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
