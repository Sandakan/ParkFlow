import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_webrtc_offer_response_entity.freezed.dart';
part 'get_webrtc_offer_response_entity.g.dart';

@freezed
abstract class GetWebrtcOfferResponseEntity
    with _$GetWebrtcOfferResponseEntity {
  const factory GetWebrtcOfferResponseEntity({
    required String sdp,
    required String type,
  }) = _GetWebrtcOfferResponseEntity;

  factory GetWebrtcOfferResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetWebrtcOfferResponseEntityFromJson(json);
}
