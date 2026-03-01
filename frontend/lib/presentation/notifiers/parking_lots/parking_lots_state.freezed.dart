// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parking_lots_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ParkingLotsState {

 List<ParkingLotModel> get lots; bool get isLoading; String? get error; String get searchQuery;
/// Create a copy of ParkingLotsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParkingLotsStateCopyWith<ParkingLotsState> get copyWith => _$ParkingLotsStateCopyWithImpl<ParkingLotsState>(this as ParkingLotsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParkingLotsState&&const DeepCollectionEquality().equals(other.lots, lots)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(lots),isLoading,error,searchQuery);

@override
String toString() {
  return 'ParkingLotsState(lots: $lots, isLoading: $isLoading, error: $error, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class $ParkingLotsStateCopyWith<$Res>  {
  factory $ParkingLotsStateCopyWith(ParkingLotsState value, $Res Function(ParkingLotsState) _then) = _$ParkingLotsStateCopyWithImpl;
@useResult
$Res call({
 List<ParkingLotModel> lots, bool isLoading, String? error, String searchQuery
});




}
/// @nodoc
class _$ParkingLotsStateCopyWithImpl<$Res>
    implements $ParkingLotsStateCopyWith<$Res> {
  _$ParkingLotsStateCopyWithImpl(this._self, this._then);

  final ParkingLotsState _self;
  final $Res Function(ParkingLotsState) _then;

/// Create a copy of ParkingLotsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lots = null,Object? isLoading = null,Object? error = freezed,Object? searchQuery = null,}) {
  return _then(_self.copyWith(
lots: null == lots ? _self.lots : lots // ignore: cast_nullable_to_non_nullable
as List<ParkingLotModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ParkingLotsState].
extension ParkingLotsStatePatterns on ParkingLotsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParkingLotsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParkingLotsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParkingLotsState value)  $default,){
final _that = this;
switch (_that) {
case _ParkingLotsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParkingLotsState value)?  $default,){
final _that = this;
switch (_that) {
case _ParkingLotsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ParkingLotModel> lots,  bool isLoading,  String? error,  String searchQuery)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParkingLotsState() when $default != null:
return $default(_that.lots,_that.isLoading,_that.error,_that.searchQuery);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ParkingLotModel> lots,  bool isLoading,  String? error,  String searchQuery)  $default,) {final _that = this;
switch (_that) {
case _ParkingLotsState():
return $default(_that.lots,_that.isLoading,_that.error,_that.searchQuery);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ParkingLotModel> lots,  bool isLoading,  String? error,  String searchQuery)?  $default,) {final _that = this;
switch (_that) {
case _ParkingLotsState() when $default != null:
return $default(_that.lots,_that.isLoading,_that.error,_that.searchQuery);case _:
  return null;

}
}

}

/// @nodoc


class _ParkingLotsState implements ParkingLotsState {
  const _ParkingLotsState({final  List<ParkingLotModel> lots = const [], this.isLoading = true, this.error, this.searchQuery = ''}): _lots = lots;
  

 final  List<ParkingLotModel> _lots;
@override@JsonKey() List<ParkingLotModel> get lots {
  if (_lots is EqualUnmodifiableListView) return _lots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lots);
}

@override@JsonKey() final  bool isLoading;
@override final  String? error;
@override@JsonKey() final  String searchQuery;

/// Create a copy of ParkingLotsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParkingLotsStateCopyWith<_ParkingLotsState> get copyWith => __$ParkingLotsStateCopyWithImpl<_ParkingLotsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParkingLotsState&&const DeepCollectionEquality().equals(other._lots, _lots)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_lots),isLoading,error,searchQuery);

@override
String toString() {
  return 'ParkingLotsState(lots: $lots, isLoading: $isLoading, error: $error, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class _$ParkingLotsStateCopyWith<$Res> implements $ParkingLotsStateCopyWith<$Res> {
  factory _$ParkingLotsStateCopyWith(_ParkingLotsState value, $Res Function(_ParkingLotsState) _then) = __$ParkingLotsStateCopyWithImpl;
@override @useResult
$Res call({
 List<ParkingLotModel> lots, bool isLoading, String? error, String searchQuery
});




}
/// @nodoc
class __$ParkingLotsStateCopyWithImpl<$Res>
    implements _$ParkingLotsStateCopyWith<$Res> {
  __$ParkingLotsStateCopyWithImpl(this._self, this._then);

  final _ParkingLotsState _self;
  final $Res Function(_ParkingLotsState) _then;

/// Create a copy of ParkingLotsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lots = null,Object? isLoading = null,Object? error = freezed,Object? searchQuery = null,}) {
  return _then(_ParkingLotsState(
lots: null == lots ? _self._lots : lots // ignore: cast_nullable_to_non_nullable
as List<ParkingLotModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
