import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_webrtc_offer_request.freezed.dart';
part 'create_webrtc_offer_request.g.dart';

@freezed
abstract class CreateWebrtcOfferRequest with _$CreateWebrtcOfferRequest {
  const factory CreateWebrtcOfferRequest({
    required String sdp,
    required String type,
  }) = _CreateWebrtcOfferRequest;

  factory CreateWebrtcOfferRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateWebrtcOfferRequestFromJson(json);
}
