import 'package:json_annotation/json_annotation.dart';

part 'generate_qr_response.g.dart';

@JsonSerializable()
class GenerateQrResponse {
  final bool success;
  final QrData data;

  const GenerateQrResponse({required this.success, required this.data});

  factory GenerateQrResponse.fromJson(Map<String, dynamic> json) =>
      _$GenerateQrResponseFromJson(json);
}

@JsonSerializable()
class QrData {
  // The API returns 'requestId', include it in case callers need it
  final String? requestId;

  // The API returns a base64 image under 'qrCodeImage'
  final String? qrCodeImage;

  // The actual token is returned in the API as 'qrCodeData'. Map it to qrToken
  @JsonKey(name: 'qrCodeData')
  final String? qrToken;

  // expiry timestamp as string (nullable to be defensive)
  final String? expiresAt;

  const QrData({
    this.requestId,
    this.qrCodeImage,
    this.qrToken,
    this.expiresAt,
  });

  factory QrData.fromJson(Map<String, dynamic> json) => _$QrDataFromJson(json);
}
