// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linked_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkedDeviceResponse _$LinkedDeviceResponseFromJson(
  Map<String, dynamic> json,
) => LinkedDeviceResponse(
  success: json['success'] as bool,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : LinkedDevicesData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LinkedDeviceResponseToJson(
  LinkedDeviceResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

LinkedDevicesData _$LinkedDevicesDataFromJson(Map<String, dynamic> json) =>
    LinkedDevicesData(
      devices: (json['devices'] as List<dynamic>)
          .map((e) => LinkedDevice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LinkedDevicesDataToJson(LinkedDevicesData instance) =>
    <String, dynamic>{'devices': instance.devices};

LinkedDevice _$LinkedDeviceFromJson(Map<String, dynamic> json) => LinkedDevice(
  id: json['id'] as String,
  userId: json['userId'] as String?,
  deviceName: json['deviceName'] as String,
  deviceType: json['deviceType'] as String,
  deviceIdentifier: json['deviceIdentifier'] as String,
  fcmToken: json['fcmToken'] as String?,
  deviceStatus: json['deviceStatus'] as String?,
  lastActive: json['lastActive'] == null
      ? null
      : DateTime.parse(json['lastActive'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$LinkedDeviceToJson(LinkedDevice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'deviceName': instance.deviceName,
      'deviceType': instance.deviceType,
      'deviceIdentifier': instance.deviceIdentifier,
      'fcmToken': instance.fcmToken,
      'deviceStatus': instance.deviceStatus,
      'lastActive': instance.lastActive?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

RemoveDeviceRequest _$RemoveDeviceRequestFromJson(Map<String, dynamic> json) =>
    RemoveDeviceRequest(deviceId: json['deviceId'] as String);

Map<String, dynamic> _$RemoveDeviceRequestToJson(
  RemoveDeviceRequest instance,
) => <String, dynamic>{'deviceId': instance.deviceId};

RemoveDeviceResponse _$RemoveDeviceResponseFromJson(
  Map<String, dynamic> json,
) => RemoveDeviceResponse(
  success: json['success'] as bool,
  message: json['message'] as String?,
);

Map<String, dynamic> _$RemoveDeviceResponseToJson(
  RemoveDeviceResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
};
