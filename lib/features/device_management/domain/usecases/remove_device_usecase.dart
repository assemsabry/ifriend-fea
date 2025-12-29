import 'package:dartz/dartz.dart';
import 'package:ifriend_app/core/networking/api_error_handler.dart';
import 'package:ifriend_app/features/device_management/domain/repositories/device_management_repository.dart';

class RemoveDeviceUseCase {
  final DeviceManagementRepository repository;

  RemoveDeviceUseCase(this.repository);

  Future<Either<ApiErrorHandler, bool>> call(String deviceId) async {
    return await repository.removeDevice(deviceId);
  }
}
