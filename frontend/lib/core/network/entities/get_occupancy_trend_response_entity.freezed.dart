// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_occupancy_trend_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrendPointEntity {

 String get label; double get occupancy; double get revenue;
/// Create a copy of TrendPointEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrendPointEntityCopyWith<TrendPointEntity> get copyWith => _$TrendPointEntityCopyWithImpl<TrendPointEntity>(this as TrendPointEntity, _$identity);

  /// Serializes this TrendPointEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrendPointEntity&&(identical(other.label, label) || other.label == label)&&(identical(other.occupancy, occupancy) || other.occupancy == occupancy)&&(identical(other.revenue, revenue) || other.revenue == revenue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,occupancy,revenue);

@override
String toString() {
  return 'TrendPointEntity(label: $label, occupancy: $occupancy, revenue: $revenue)';
}


}

/// @nodoc
abstract mixin class $TrendPointEntityCopyWith<$Res>  {
  factory $TrendPointEntityCopyWith(TrendPointEntity value, $Res Function(TrendPointEntity) _then) = _$TrendPointEntityCopyWithImpl;
@useResult
$Res call({
 String label, double occupancy, double revenue
});




}
/// @nodoc
class _$TrendPointEntityCopyWithImpl<$Res>
    implements $TrendPointEntityCopyWith<$Res> {
  _$TrendPointEntityCopyWithImpl(this._self, this._then);

  final TrendPointEntity _self;
  final $Res Function(TrendPointEntity) _then;

/// Create a copy of TrendPointEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? occupancy = null,Object? revenue = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,occupancy: null == occupancy ? _self.occupancy : occupancy // ignore: cast_nullable_to_non_nullable
as double,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TrendPointEntity].
extension TrendPointEntityPatterns on TrendPointEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrendPointEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrendPointEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrendPointEntity value)  $default,){
final _that = this;
switch (_that) {
case _TrendPointEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrendPointEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TrendPointEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  double occupancy,  double revenue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrendPointEntity() when $default != null:
return $default(_that.label,_that.occupancy,_that.revenue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  double occupancy,  double revenue)  $default,) {final _that = this;
switch (_that) {
case _TrendPointEntity():
return $default(_that.label,_that.occupancy,_that.revenue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  double occupancy,  double revenue)?  $default,) {final _that = this;
switch (_that) {
case _TrendPointEntity() when $default != null:
return $default(_that.label,_that.occupancy,_that.revenue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrendPointEntity implements TrendPointEntity {
  const _TrendPointEntity({required this.label, required this.occupancy, required this.revenue});
  factory _TrendPointEntity.fromJson(Map<String, dynamic> json) => _$TrendPointEntityFromJson(json);

@override final  String label;
@override final  double occupancy;
@override final  double revenue;

/// Create a copy of TrendPointEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrendPointEntityCopyWith<_TrendPointEntity> get copyWith => __$TrendPointEntityCopyWithImpl<_TrendPointEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrendPointEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrendPointEntity&&(identical(other.label, label) || other.label == label)&&(identical(other.occupancy, occupancy) || other.occupancy == occupancy)&&(identical(other.revenue, revenue) || other.revenue == revenue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,occupancy,revenue);

@override
String toString() {
  return 'TrendPointEntity(label: $label, occupancy: $occupancy, revenue: $revenue)';
}


}

/// @nodoc
abstract mixin class _$TrendPointEntityCopyWith<$Res> implements $TrendPointEntityCopyWith<$Res> {
  factory _$TrendPointEntityCopyWith(_TrendPointEntity value, $Res Function(_TrendPointEntity) _then) = __$TrendPointEntityCopyWithImpl;
@override @useResult
$Res call({
 String label, double occupancy, double revenue
});




}
/// @nodoc
class __$TrendPointEntityCopyWithImpl<$Res>
    implements _$TrendPointEntityCopyWith<$Res> {
  __$TrendPointEntityCopyWithImpl(this._self, this._then);

  final _TrendPointEntity _self;
  final $Res Function(_TrendPointEntity) _then;

/// Create a copy of TrendPointEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? occupancy = null,Object? revenue = null,}) {
  return _then(_TrendPointEntity(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,occupancy: null == occupancy ? _self.occupancy : occupancy // ignore: cast_nullable_to_non_nullable
as double,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$GetOccupancyTrendResponseEntity {

 String get period; List<TrendPointEntity> get points; List<TrendPointEntity> get comparisonPoints;
/// Create a copy of GetOccupancyTrendResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetOccupancyTrendResponseEntityCopyWith<GetOccupancyTrendResponseEntity> get copyWith => _$GetOccupancyTrendResponseEntityCopyWithImpl<GetOccupancyTrendResponseEntity>(this as GetOccupancyTrendResponseEntity, _$identity);

  /// Serializes this GetOccupancyTrendResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetOccupancyTrendResponseEntity&&(identical(other.period, period) || other.period == period)&&const DeepCollectionEquality().equals(other.points, points)&&const DeepCollectionEquality().equals(other.comparisonPoints, comparisonPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,period,const DeepCollectionEquality().hash(points),const DeepCollectionEquality().hash(comparisonPoints));

@override
String toString() {
  return 'GetOccupancyTrendResponseEntity(period: $period, points: $points, comparisonPoints: $comparisonPoints)';
}


}

/// @nodoc
abstract mixin class $GetOccupancyTrendResponseEntityCopyWith<$Res>  {
  factory $GetOccupancyTrendResponseEntityCopyWith(GetOccupancyTrendResponseEntity value, $Res Function(GetOccupancyTrendResponseEntity) _then) = _$GetOccupancyTrendResponseEntityCopyWithImpl;
@useResult
$Res call({
 String period, List<TrendPointEntity> points, List<TrendPointEntity> comparisonPoints
});




}
/// @nodoc
class _$GetOccupancyTrendResponseEntityCopyWithImpl<$Res>
    implements $GetOccupancyTrendResponseEntityCopyWith<$Res> {
  _$GetOccupancyTrendResponseEntityCopyWithImpl(this._self, this._then);

  final GetOccupancyTrendResponseEntity _self;
  final $Res Function(GetOccupancyTrendResponseEntity) _then;

/// Create a copy of GetOccupancyTrendResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? period = null,Object? points = null,Object? comparisonPoints = null,}) {
  return _then(_self.copyWith(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<TrendPointEntity>,comparisonPoints: null == comparisonPoints ? _self.comparisonPoints : comparisonPoints // ignore: cast_nullable_to_non_nullable
as List<TrendPointEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [GetOccupancyTrendResponseEntity].
extension GetOccupancyTrendResponseEntityPatterns on GetOccupancyTrendResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetOccupancyTrendResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetOccupancyTrendResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetOccupancyTrendResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _GetOccupancyTrendResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetOccupancyTrendResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GetOccupancyTrendResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String period,  List<TrendPointEntity> points,  List<TrendPointEntity> comparisonPoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetOccupancyTrendResponseEntity() when $default != null:
return $default(_that.period,_that.points,_that.comparisonPoints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String period,  List<TrendPointEntity> points,  List<TrendPointEntity> comparisonPoints)  $default,) {final _that = this;
switch (_that) {
case _GetOccupancyTrendResponseEntity():
return $default(_that.period,_that.points,_that.comparisonPoints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String period,  List<TrendPointEntity> points,  List<TrendPointEntity> comparisonPoints)?  $default,) {final _that = this;
switch (_that) {
case _GetOccupancyTrendResponseEntity() when $default != null:
return $default(_that.period,_that.points,_that.comparisonPoints);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetOccupancyTrendResponseEntity implements GetOccupancyTrendResponseEntity {
  const _GetOccupancyTrendResponseEntity({required this.period, required final  List<TrendPointEntity> points, required final  List<TrendPointEntity> comparisonPoints}): _points = points,_comparisonPoints = comparisonPoints;
  factory _GetOccupancyTrendResponseEntity.fromJson(Map<String, dynamic> json) => _$GetOccupancyTrendResponseEntityFromJson(json);

@override final  String period;
 final  List<TrendPointEntity> _points;
@override List<TrendPointEntity> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

 final  List<TrendPointEntity> _comparisonPoints;
@override List<TrendPointEntity> get comparisonPoints {
  if (_comparisonPoints is EqualUnmodifiableListView) return _comparisonPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comparisonPoints);
}


/// Create a copy of GetOccupancyTrendResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetOccupancyTrendResponseEntityCopyWith<_GetOccupancyTrendResponseEntity> get copyWith => __$GetOccupancyTrendResponseEntityCopyWithImpl<_GetOccupancyTrendResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetOccupancyTrendResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetOccupancyTrendResponseEntity&&(identical(other.period, period) || other.period == period)&&const DeepCollectionEquality().equals(other._points, _points)&&const DeepCollectionEquality().equals(other._comparisonPoints, _comparisonPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,period,const DeepCollectionEquality().hash(_points),const DeepCollectionEquality().hash(_comparisonPoints));

@override
String toString() {
  return 'GetOccupancyTrendResponseEntity(period: $period, points: $points, comparisonPoints: $comparisonPoints)';
}


}

/// @nodoc
abstract mixin class _$GetOccupancyTrendResponseEntityCopyWith<$Res> implements $GetOccupancyTrendResponseEntityCopyWith<$Res> {
  factory _$GetOccupancyTrendResponseEntityCopyWith(_GetOccupancyTrendResponseEntity value, $Res Function(_GetOccupancyTrendResponseEntity) _then) = __$GetOccupancyTrendResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 String period, List<TrendPointEntity> points, List<TrendPointEntity> comparisonPoints
});




}
/// @nodoc
class __$GetOccupancyTrendResponseEntityCopyWithImpl<$Res>
    implements _$GetOccupancyTrendResponseEntityCopyWith<$Res> {
  __$GetOccupancyTrendResponseEntityCopyWithImpl(this._self, this._then);

  final _GetOccupancyTrendResponseEntity _self;
  final $Res Function(_GetOccupancyTrendResponseEntity) _then;

/// Create a copy of GetOccupancyTrendResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? period = null,Object? points = null,Object? comparisonPoints = null,}) {
  return _then(_GetOccupancyTrendResponseEntity(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<TrendPointEntity>,comparisonPoints: null == comparisonPoints ? _self._comparisonPoints : comparisonPoints // ignore: cast_nullable_to_non_nullable
as List<TrendPointEntity>,
  ));
}


}

// dart format on
