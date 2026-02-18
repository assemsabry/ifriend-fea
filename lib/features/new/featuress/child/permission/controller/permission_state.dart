part of 'permission_cubit.dart';

@immutable
abstract class PermissionState {}

class PermissionInitial extends PermissionState {}

class PermissionLoading extends PermissionState {}

class PermissionChecking extends PermissionState {}

class PermissionLoaded extends PermissionState {
  final Map<String, bool> permissions;

  PermissionLoaded(this.permissions);

  bool get notificationGranted => permissions['notification'] ?? false;
  bool get locationGranted => permissions['location'] ?? false;
  bool get deviceGranted => permissions['device'] ?? false;
  bool get usageGranted => permissions['usage'] ?? false;

  bool get allGranted =>
      notificationGranted && locationGranted && deviceGranted && usageGranted;
}

class AllPermissionsGranted extends PermissionState {}

class PermissionError extends PermissionState {
  final String message;

  PermissionError(this.message);
}
