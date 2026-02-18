import 'package:equatable/equatable.dart';

class DeviceEntity extends Equatable {
  final String id;
  final String? userId;
  final String deviceId;
  final String deviceModel;
  final String? childName;
  final String? childAvatar;
  final int? batteryLevel;
  final DateTime? linkedAt;
  final DateTime? lastSeen;

  const DeviceEntity({
    required this.id,
    required this.deviceId,
    required this.deviceModel,
    required this.userId,
    this.childName,
    this.childAvatar,
    this.batteryLevel,
    this.linkedAt,
    this.lastSeen,
  });

  @override
  List<Object?> get props => [
    id,
    deviceId,
    deviceModel,
    childName,
    childAvatar,
    batteryLevel,
    linkedAt,
    lastSeen,
  ];
}
