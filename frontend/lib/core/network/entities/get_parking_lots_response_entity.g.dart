// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_parking_lots_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetParkingLotsResponseEntity _$GetParkingLotsResponseEntityFromJson(
  Map<String, dynamic> json,
) => _GetParkingLotsResponseEntity(
  lots: (json['lots'] as List<dynamic>)
      .map((e) => ParkingLotModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GetParkingLotsResponseEntityToJson(
  _GetParkingLotsResponseEntity instance,
) => <String, dynamic>{'lots': instance.lots};
