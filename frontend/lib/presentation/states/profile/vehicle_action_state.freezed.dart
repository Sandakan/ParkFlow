// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_action_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VehicleActionState {

 bool get isLoading; AppException? get error;
/// Create a copy of VehicleActionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehicleActionStateCopyWith<VehicleActionState> get copyWith => _$VehicleActionStateCopyWithImpl<VehicleActionState>(this as VehicleActionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehicleActionState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error);

@override
String toString() {
  return 'VehicleActionState(isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $VehicleActionStateCopyWith<$Res>  {
  factory $VehicleActionStateCopyWith(VehicleActionState value, $Res Function(VehicleActionState) _then) = _$VehicleActionStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, AppException? error
});




}
/// @nodoc
class _$VehicleActionStateCopyWithImpl<$Res>
    implements $VehicleActionStateCopyWith<$Res> {
  _$VehicleActionStateCopyWithImpl(this._self, this._then);

  final VehicleActionState _self;
  final $Res Function(VehicleActionState) _then;

/// Create a copy of VehicleActionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppException?,
  ));
}

}


/// Adds pattern-matching-related methods to [VehicleActionState].
extension VehicleActionStatePatterns on VehicleActionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VehicleActionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VehicleActionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VehicleActionState value)  $default,){
final _that = this;
switch (_that) {
case _VehicleActionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VehicleActionState value)?  $default,){
final _that = this;
switch (_that) {
case _VehicleActionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  AppException? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VehicleActionState() when $default != null:
return $default(_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  AppException? error)  $default,) {final _that = this;
switch (_that) {
case _VehicleActionState():
return $default(_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  AppException? error)?  $default,) {final _that = this;
switch (_that) {
case _VehicleActionState() when $default != null:
return $default(_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _VehicleActionState implements VehicleActionState {
  const _VehicleActionState({this.isLoading = false, this.error});
  

@override@JsonKey() final  bool isLoading;
@override final  AppException? error;

/// Create a copy of VehicleActionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehicleActionStateCopyWith<_VehicleActionState> get copyWith => __$VehicleActionStateCopyWithImpl<_VehicleActionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleActionState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error);

@override
String toString() {
  return 'VehicleActionState(isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$VehicleActionStateCopyWith<$Res> implements $VehicleActionStateCopyWith<$Res> {
  factory _$VehicleActionStateCopyWith(_VehicleActionState value, $Res Function(_VehicleActionState) _then) = __$VehicleActionStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, AppException? error
});




}
/// @nodoc
class __$VehicleActionStateCopyWithImpl<$Res>
    implements _$VehicleActionStateCopyWith<$Res> {
  __$VehicleActionStateCopyWithImpl(this._self, this._then);

  final _VehicleActionState _self;
  final $Res Function(_VehicleActionState) _then;

/// Create a copy of VehicleActionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? error = freezed,}) {
  return _then(_VehicleActionState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppException?,
  ));
}


}

// dart format on
