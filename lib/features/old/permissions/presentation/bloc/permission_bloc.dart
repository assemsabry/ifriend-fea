import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/features/old/permissions/data/services/permission_service.dart';
import 'package:ifriend_app/features/old/permissions/presentation/bloc/permission_event.dart';
import 'package:ifriend_app/features/old/permissions/presentation/bloc/permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  final PermissionService _permissionService;

  PermissionBloc(this._permissionService) : super(const PermissionState()) {
    on<CheckPermissions>(_onCheckPermissions);
    on<RequestNotificationPermission>(_onRequestNotificationPermission);
    on<RequestLocationPermission>(_onRequestLocationPermission);
    on<RequestDevicePermission>(_onRequestDevicePermission);
    on<RequestUsagePermission>(_onRequestUsagePermission);
    on<RefreshPermissions>(_onRefreshPermissions);
  }

  /// Check all permissions status
  Future<void> _onCheckPermissions(
    CheckPermissions event,
    Emitter<PermissionState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final permissions = await _permissionService.checkAllPermissions();

      emit(
        state.copyWith(
          notificationGranted: permissions['notification'] ?? false,
          locationGranted: permissions['location'] ?? false,
          deviceGranted: permissions['device'] ?? false,
          usageGranted: permissions['usage'] ?? false,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to check permissions: ${e.toString()}',
        ),
      );
    }
  }

  /// Request notification listener permission
  Future<void> _onRequestNotificationPermission(
    RequestNotificationPermission event,
    Emitter<PermissionState> emit,
  ) async {
    try {
      await _permissionService.requestNotificationAccess();
      // After returning from settings, check the permission again
      add(const RefreshPermissions());
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage:
              'Failed to request notification permission: ${e.toString()}',
        ),
      );
    }
  }

  /// Request location permission
  Future<void> _onRequestLocationPermission(
    RequestLocationPermission event,
    Emitter<PermissionState> emit,
  ) async {
    try {
      final granted = await _permissionService.requestLocationAccess();
      emit(state.copyWith(locationGranted: granted));
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage:
              'Failed to request location permission: ${e.toString()}',
        ),
      );
    }
  }

  /// Request device admin permission
  Future<void> _onRequestDevicePermission(
    RequestDevicePermission event,
    Emitter<PermissionState> emit,
  ) async {
    try {
      await _permissionService.requestDeviceAccess();
      // After returning from settings, check the permission again
      add(const RefreshPermissions());
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to request device permission: ${e.toString()}',
        ),
      );
    }
  }

  /// Request usage access permission
  Future<void> _onRequestUsagePermission(
    RequestUsagePermission event,
    Emitter<PermissionState> emit,
  ) async {
    try {
      await _permissionService.requestUsageAccess();
      // After returning from settings, check the permission again
      add(const RefreshPermissions());
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to request usage permission: ${e.toString()}',
        ),
      );
    }
  }

  /// Refresh all permissions status
  Future<void> _onRefreshPermissions(
    RefreshPermissions event,
    Emitter<PermissionState> emit,
  ) async {
    try {
      final permissions = await _permissionService.checkAllPermissions();

      emit(
        state.copyWith(
          notificationGranted: permissions['notification'] ?? false,
          locationGranted: permissions['location'] ?? false,
          deviceGranted: permissions['device'] ?? false,
          usageGranted: permissions['usage'] ?? false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to refresh permissions: ${e.toString()}',
        ),
      );
    }
  }
}
