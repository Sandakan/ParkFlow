// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReservationResponseEntity _$ReservationResponseEntityFromJson(
  Map<String, dynamic> json,
) => _ReservationResponseEntity(
  reservation: ReservationModel.fromJson(
    json['reservation'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ReservationResponseEntityToJson(
  _ReservationResponseEntity instance,
) => <String, dynamic>{'reservation': instance.reservation};
