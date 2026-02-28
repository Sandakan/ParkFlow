// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_analytics_overview_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetAnalyticsOverviewResponseEntity {

 int get totalCapacity; int get totalSlotsCount; int get currentOccupied; int get currentVacant; double get occupancyRate; int get activeStreamCount; int get totalCameraCount; double get streamHealthPct; double get avgDwellTimeMinutes; double get turnoverRateToday; double get revenueToday; double get revenueMonth;
/// Create a copy of GetAnalyticsOverviewResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetAnalyticsOverviewResponseEntityCopyWith<GetAnalyticsOverviewResponseEntity> get copyWith => _$GetAnalyticsOverviewResponseEntityCopyWithImpl<GetAnalyticsOverviewResponseEntity>(this as GetAnalyticsOverviewResponseEntity, _$identity);

  /// Serializes this GetAnalyticsOverviewResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetAnalyticsOverviewResponseEntity&&(identical(other.totalCapacity, totalCapacity) || other.totalCapacity == totalCapacity)&&(identical(other.totalSlotsCount, totalSlotsCount) || other.totalSlotsCount == totalSlotsCount)&&(identical(other.currentOccupied, currentOccupied) || other.currentOccupied == currentOccupied)&&(identical(other.currentVacant, currentVacant) || other.currentVacant == currentVacant)&&(identical(other.occupancyRate, occupancyRate) || other.occupancyRate == occupancyRate)&&(identical(other.activeStreamCount, activeStreamCount) || other.activeStreamCount == activeStreamCount)&&(identical(other.totalCameraCount, totalCameraCount) || other.totalCameraCount == totalCameraCount)&&(identical(other.streamHealthPct, streamHealthPct) || other.streamHealthPct == streamHealthPct)&&(identical(other.avgDwellTimeMinutes, avgDwellTimeMinutes) || other.avgDwellTimeMinutes == avgDwellTimeMinutes)&&(identical(other.turnoverRateToday, turnoverRateToday) || other.turnoverRateToday == turnoverRateToday)&&(identical(other.revenueToday, revenueToday) || other.revenueToday == revenueToday)&&(identical(other.revenueMonth, revenueMonth) || other.revenueMonth == revenueMonth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalCapacity,totalSlotsCount,currentOccupied,currentVacant,occupancyRate,activeStreamCount,totalCameraCount,streamHealthPct,avgDwellTimeMinutes,turnoverRateToday,revenueToday,revenueMonth);

@override
String toString() {
  return 'GetAnalyticsOverviewResponseEntity(totalCapacity: $totalCapacity, totalSlotsCount: $totalSlotsCount, currentOccupied: $currentOccupied, currentVacant: $currentVacant, occupancyRate: $occupancyRate, activeStreamCount: $activeStreamCount, totalCameraCount: $totalCameraCount, streamHealthPct: $streamHealthPct, avgDwellTimeMinutes: $avgDwellTimeMinutes, turnoverRateToday: $turnoverRateToday, revenueToday: $revenueToday, revenueMonth: $revenueMonth)';
}


}

