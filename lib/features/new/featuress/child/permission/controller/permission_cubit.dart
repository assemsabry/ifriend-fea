import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/features/old/permissions/data/services/permission_service.dart';

part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  PermissionCubit() : super(PermissionInitial());

  static PermissionCubit get(BuildContext context) => BlocProvider.of(context);

  final PermissionService _permissionService = PermissionService();

  bool notificationGranted = false;
  bool locationGranted = false;
  bool deviceGranted = false;
  bool usageGranted = false;
  bool allGranted = false;
  void updatePermissions(Map<String, bool> permissions) {
    notificationGranted = permissions['notification'] ?? false;
    locationGranted = permissions['location'] ?? false;
    deviceGranted = permissions['device'] ?? false;
    usageGranted = permissions['usage'] ?? false;
    allGranted = permissions.values.every((value) => value);
  }

  Future<void> checkDevicePermissions() async {
    emit(PermissionChecking());

    try {
      final permissions = await _permissionService.checkAllPermissions();

      updatePermissions(permissions);

      emit(PermissionLoaded(permissions));
    } catch (e) {
      emit(PermissionError('Failed to check permissions: $e'));
    }
  }

  Future<void> requestPermission(String type) async {
    emit(PermissionLoading());

    switch (type) {
      case 'notification':
        await _permissionService.requestNotificationAccess();
        break;
      case 'location':
        await _permissionService.requestLocationAccess();
        break;
      case 'device':
        await _permissionService.requestDeviceAccess();
        break;
      case 'usage':
        await _permissionService.requestUsageAccess();
        break;
    }

    await Future.delayed(const Duration(milliseconds: 500));
    await checkDevicePermissions();
  }
}
