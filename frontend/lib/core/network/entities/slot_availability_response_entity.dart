import 'package:freezed_annotation/freezed_annotation.dart';

part 'slot_availability_response_entity.freezed.dart';
part 'slot_availability_response_entity.g.dart';

@freezed
abstract class SlotAvailabilityResponseEntity
    with _$SlotAvailabilityResponseEntity {
  const factory SlotAvailabilityResponseEntity({
    required bool available,
    String? slotId,
  }) = _SlotAvailabilityResponseEntity;

  factory SlotAvailabilityResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$SlotAvailabilityResponseEntityFromJson(json);
}
