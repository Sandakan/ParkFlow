// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_action_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaymentActionState {

 bool get isLoading; AppException? get error;
/// Create a copy of PaymentActionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentActionStateCopyWith<PaymentActionState> get copyWith => _$PaymentActionStateCopyWithImpl<PaymentActionState>(this as PaymentActionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentActionState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error);

@override
String toString() {
  return 'PaymentActionState(isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $PaymentActionStateCopyWith<$Res>  {
  factory $PaymentActionStateCopyWith(PaymentActionState value, $Res Function(PaymentActionState) _then) = _$PaymentActionStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, AppException? error
});




}
/// @nodoc
class _$PaymentActionStateCopyWithImpl<$Res>
    implements $PaymentActionStateCopyWith<$Res> {
  _$PaymentActionStateCopyWithImpl(this._self, this._then);

  final PaymentActionState _self;
  final $Res Function(PaymentActionState) _then;

/// Create a copy of PaymentActionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppException?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentActionState].
extension PaymentActionStatePatterns on PaymentActionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentActionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentActionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentActionState value)  $default,){
final _that = this;
switch (_that) {
case _PaymentActionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentActionState value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentActionState() when $default != null:
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
case _PaymentActionState() when $default != null:
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
case _PaymentActionState():
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
case _PaymentActionState() when $default != null:
return $default(_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _PaymentActionState implements PaymentActionState {
  const _PaymentActionState({this.isLoading = false, this.error});
  

@override@JsonKey() final  bool isLoading;
@override final  AppException? error;

/// Create a copy of PaymentActionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentActionStateCopyWith<_PaymentActionState> get copyWith => __$PaymentActionStateCopyWithImpl<_PaymentActionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentActionState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error);

@override
String toString() {
  return 'PaymentActionState(isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$PaymentActionStateCopyWith<$Res> implements $PaymentActionStateCopyWith<$Res> {
  factory _$PaymentActionStateCopyWith(_PaymentActionState value, $Res Function(_PaymentActionState) _then) = __$PaymentActionStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, AppException? error
});




}
/// @nodoc
class __$PaymentActionStateCopyWithImpl<$Res>
    implements _$PaymentActionStateCopyWith<$Res> {
  __$PaymentActionStateCopyWithImpl(this._self, this._then);

  final _PaymentActionState _self;
  final $Res Function(_PaymentActionState) _then;

/// Create a copy of PaymentActionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? error = freezed,}) {
  return _then(_PaymentActionState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppException?,
  ));
}


}

// dart format on
