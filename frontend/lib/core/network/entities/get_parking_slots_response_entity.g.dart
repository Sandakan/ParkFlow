// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_parking_slots_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetParkingSlotsResponseEntity _$GetParkingSlotsResponseEntityFromJson(
  Map<String, dynamic> json,
) => _GetParkingSlotsResponseEntity(
  slots: (json['slots'] as List<dynamic>)
      .map((e) => ParkingSlotModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GetParkingSlotsResponseEntityToJson(
  _GetParkingSlotsResponseEntity instance,
) => <String, dynamic>{'slots': instance.slots};
