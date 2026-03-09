// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_ai_health_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetAiHealthResponseEntity {

 double get avgConfidence; int get sampleCount; double? get systemCpuPct; double? get inferenceLatencyMs;
/// Create a copy of GetAiHealthResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetAiHealthResponseEntityCopyWith<GetAiHealthResponseEntity> get copyWith => _$GetAiHealthResponseEntityCopyWithImpl<GetAiHealthResponseEntity>(this as GetAiHealthResponseEntity, _$identity);

  /// Serializes this GetAiHealthResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetAiHealthResponseEntity&&(identical(other.avgConfidence, avgConfidence) || other.avgConfidence == avgConfidence)&&(identical(other.sampleCount, sampleCount) || other.sampleCount == sampleCount)&&(identical(other.systemCpuPct, systemCpuPct) || other.systemCpuPct == systemCpuPct)&&(identical(other.inferenceLatencyMs, inferenceLatencyMs) || other.inferenceLatencyMs == inferenceLatencyMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,avgConfidence,sampleCount,systemCpuPct,inferenceLatencyMs);

@override
String toString() {
  return 'GetAiHealthResponseEntity(avgConfidence: $avgConfidence, sampleCount: $sampleCount, systemCpuPct: $systemCpuPct, inferenceLatencyMs: $inferenceLatencyMs)';
}


}

/// @nodoc
abstract mixin class $GetAiHealthResponseEntityCopyWith<$Res>  {
  factory $GetAiHealthResponseEntityCopyWith(GetAiHealthResponseEntity value, $Res Function(GetAiHealthResponseEntity) _then) = _$GetAiHealthResponseEntityCopyWithImpl;
@useResult
$Res call({
 double avgConfidence, int sampleCount, double? systemCpuPct, double? inferenceLatencyMs
});




}
/// @nodoc
class _$GetAiHealthResponseEntityCopyWithImpl<$Res>
    implements $GetAiHealthResponseEntityCopyWith<$Res> {
  _$GetAiHealthResponseEntityCopyWithImpl(this._self, this._then);

  final GetAiHealthResponseEntity _self;
  final $Res Function(GetAiHealthResponseEntity) _then;

/// Create a copy of GetAiHealthResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? avgConfidence = null,Object? sampleCount = null,Object? systemCpuPct = freezed,Object? inferenceLatencyMs = freezed,}) {
  return _then(_self.copyWith(
avgConfidence: null == avgConfidence ? _self.avgConfidence : avgConfidence // ignore: cast_nullable_to_non_nullable
as double,sampleCount: null == sampleCount ? _self.sampleCount : sampleCount // ignore: cast_nullable_to_non_nullable
as int,systemCpuPct: freezed == systemCpuPct ? _self.systemCpuPct : systemCpuPct // ignore: cast_nullable_to_non_nullable
as double?,inferenceLatencyMs: freezed == inferenceLatencyMs ? _self.inferenceLatencyMs : inferenceLatencyMs // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [GetAiHealthResponseEntity].
extension GetAiHealthResponseEntityPatterns on GetAiHealthResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetAiHealthResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetAiHealthResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetAiHealthResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _GetAiHealthResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetAiHealthResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GetAiHealthResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double avgConfidence,  int sampleCount,  double? systemCpuPct,  double? inferenceLatencyMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetAiHealthResponseEntity() when $default != null:
return $default(_that.avgConfidence,_that.sampleCount,_that.systemCpuPct,_that.inferenceLatencyMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double avgConfidence,  int sampleCount,  double? systemCpuPct,  double? inferenceLatencyMs)  $default,) {final _that = this;
switch (_that) {
case _GetAiHealthResponseEntity():
return $default(_that.avgConfidence,_that.sampleCount,_that.systemCpuPct,_that.inferenceLatencyMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double avgConfidence,  int sampleCount,  double? systemCpuPct,  double? inferenceLatencyMs)?  $default,) {final _that = this;
switch (_that) {
case _GetAiHealthResponseEntity() when $default != null:
return $default(_that.avgConfidence,_that.sampleCount,_that.systemCpuPct,_that.inferenceLatencyMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetAiHealthResponseEntity implements GetAiHealthResponseEntity {
  const _GetAiHealthResponseEntity({required this.avgConfidence, required this.sampleCount, this.systemCpuPct, this.inferenceLatencyMs});
  factory _GetAiHealthResponseEntity.fromJson(Map<String, dynamic> json) => _$GetAiHealthResponseEntityFromJson(json);

@override final  double avgConfidence;
@override final  int sampleCount;
@override final  double? systemCpuPct;
@override final  double? inferenceLatencyMs;

/// Create a copy of GetAiHealthResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetAiHealthResponseEntityCopyWith<_GetAiHealthResponseEntity> get copyWith => __$GetAiHealthResponseEntityCopyWithImpl<_GetAiHealthResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetAiHealthResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetAiHealthResponseEntity&&(identical(other.avgConfidence, avgConfidence) || other.avgConfidence == avgConfidence)&&(identical(other.sampleCount, sampleCount) || other.sampleCount == sampleCount)&&(identical(other.systemCpuPct, systemCpuPct) || other.systemCpuPct == systemCpuPct)&&(identical(other.inferenceLatencyMs, inferenceLatencyMs) || other.inferenceLatencyMs == inferenceLatencyMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,avgConfidence,sampleCount,systemCpuPct,inferenceLatencyMs);

@override
String toString() {
  return 'GetAiHealthResponseEntity(avgConfidence: $avgConfidence, sampleCount: $sampleCount, systemCpuPct: $systemCpuPct, inferenceLatencyMs: $inferenceLatencyMs)';
}


}

/// @nodoc
abstract mixin class _$GetAiHealthResponseEntityCopyWith<$Res> implements $GetAiHealthResponseEntityCopyWith<$Res> {
  factory _$GetAiHealthResponseEntityCopyWith(_GetAiHealthResponseEntity value, $Res Function(_GetAiHealthResponseEntity) _then) = __$GetAiHealthResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 double avgConfidence, int sampleCount, double? systemCpuPct, double? inferenceLatencyMs
});




}
/// @nodoc
class __$GetAiHealthResponseEntityCopyWithImpl<$Res>
    implements _$GetAiHealthResponseEntityCopyWith<$Res> {
  __$GetAiHealthResponseEntityCopyWithImpl(this._self, this._then);

  final _GetAiHealthResponseEntity _self;
  final $Res Function(_GetAiHealthResponseEntity) _then;

/// Create a copy of GetAiHealthResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? avgConfidence = null,Object? sampleCount = null,Object? systemCpuPct = freezed,Object? inferenceLatencyMs = freezed,}) {
  return _then(_GetAiHealthResponseEntity(
avgConfidence: null == avgConfidence ? _self.avgConfidence : avgConfidence // ignore: cast_nullable_to_non_nullable
as double,sampleCount: null == sampleCount ? _self.sampleCount : sampleCount // ignore: cast_nullable_to_non_nullable
as int,systemCpuPct: freezed == systemCpuPct ? _self.systemCpuPct : systemCpuPct // ignore: cast_nullable_to_non_nullable
as double?,inferenceLatencyMs: freezed == inferenceLatencyMs ? _self.inferenceLatencyMs : inferenceLatencyMs // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
