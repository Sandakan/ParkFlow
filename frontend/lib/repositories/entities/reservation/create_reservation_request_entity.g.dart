// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_reservation_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateReservationRequestEntity _$CreateReservationRequestEntityFromJson(
  Map<String, dynamic> json,
) => _CreateReservationRequestEntity(
  slotId: json['slot_id'] as String,
  lotId: json['lot_id'] as String?,
  vehicle: VehicleModel.fromJson(json['vehicle'] as Map<String, dynamic>),
  startTime: json['start_time'] as String,
  durationMinutes: (json['duration_minutes'] as num).toInt(),
  paymentMethod: json['payment_method'] as String,
);

Map<String, dynamic> _$CreateReservationRequestEntityToJson(
  _CreateReservationRequestEntity instance,
) => <String, dynamic>{
  'slot_id': instance.slotId,
  'lot_id': instance.lotId,
  'vehicle': instance.vehicle,
  'start_time': instance.startTime,
  'duration_minutes': instance.durationMinutes,
  'payment_method': instance.paymentMethod,
};
