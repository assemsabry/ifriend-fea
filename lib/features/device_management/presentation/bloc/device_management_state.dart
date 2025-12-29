import 'package:equatable/equatable.dart';
import 'package:ifriend_app/features/device_management/domain/entities/device_entity.dart';

abstract class DeviceManagementState extends Equatable {
  const DeviceManagementState();

  @override
  List<Object?> get props => [];
}

class DeviceManagementInitial extends DeviceManagementState {
  const DeviceManagementInitial();
}

class DeviceManagementLoading extends DeviceManagementState {
  const DeviceManagementLoading();
}

class DeviceManagementLoaded extends DeviceManagementState {
  final List<DeviceEntity> devices;

  const DeviceManagementLoaded(this.devices);

  @override
  List<Object?> get props => [devices];
}

class DeviceManagementError extends DeviceManagementState {
  final String message;

  const DeviceManagementError(this.message);

  @override
  List<Object?> get props => [message];
}

class DeviceRemoving extends DeviceManagementState {
  final String deviceId;

  const DeviceRemoving(this.deviceId);

  @override
  List<Object?> get props => [deviceId];
}

class DeviceRemoved extends DeviceManagementState {
  final String deviceId;

  const DeviceRemoved(this.deviceId);

  @override
  List<Object?> get props => [deviceId];
}

class DeviceRemovalError extends DeviceManagementState {
  final String deviceId;
  final String message;

  const DeviceRemovalError(this.deviceId, this.message);

  @override
  List<Object?> get props => [deviceId, message];
}
