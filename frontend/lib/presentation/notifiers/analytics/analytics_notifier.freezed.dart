// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analytics_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AnalyticsState {

 GetAnalyticsOverviewResponseEntity? get overview; GetOccupancyTrendResponseEntity? get trend; GetAiHealthResponseEntity? get aiHealth; String get selectedPeriod; bool get isLoadingOverview; bool get isLoadingTrend; bool get isLoadingAiHealth; String? get overviewError; String? get trendError; String? get aiHealthError;
/// Create a copy of AnalyticsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnalyticsStateCopyWith<AnalyticsState> get copyWith => _$AnalyticsStateCopyWithImpl<AnalyticsState>(this as AnalyticsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnalyticsState&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.trend, trend) || other.trend == trend)&&(identical(other.aiHealth, aiHealth) || other.aiHealth == aiHealth)&&(identical(other.selectedPeriod, selectedPeriod) || other.selectedPeriod == selectedPeriod)&&(identical(other.isLoadingOverview, isLoadingOverview) || other.isLoadingOverview == isLoadingOverview)&&(identical(other.isLoadingTrend, isLoadingTrend) || other.isLoadingTrend == isLoadingTrend)&&(identical(other.isLoadingAiHealth, isLoadingAiHealth) || other.isLoadingAiHealth == isLoadingAiHealth)&&(identical(other.overviewError, overviewError) || other.overviewError == overviewError)&&(identical(other.trendError, trendError) || other.trendError == trendError)&&(identical(other.aiHealthError, aiHealthError) || other.aiHealthError == aiHealthError));
}


@override
int get hashCode => Object.hash(runtimeType,overview,trend,aiHealth,selectedPeriod,isLoadingOverview,isLoadingTrend,isLoadingAiHealth,overviewError,trendError,aiHealthError);

@override
String toString() {
  return 'AnalyticsState(overview: $overview, trend: $trend, aiHealth: $aiHealth, selectedPeriod: $selectedPeriod, isLoadingOverview: $isLoadingOverview, isLoadingTrend: $isLoadingTrend, isLoadingAiHealth: $isLoadingAiHealth, overviewError: $overviewError, trendError: $trendError, aiHealthError: $aiHealthError)';
}


}

/// @nodoc
abstract mixin class $AnalyticsStateCopyWith<$Res>  {
  factory $AnalyticsStateCopyWith(AnalyticsState value, $Res Function(AnalyticsState) _then) = _$AnalyticsStateCopyWithImpl;
@useResult
$Res call({
 GetAnalyticsOverviewResponseEntity? overview, GetOccupancyTrendResponseEntity? trend, GetAiHealthResponseEntity? aiHealth, String selectedPeriod, bool isLoadingOverview, bool isLoadingTrend, bool isLoadingAiHealth, String? overviewError, String? trendError, String? aiHealthError
});


$GetAnalyticsOverviewResponseEntityCopyWith<$Res>? get overview;$GetOccupancyTrendResponseEntityCopyWith<$Res>? get trend;$GetAiHealthResponseEntityCopyWith<$Res>? get aiHealth;

}
/// @nodoc
class _$AnalyticsStateCopyWithImpl<$Res>
    implements $AnalyticsStateCopyWith<$Res> {
  _$AnalyticsStateCopyWithImpl(this._self, this._then);

  final AnalyticsState _self;
  final $Res Function(AnalyticsState) _then;

/// Create a copy of AnalyticsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? overview = freezed,Object? trend = freezed,Object? aiHealth = freezed,Object? selectedPeriod = null,Object? isLoadingOverview = null,Object? isLoadingTrend = null,Object? isLoadingAiHealth = null,Object? overviewError = freezed,Object? trendError = freezed,Object? aiHealthError = freezed,}) {
  return _then(_self.copyWith(
overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as GetAnalyticsOverviewResponseEntity?,trend: freezed == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as GetOccupancyTrendResponseEntity?,aiHealth: freezed == aiHealth ? _self.aiHealth : aiHealth // ignore: cast_nullable_to_non_nullable
as GetAiHealthResponseEntity?,selectedPeriod: null == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as String,isLoadingOverview: null == isLoadingOverview ? _self.isLoadingOverview : isLoadingOverview // ignore: cast_nullable_to_non_nullable
as bool,isLoadingTrend: null == isLoadingTrend ? _self.isLoadingTrend : isLoadingTrend // ignore: cast_nullable_to_non_nullable
as bool,isLoadingAiHealth: null == isLoadingAiHealth ? _self.isLoadingAiHealth : isLoadingAiHealth // ignore: cast_nullable_to_non_nullable
as bool,overviewError: freezed == overviewError ? _self.overviewError : overviewError // ignore: cast_nullable_to_non_nullable
as String?,trendError: freezed == trendError ? _self.trendError : trendError // ignore: cast_nullable_to_non_nullable
as String?,aiHealthError: freezed == aiHealthError ? _self.aiHealthError : aiHealthError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AnalyticsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GetAnalyticsOverviewResponseEntityCopyWith<$Res>? get overview {
    if (_self.overview == null) {
    return null;
  }

  return $GetAnalyticsOverviewResponseEntityCopyWith<$Res>(_self.overview!, (value) {
    return _then(_self.copyWith(overview: value));
  });
}/// Create a copy of AnalyticsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GetOccupancyTrendResponseEntityCopyWith<$Res>? get trend {
    if (_self.trend == null) {
    return null;
  }

  return $GetOccupancyTrendResponseEntityCopyWith<$Res>(_self.trend!, (value) {
    return _then(_self.copyWith(trend: value));
  });
}/// Create a copy of AnalyticsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GetAiHealthResponseEntityCopyWith<$Res>? get aiHealth {
    if (_self.aiHealth == null) {
    return null;
  }

  return $GetAiHealthResponseEntityCopyWith<$Res>(_self.aiHealth!, (value) {
    return _then(_self.copyWith(aiHealth: value));
  });
}
}


