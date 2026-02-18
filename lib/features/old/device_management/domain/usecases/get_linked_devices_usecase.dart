import 'package:dartz/dartz.dart';
import 'package:ifriend_app/core/networking/api_error_handler.dart';
import 'package:ifriend_app/features/old/device_management/domain/entities/device_entity.dart';
import 'package:ifriend_app/features/old/device_management/domain/repositories/device_management_repository.dart';

class GetLinkedDevicesUseCase {
  final DeviceManagementRepository repository;

  GetLinkedDevicesUseCase(this.repository);

  Future<Either<ApiErrorHandler, List<DeviceEntity>>> call() async {
    return await repository.getLinkedDevices();
  }
}
