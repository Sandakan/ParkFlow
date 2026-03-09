// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot_availability_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SlotAvailabilityResponseEntity _$SlotAvailabilityResponseEntityFromJson(
  Map<String, dynamic> json,
) => _SlotAvailabilityResponseEntity(
  available: json['available'] as bool,
  slotId: json['slotId'] as String?,
);

Map<String, dynamic> _$SlotAvailabilityResponseEntityToJson(
  _SlotAvailabilityResponseEntity instance,
) => <String, dynamic>{
  'available': instance.available,
  'slotId': instance.slotId,
};
