import 'package:equatable/equatable.dart';

abstract class PermissionEvent extends Equatable {
  const PermissionEvent();

  @override
  List<Object?> get props => [];
}

/// Event to check all permissions status
class CheckPermissions extends PermissionEvent {
  const CheckPermissions();
}

/// Event to request notification listener permission
class RequestNotificationPermission extends PermissionEvent {
  const RequestNotificationPermission();
}

/// Event to request location permission
class RequestLocationPermission extends PermissionEvent {
  const RequestLocationPermission();
}

/// Event to request device admin permission
class RequestDevicePermission extends PermissionEvent {
  const RequestDevicePermission();
}

/// Event to request usage access permission
class RequestUsagePermission extends PermissionEvent {
  const RequestUsagePermission();
}

/// Event to refresh permission status after returning from settings
class RefreshPermissions extends PermissionEvent {
  const RefreshPermissions();
}
