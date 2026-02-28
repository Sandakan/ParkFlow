// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_webrtc_offer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateWebrtcOfferRequest _$CreateWebrtcOfferRequestFromJson(
  Map<String, dynamic> json,
) => _CreateWebrtcOfferRequest(
  sdp: json['sdp'] as String,
  type: json['type'] as String,
);

Map<String, dynamic> _$CreateWebrtcOfferRequestToJson(
  _CreateWebrtcOfferRequest instance,
) => <String, dynamic>{'sdp': instance.sdp, 'type': instance.type};