/// Adds pattern-matching-related methods to [AnalyticsState].
extension AnalyticsStatePatterns on AnalyticsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnalyticsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnalyticsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnalyticsState value)  $default,){
final _that = this;
switch (_that) {
case _AnalyticsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnalyticsState value)?  $default,){
final _that = this;
switch (_that) {
case _AnalyticsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GetAnalyticsOverviewResponseEntity? overview,  GetOccupancyTrendResponseEntity? trend,  GetAiHealthResponseEntity? aiHealth,  String selectedPeriod,  bool isLoadingOverview,  bool isLoadingTrend,  bool isLoadingAiHealth,  String? overviewError,  String? trendError,  String? aiHealthError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnalyticsState() when $default != null:
return $default(_that.overview,_that.trend,_that.aiHealth,_that.selectedPeriod,_that.isLoadingOverview,_that.isLoadingTrend,_that.isLoadingAiHealth,_that.overviewError,_that.trendError,_that.aiHealthError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GetAnalyticsOverviewResponseEntity? overview,  GetOccupancyTrendResponseEntity? trend,  GetAiHealthResponseEntity? aiHealth,  String selectedPeriod,  bool isLoadingOverview,  bool isLoadingTrend,  bool isLoadingAiHealth,  String? overviewError,  String? trendError,  String? aiHealthError)  $default,) {final _that = this;
switch (_that) {
case _AnalyticsState():
return $default(_that.overview,_that.trend,_that.aiHealth,_that.selectedPeriod,_that.isLoadingOverview,_that.isLoadingTrend,_that.isLoadingAiHealth,_that.overviewError,_that.trendError,_that.aiHealthError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GetAnalyticsOverviewResponseEntity? overview,  GetOccupancyTrendResponseEntity? trend,  GetAiHealthResponseEntity? aiHealth,  String selectedPeriod,  bool isLoadingOverview,  bool isLoadingTrend,  bool isLoadingAiHealth,  String? overviewError,  String? trendError,  String? aiHealthError)?  $default,) {final _that = this;
switch (_that) {
case _AnalyticsState() when $default != null:
return $default(_that.overview,_that.trend,_that.aiHealth,_that.selectedPeriod,_that.isLoadingOverview,_that.isLoadingTrend,_that.isLoadingAiHealth,_that.overviewError,_that.trendError,_that.aiHealthError);case _:
  return null;

}
}

}

/// @nodoc


class _AnalyticsState implements AnalyticsState {
  const _AnalyticsState({this.overview, this.trend, this.aiHealth, this.selectedPeriod = '24h', this.isLoadingOverview = true, this.isLoadingTrend = true, this.isLoadingAiHealth = true, this.overviewError, this.trendError, this.aiHealthError});
  

@override final  GetAnalyticsOverviewResponseEntity? overview;
@override final  GetOccupancyTrendResponseEntity? trend;
@override final  GetAiHealthResponseEntity? aiHealth;
@override@JsonKey() final  String selectedPeriod;
@override@JsonKey() final  bool isLoadingOverview;
@override@JsonKey() final  bool isLoadingTrend;
@override@JsonKey() final  bool isLoadingAiHealth;
@override final  String? overviewError;
@override final  String? trendError;
@override final  String? aiHealthError;

/// Create a copy of AnalyticsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnalyticsStateCopyWith<_AnalyticsState> get copyWith => __$AnalyticsStateCopyWithImpl<_AnalyticsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnalyticsState&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.trend, trend) || other.trend == trend)&&(identical(other.aiHealth, aiHealth) || other.aiHealth == aiHealth)&&(identical(other.selectedPeriod, selectedPeriod) || other.selectedPeriod == selectedPeriod)&&(identical(other.isLoadingOverview, isLoadingOverview) || other.isLoadingOverview == isLoadingOverview)&&(identical(other.isLoadingTrend, isLoadingTrend) || other.isLoadingTrend == isLoadingTrend)&&(identical(other.isLoadingAiHealth, isLoadingAiHealth) || other.isLoadingAiHealth == isLoadingAiHealth)&&(identical(other.overviewError, overviewError) || other.overviewError == overviewError)&&(identical(other.trendError, trendError) || other.trendError == trendError)&&(identical(other.aiHealthError, aiHealthError) || other.aiHealthError == aiHealthError));
}


@override
int get hashCode => Object.hash(runtimeType,overview,trend,aiHealth,selectedPeriod,isLoadingOverview,isLoadingTrend,isLoadingAiHealth,overviewError,trendError,aiHealthError);

@override
String toString() {
  return 'AnalyticsState(overview: $overview, trend: $trend, aiHealth: $aiHealth, selectedPeriod: $selectedPeriod, isLoadingOverview: $isLoadingOverview, isLoadingTrend: $isLoadingTrend, isLoadingAiHealth: $isLoadingAiHealth, overviewError: $overviewError, trendError: $trendError, aiHealthError: $aiHealthError)';
}


}

