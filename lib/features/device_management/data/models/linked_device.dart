import 'package:json_annotation/json_annotation.dart';

part 'linked_device.g.dart';

@JsonSerializable()
class LinkedDeviceResponse {
  final bool success;
  final String? message;
  final LinkedDevicesData? data;

  LinkedDeviceResponse({
    required this.success,
    this.message,
    this.data,
  });

  factory LinkedDeviceResponse.fromJson(Map<String, dynamic> json) =>
      _$LinkedDeviceResponseFromJson(json);
}

@JsonSerializable()
class LinkedDevicesData {
  final List<LinkedDevice> devices;

  LinkedDevicesData({required this.devices});

  factory LinkedDevicesData.fromJson(Map<String, dynamic> json) =>
      _$LinkedDevicesDataFromJson(json);
}

@JsonSerializable()
class LinkedDevice {
  final String id;
  final String? userId;
  final String deviceName;
  final String deviceType;
  final String deviceIdentifier;
  final String? fcmToken;
  final String? deviceStatus;
  final DateTime? lastActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LinkedDevice({
    required this.id,
    this.userId,
    required this.deviceName,
    required this.deviceType,
    required this.deviceIdentifier,
    this.fcmToken,
    this.deviceStatus,
    this.lastActive,
    this.createdAt,
    this.updatedAt,
  });

  factory LinkedDevice.fromJson(Map<String, dynamic> json) =>
      _$LinkedDeviceFromJson(json);

  Map<String, dynamic> toJson() => _$LinkedDeviceToJson(this);
}

@JsonSerializable()
class RemoveDeviceRequest {
  final String deviceId;

  RemoveDeviceRequest({required this.deviceId});

  Map<String, dynamic> toJson() => _$RemoveDeviceRequestToJson(this);
}

@JsonSerializable()
class RemoveDeviceResponse {
  final bool success;
  final String? message;

  RemoveDeviceResponse({
    required this.success,
    this.message,
  });

  factory RemoveDeviceResponse.fromJson(Map<String, dynamic> json) =>
      _$RemoveDeviceResponseFromJson(json);
}
