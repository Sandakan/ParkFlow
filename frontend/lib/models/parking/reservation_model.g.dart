// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReservationModel _$ReservationModelFromJson(Map<String, dynamic> json) =>
    _ReservationModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      slotId: json['slot_id'] as String,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
      vehicle: VehicleModel.fromJson(json['vehicle'] as Map<String, dynamic>),
      durationMinutes: (json['duration_minutes'] as num).toInt(),
      paymentMethod: json['payment_method'] as String,
      totalPrice: (json['total_price'] as num).toDouble(),
      baseRate: (json['base_rate'] as num).toDouble(),
      checkInTime: json['check_in_time'] == null
          ? null
          : DateTime.parse(json['check_in_time'] as String),
      checkOutTime: json['check_out_time'] == null
          ? null
          : DateTime.parse(json['check_out_time'] as String),
      actualEndTime: DateTime.parse(json['actual_end_time'] as String),
      totalBilledPrice: (json['total_billed_price'] as num).toDouble(),
      status: json['status'] as String,
      qrCodeToken: json['qr_code_token'] as String,
      lotName: json['lot_name'] as String,
      lotAddress: json['lot_address'] as String,
      lotLatitude: (json['lot_latitude'] as num).toDouble(),
      lotLongitude: (json['lot_longitude'] as num).toDouble(),
      slotName: json['slot_name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ReservationModelToJson(_ReservationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'slot_id': instance.slotId,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime.toIso8601String(),
      'vehicle': instance.vehicle,
      'duration_minutes': instance.durationMinutes,
      'payment_method': instance.paymentMethod,
      'total_price': instance.totalPrice,
      'base_rate': instance.baseRate,
      'check_in_time': instance.checkInTime?.toIso8601String(),
      'check_out_time': instance.checkOutTime?.toIso8601String(),
      'actual_end_time': instance.actualEndTime.toIso8601String(),
      'total_billed_price': instance.totalBilledPrice,
      'status': instance.status,
      'qr_code_token': instance.qrCodeToken,
      'lot_name': instance.lotName,
      'lot_address': instance.lotAddress,
      'lot_latitude': instance.lotLatitude,
      'lot_longitude': instance.lotLongitude,
      'slot_name': instance.slotName,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
