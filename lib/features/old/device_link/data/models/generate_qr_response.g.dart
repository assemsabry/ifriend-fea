// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_qr_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateQrResponse _$GenerateQrResponseFromJson(Map<String, dynamic> json) =>
    GenerateQrResponse(
      success: json['success'] as bool,
      data: QrData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GenerateQrResponseToJson(GenerateQrResponse instance) =>
    <String, dynamic>{'success': instance.success, 'data': instance.data};

QrData _$QrDataFromJson(Map<String, dynamic> json) => QrData(
  requestId: json['requestId'] as String?,
  qrCodeImage: json['qrCodeImage'] as String?,
  qrToken: json['qrCodeData'] as String?,
  expiresAt: json['expiresAt'] as String?,
);

Map<String, dynamic> _$QrDataToJson(QrData instance) => <String, dynamic>{
  'requestId': instance.requestId,
  'qrCodeImage': instance.qrCodeImage,
  'qrCodeData': instance.qrToken,
  'expiresAt': instance.expiresAt,
};
