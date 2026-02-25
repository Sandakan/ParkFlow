// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parking_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ParkingState {

 bool get isLoading; List<ParkingSlotModel> get slots; AppException? get error;
/// Create a copy of ParkingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParkingStateCopyWith<ParkingState> get copyWith => _$ParkingStateCopyWithImpl<ParkingState>(this as ParkingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParkingState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.slots, slots)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(slots),error);

@override
String toString() {
  return 'ParkingState(isLoading: $isLoading, slots: $slots, error: $error)';
}


}

/// @nodoc
abstract mixin class $ParkingStateCopyWith<$Res>  {
  factory $ParkingStateCopyWith(ParkingState value, $Res Function(ParkingState) _then) = _$ParkingStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<ParkingSlotModel> slots, AppException? error
});




}
/// @nodoc
class _$ParkingStateCopyWithImpl<$Res>
    implements $ParkingStateCopyWith<$Res> {
  _$ParkingStateCopyWithImpl(this._self, this._then);

  final ParkingState _self;
  final $Res Function(ParkingState) _then;

/// Create a copy of ParkingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? slots = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as List<ParkingSlotModel>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppException?,
  ));
}

}


/// Adds pattern-matching-related methods to [ParkingState].
extension ParkingStatePatterns on ParkingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParkingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParkingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParkingState value)  $default,){
final _that = this;
switch (_that) {
case _ParkingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParkingState value)?  $default,){
final _that = this;
switch (_that) {
case _ParkingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<ParkingSlotModel> slots,  AppException? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParkingState() when $default != null:
return $default(_that.isLoading,_that.slots,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<ParkingSlotModel> slots,  AppException? error)  $default,) {final _that = this;
switch (_that) {
case _ParkingState():
return $default(_that.isLoading,_that.slots,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<ParkingSlotModel> slots,  AppException? error)?  $default,) {final _that = this;
switch (_that) {
case _ParkingState() when $default != null:
return $default(_that.isLoading,_that.slots,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _ParkingState implements ParkingState {
  const _ParkingState({this.isLoading = true, final  List<ParkingSlotModel> slots = const [], this.error}): _slots = slots;
  

@override@JsonKey() final  bool isLoading;
 final  List<ParkingSlotModel> _slots;
@override@JsonKey() List<ParkingSlotModel> get slots {
  if (_slots is EqualUnmodifiableListView) return _slots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slots);
}

@override final  AppException? error;

/// Create a copy of ParkingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParkingStateCopyWith<_ParkingState> get copyWith => __$ParkingStateCopyWithImpl<_ParkingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParkingState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._slots, _slots)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_slots),error);

@override
String toString() {
  return 'ParkingState(isLoading: $isLoading, slots: $slots, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ParkingStateCopyWith<$Res> implements $ParkingStateCopyWith<$Res> {
  factory _$ParkingStateCopyWith(_ParkingState value, $Res Function(_ParkingState) _then) = __$ParkingStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<ParkingSlotModel> slots, AppException? error
});




}
/// @nodoc
class __$ParkingStateCopyWithImpl<$Res>
    implements _$ParkingStateCopyWith<$Res> {
  __$ParkingStateCopyWithImpl(this._self, this._then);

  final _ParkingState _self;
  final $Res Function(_ParkingState) _then;

/// Create a copy of ParkingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? slots = null,Object? error = freezed,}) {
  return _then(_ParkingState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,slots: null == slots ? _self._slots : slots // ignore: cast_nullable_to_non_nullable
as List<ParkingSlotModel>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppException?,
  ));
}


}

// dart format on