/// @nodoc
abstract mixin class $GetAnalyticsOverviewResponseEntityCopyWith<$Res>  {
  factory $GetAnalyticsOverviewResponseEntityCopyWith(GetAnalyticsOverviewResponseEntity value, $Res Function(GetAnalyticsOverviewResponseEntity) _then) = _$GetAnalyticsOverviewResponseEntityCopyWithImpl;
@useResult
$Res call({
 int totalCapacity, int totalSlotsCount, int currentOccupied, int currentVacant, double occupancyRate, int activeStreamCount, int totalCameraCount, double streamHealthPct, double avgDwellTimeMinutes, double turnoverRateToday, double revenueToday, double revenueMonth
});




}
/// @nodoc
class _$GetAnalyticsOverviewResponseEntityCopyWithImpl<$Res>
    implements $GetAnalyticsOverviewResponseEntityCopyWith<$Res> {
  _$GetAnalyticsOverviewResponseEntityCopyWithImpl(this._self, this._then);

  final GetAnalyticsOverviewResponseEntity _self;
  final $Res Function(GetAnalyticsOverviewResponseEntity) _then;

/// Create a copy of GetAnalyticsOverviewResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalCapacity = null,Object? totalSlotsCount = null,Object? currentOccupied = null,Object? currentVacant = null,Object? occupancyRate = null,Object? activeStreamCount = null,Object? totalCameraCount = null,Object? streamHealthPct = null,Object? avgDwellTimeMinutes = null,Object? turnoverRateToday = null,Object? revenueToday = null,Object? revenueMonth = null,}) {
  return _then(_self.copyWith(
totalCapacity: null == totalCapacity ? _self.totalCapacity : totalCapacity // ignore: cast_nullable_to_non_nullable
as int,totalSlotsCount: null == totalSlotsCount ? _self.totalSlotsCount : totalSlotsCount // ignore: cast_nullable_to_non_nullable
as int,currentOccupied: null == currentOccupied ? _self.currentOccupied : currentOccupied // ignore: cast_nullable_to_non_nullable
as int,currentVacant: null == currentVacant ? _self.currentVacant : currentVacant // ignore: cast_nullable_to_non_nullable
as int,occupancyRate: null == occupancyRate ? _self.occupancyRate : occupancyRate // ignore: cast_nullable_to_non_nullable
as double,activeStreamCount: null == activeStreamCount ? _self.activeStreamCount : activeStreamCount // ignore: cast_nullable_to_non_nullable
as int,totalCameraCount: null == totalCameraCount ? _self.totalCameraCount : totalCameraCount // ignore: cast_nullable_to_non_nullable
as int,streamHealthPct: null == streamHealthPct ? _self.streamHealthPct : streamHealthPct // ignore: cast_nullable_to_non_nullable
as double,avgDwellTimeMinutes: null == avgDwellTimeMinutes ? _self.avgDwellTimeMinutes : avgDwellTimeMinutes // ignore: cast_nullable_to_non_nullable
as double,turnoverRateToday: null == turnoverRateToday ? _self.turnoverRateToday : turnoverRateToday // ignore: cast_nullable_to_non_nullable
as double,revenueToday: null == revenueToday ? _self.revenueToday : revenueToday // ignore: cast_nullable_to_non_nullable
as double,revenueMonth: null == revenueMonth ? _self.revenueMonth : revenueMonth // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [GetAnalyticsOverviewResponseEntity].
extension GetAnalyticsOverviewResponseEntityPatterns on GetAnalyticsOverviewResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetAnalyticsOverviewResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetAnalyticsOverviewResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetAnalyticsOverviewResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _GetAnalyticsOverviewResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetAnalyticsOverviewResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GetAnalyticsOverviewResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalCapacity,  int totalSlotsCount,  int currentOccupied,  int currentVacant,  double occupancyRate,  int activeStreamCount,  int totalCameraCount,  double streamHealthPct,  double avgDwellTimeMinutes,  double turnoverRateToday,  double revenueToday,  double revenueMonth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetAnalyticsOverviewResponseEntity() when $default != null:
return $default(_that.totalCapacity,_that.totalSlotsCount,_that.currentOccupied,_that.currentVacant,_that.occupancyRate,_that.activeStreamCount,_that.totalCameraCount,_that.streamHealthPct,_that.avgDwellTimeMinutes,_that.turnoverRateToday,_that.revenueToday,_that.revenueMonth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalCapacity,  int totalSlotsCount,  int currentOccupied,  int currentVacant,  double occupancyRate,  int activeStreamCount,  int totalCameraCount,  double streamHealthPct,  double avgDwellTimeMinutes,  double turnoverRateToday,  double revenueToday,  double revenueMonth)  $default,) {final _that = this;
switch (_that) {
case _GetAnalyticsOverviewResponseEntity():
return $default(_that.totalCapacity,_that.totalSlotsCount,_that.currentOccupied,_that.currentVacant,_that.occupancyRate,_that.activeStreamCount,_that.totalCameraCount,_that.streamHealthPct,_that.avgDwellTimeMinutes,_that.turnoverRateToday,_that.revenueToday,_that.revenueMonth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalCapacity,  int totalSlotsCount,  int currentOccupied,  int currentVacant,  double occupancyRate,  int activeStreamCount,  int totalCameraCount,  double streamHealthPct,  double avgDwellTimeMinutes,  double turnoverRateToday,  double revenueToday,  double revenueMonth)?  $default,) {final _that = this;
switch (_that) {
case _GetAnalyticsOverviewResponseEntity() when $default != null:
return $default(_that.totalCapacity,_that.totalSlotsCount,_that.currentOccupied,_that.currentVacant,_that.occupancyRate,_that.activeStreamCount,_that.totalCameraCount,_that.streamHealthPct,_that.avgDwellTimeMinutes,_that.turnoverRateToday,_that.revenueToday,_that.revenueMonth);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetAnalyticsOverviewResponseEntity implements GetAnalyticsOverviewResponseEntity {
  const _GetAnalyticsOverviewResponseEntity({required this.totalCapacity, required this.totalSlotsCount, required this.currentOccupied, required this.currentVacant, required this.occupancyRate, required this.activeStreamCount, required this.totalCameraCount, required this.streamHealthPct, required this.avgDwellTimeMinutes, required this.turnoverRateToday, required this.revenueToday, required this.revenueMonth});
  factory _GetAnalyticsOverviewResponseEntity.fromJson(Map<String, dynamic> json) => _$GetAnalyticsOverviewResponseEntityFromJson(json);

@override final  int totalCapacity;
@override final  int totalSlotsCount;
@override final  int currentOccupied;
@override final  int currentVacant;
@override final  double occupancyRate;
@override final  int activeStreamCount;
@override final  int totalCameraCount;
@override final  double streamHealthPct;
@override final  double avgDwellTimeMinutes;
@override final  double turnoverRateToday;
@override final  double revenueToday;
@override final  double revenueMonth;

/// Create a copy of GetAnalyticsOverviewResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetAnalyticsOverviewResponseEntityCopyWith<_GetAnalyticsOverviewResponseEntity> get copyWith => __$GetAnalyticsOverviewResponseEntityCopyWithImpl<_GetAnalyticsOverviewResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetAnalyticsOverviewResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetAnalyticsOverviewResponseEntity&&(identical(other.totalCapacity, totalCapacity) || other.totalCapacity == totalCapacity)&&(identical(other.totalSlotsCount, totalSlotsCount) || other.totalSlotsCount == totalSlotsCount)&&(identical(other.currentOccupied, currentOccupied) || other.currentOccupied == currentOccupied)&&(identical(other.currentVacant, currentVacant) || other.currentVacant == currentVacant)&&(identical(other.occupancyRate, occupancyRate) || other.occupancyRate == occupancyRate)&&(identical(other.activeStreamCount, activeStreamCount) || other.activeStreamCount == activeStreamCount)&&(identical(other.totalCameraCount, totalCameraCount) || other.totalCameraCount == totalCameraCount)&&(identical(other.streamHealthPct, streamHealthPct) || other.streamHealthPct == streamHealthPct)&&(identical(other.avgDwellTimeMinutes, avgDwellTimeMinutes) || other.avgDwellTimeMinutes == avgDwellTimeMinutes)&&(identical(other.turnoverRateToday, turnoverRateToday) || other.turnoverRateToday == turnoverRateToday)&&(identical(other.revenueToday, revenueToday) || other.revenueToday == revenueToday)&&(identical(other.revenueMonth, revenueMonth) || other.revenueMonth == revenueMonth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalCapacity,totalSlotsCount,currentOccupied,currentVacant,occupancyRate,activeStreamCount,totalCameraCount,streamHealthPct,avgDwellTimeMinutes,turnoverRateToday,revenueToday,revenueMonth);

@override
String toString() {
  return 'GetAnalyticsOverviewResponseEntity(totalCapacity: $totalCapacity, totalSlotsCount: $totalSlotsCount, currentOccupied: $currentOccupied, currentVacant: $currentVacant, occupancyRate: $occupancyRate, activeStreamCount: $activeStreamCount, totalCameraCount: $totalCameraCount, streamHealthPct: $streamHealthPct, avgDwellTimeMinutes: $avgDwellTimeMinutes, turnoverRateToday: $turnoverRateToday, revenueToday: $revenueToday, revenueMonth: $revenueMonth)';
}


}

/// @nodoc
abstract mixin class _$GetAnalyticsOverviewResponseEntityCopyWith<$Res> implements $GetAnalyticsOverviewResponseEntityCopyWith<$Res> {
  factory _$GetAnalyticsOverviewResponseEntityCopyWith(_GetAnalyticsOverviewResponseEntity value, $Res Function(_GetAnalyticsOverviewResponseEntity) _then) = __$GetAnalyticsOverviewResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 int totalCapacity, int totalSlotsCount, int currentOccupied, int currentVacant, double occupancyRate, int activeStreamCount, int totalCameraCount, double streamHealthPct, double avgDwellTimeMinutes, double turnoverRateToday, double revenueToday, double revenueMonth
});




}
/// @nodoc
class __$GetAnalyticsOverviewResponseEntityCopyWithImpl<$Res>
    implements _$GetAnalyticsOverviewResponseEntityCopyWith<$Res> {
  __$GetAnalyticsOverviewResponseEntityCopyWithImpl(this._self, this._then);

  final _GetAnalyticsOverviewResponseEntity _self;
  final $Res Function(_GetAnalyticsOverviewResponseEntity) _then;

/// Create a copy of GetAnalyticsOverviewResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalCapacity = null,Object? totalSlotsCount = null,Object? currentOccupied = null,Object? currentVacant = null,Object? occupancyRate = null,Object? activeStreamCount = null,Object? totalCameraCount = null,Object? streamHealthPct = null,Object? avgDwellTimeMinutes = null,Object? turnoverRateToday = null,Object? revenueToday = null,Object? revenueMonth = null,}) {
  return _then(_GetAnalyticsOverviewResponseEntity(
totalCapacity: null == totalCapacity ? _self.totalCapacity : totalCapacity // ignore: cast_nullable_to_non_nullable
as int,totalSlotsCount: null == totalSlotsCount ? _self.totalSlotsCount : totalSlotsCount // ignore: cast_nullable_to_non_nullable
as int,currentOccupied: null == currentOccupied ? _self.currentOccupied : currentOccupied // ignore: cast_nullable_to_non_nullable
as int,currentVacant: null == currentVacant ? _self.currentVacant : currentVacant // ignore: cast_nullable_to_non_nullable
as int,occupancyRate: null == occupancyRate ? _self.occupancyRate : occupancyRate // ignore: cast_nullable_to_non_nullable
as double,activeStreamCount: null == activeStreamCount ? _self.activeStreamCount : activeStreamCount // ignore: cast_nullable_to_non_nullable
as int,totalCameraCount: null == totalCameraCount ? _self.totalCameraCount : totalCameraCount // ignore: cast_nullable_to_non_nullable
as int,streamHealthPct: null == streamHealthPct ? _self.streamHealthPct : streamHealthPct // ignore: cast_nullable_to_non_nullable
as double,avgDwellTimeMinutes: null == avgDwellTimeMinutes ? _self.avgDwellTimeMinutes : avgDwellTimeMinutes // ignore: cast_nullable_to_non_nullable
as double,turnoverRateToday: null == turnoverRateToday ? _self.turnoverRateToday : turnoverRateToday // ignore: cast_nullable_to_non_nullable
as double,revenueToday: null == revenueToday ? _self.revenueToday : revenueToday // ignore: cast_nullable_to_non_nullable
as double,revenueMonth: null == revenueMonth ? _self.revenueMonth : revenueMonth // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
