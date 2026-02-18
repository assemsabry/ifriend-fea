import 'package:equatable/equatable.dart';

abstract class DeviceManagementEvent extends Equatable {
  const DeviceManagementEvent();

  @override
  List<Object?> get props => [];
}

class LoadLinkedDevices extends DeviceManagementEvent {
  const LoadLinkedDevices();
}

class RemoveDevice extends DeviceManagementEvent {
  final String deviceId;

  const RemoveDevice(this.deviceId);

  @override
  List<Object?> get props => [deviceId];
}

class RefreshDevices extends DeviceManagementEvent {
  const RefreshDevices();
}
