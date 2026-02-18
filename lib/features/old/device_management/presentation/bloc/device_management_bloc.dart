import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/features/old/device_management/domain/usecases/get_linked_devices_usecase.dart';
import 'package:ifriend_app/features/old/device_management/domain/usecases/remove_device_usecase.dart';
import 'package:ifriend_app/features/old/device_management/presentation/bloc/device_management_event.dart';
import 'package:ifriend_app/features/old/device_management/presentation/bloc/device_management_state.dart';

class DeviceManagementBloc
    extends Bloc<DeviceManagementEvent, DeviceManagementState> {
  final GetLinkedDevicesUseCase getLinkedDevicesUseCase;
  final RemoveDeviceUseCase removeDeviceUseCase;

  DeviceManagementBloc({
    required this.getLinkedDevicesUseCase,
    required this.removeDeviceUseCase,
  }) : super(const DeviceManagementInitial()) {
    on<LoadLinkedDevices>(_onLoadLinkedDevices);
    on<RemoveDevice>(_onRemoveDevice);
    on<RefreshDevices>(_onRefreshDevices);
  }

  Future<void> _onLoadLinkedDevices(
    LoadLinkedDevices event,
    Emitter<DeviceManagementState> emit,
  ) async {
    emit(const DeviceManagementLoading());

    final result = await getLinkedDevicesUseCase();

    result.fold(
      (failure) => emit(
        DeviceManagementError(failure.message ?? 'Failed to load devices'),
      ),
      (devices) => emit(DeviceManagementLoaded(devices)),
    );
  }

  Future<void> _onRemoveDevice(
    RemoveDevice event,
    Emitter<DeviceManagementState> emit,
  ) async {
    emit(DeviceRemoving(event.deviceId));

    final result = await removeDeviceUseCase(event.deviceId);

    result.fold(
      (failure) => emit(
        DeviceRemovalError(
          event.deviceId,
          failure.message ?? 'Failed to remove device',
        ),
      ),
      (success) {
        emit(DeviceRemoved(event.deviceId));
        // Automatically refresh the list after removal
        add(const RefreshDevices());
      },
    );
  }

  Future<void> _onRefreshDevices(
    RefreshDevices event,
    Emitter<DeviceManagementState> emit,
  ) async {
    // Don't show loading state on refresh, just fetch silently
    final result = await getLinkedDevicesUseCase();

    result.fold(
      (failure) => emit(
        DeviceManagementError(failure.message ?? 'Failed to refresh devices'),
      ),
      (devices) => emit(DeviceManagementLoaded(devices)),
    );
  }
}
