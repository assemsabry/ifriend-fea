// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_qr_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateQrRequest _$GenerateQrRequestFromJson(Map<String, dynamic> json) =>
    GenerateQrRequest(
      deviceId: json['deviceId'] as String,
      deviceModel: json['deviceModel'] as String?,
      batteryPercentage: (json['batteryPercentage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GenerateQrRequestToJson(GenerateQrRequest instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'deviceModel': instance.deviceModel,
      'batteryPercentage': instance.batteryPercentage,
    };