/// @nodoc
abstract mixin class _$AnalyticsStateCopyWith<$Res> implements $AnalyticsStateCopyWith<$Res> {
  factory _$AnalyticsStateCopyWith(_AnalyticsState value, $Res Function(_AnalyticsState) _then) = __$AnalyticsStateCopyWithImpl;
@override @useResult
$Res call({
 GetAnalyticsOverviewResponseEntity? overview, GetOccupancyTrendResponseEntity? trend, GetAiHealthResponseEntity? aiHealth, String selectedPeriod, bool isLoadingOverview, bool isLoadingTrend, bool isLoadingAiHealth, String? overviewError, String? trendError, String? aiHealthError
});


@override $GetAnalyticsOverviewResponseEntityCopyWith<$Res>? get overview;@override $GetOccupancyTrendResponseEntityCopyWith<$Res>? get trend;@override $GetAiHealthResponseEntityCopyWith<$Res>? get aiHealth;

}
/// @nodoc
class __$AnalyticsStateCopyWithImpl<$Res>
    implements _$AnalyticsStateCopyWith<$Res> {
  __$AnalyticsStateCopyWithImpl(this._self, this._then);

  final _AnalyticsState _self;
  final $Res Function(_AnalyticsState) _then;

/// Create a copy of AnalyticsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? overview = freezed,Object? trend = freezed,Object? aiHealth = freezed,Object? selectedPeriod = null,Object? isLoadingOverview = null,Object? isLoadingTrend = null,Object? isLoadingAiHealth = null,Object? overviewError = freezed,Object? trendError = freezed,Object? aiHealthError = freezed,}) {
  return _then(_AnalyticsState(
overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as GetAnalyticsOverviewResponseEntity?,trend: freezed == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as GetOccupancyTrendResponseEntity?,aiHealth: freezed == aiHealth ? _self.aiHealth : aiHealth // ignore: cast_nullable_to_non_nullable
as GetAiHealthResponseEntity?,selectedPeriod: null == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as String,isLoadingOverview: null == isLoadingOverview ? _self.isLoadingOverview : isLoadingOverview // ignore: cast_nullable_to_non_nullable
as bool,isLoadingTrend: null == isLoadingTrend ? _self.isLoadingTrend : isLoadingTrend // ignore: cast_nullable_to_non_nullable
as bool,isLoadingAiHealth: null == isLoadingAiHealth ? _self.isLoadingAiHealth : isLoadingAiHealth // ignore: cast_nullable_to_non_nullable
as bool,overviewError: freezed == overviewError ? _self.overviewError : overviewError // ignore: cast_nullable_to_non_nullable
as String?,trendError: freezed == trendError ? _self.trendError : trendError // ignore: cast_nullable_to_non_nullable
as String?,aiHealthError: freezed == aiHealthError ? _self.aiHealthError : aiHealthError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AnalyticsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GetAnalyticsOverviewResponseEntityCopyWith<$Res>? get overview {
    if (_self.overview == null) {
    return null;
  }

  return $GetAnalyticsOverviewResponseEntityCopyWith<$Res>(_self.overview!, (value) {
    return _then(_self.copyWith(overview: value));
  });
}/// Create a copy of AnalyticsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GetOccupancyTrendResponseEntityCopyWith<$Res>? get trend {
    if (_self.trend == null) {
    return null;
  }

  return $GetOccupancyTrendResponseEntityCopyWith<$Res>(_self.trend!, (value) {
    return _then(_self.copyWith(trend: value));
  });
}/// Create a copy of AnalyticsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GetAiHealthResponseEntityCopyWith<$Res>? get aiHealth {
    if (_self.aiHealth == null) {
    return null;
  }

  return $GetAiHealthResponseEntityCopyWith<$Res>(_self.aiHealth!, (value) {
    return _then(_self.copyWith(aiHealth: value));
  });
}
}

// dart format on
