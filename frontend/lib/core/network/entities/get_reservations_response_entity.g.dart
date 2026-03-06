// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_reservations_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetReservationsResponseEntity _$GetReservationsResponseEntityFromJson(
  Map<String, dynamic> json,
) => _GetReservationsResponseEntity(
  reservations: (json['reservations'] as List<dynamic>)
      .map((e) => ReservationModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GetReservationsResponseEntityToJson(
  _GetReservationsResponseEntity instance,
) => <String, dynamic>{'reservations': instance.reservations};
