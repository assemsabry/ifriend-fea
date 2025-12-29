import 'package:dartz/dartz.dart';
import 'package:ifriend_app/core/networking/api_error_handler.dart';
import 'package:ifriend_app/features/device_management/domain/entities/device_entity.dart';

abstract class DeviceManagementRepository {
  Future<Either<ApiErrorHandler, List<DeviceEntity>>> getLinkedDevices();
  Future<Either<ApiErrorHandler, bool>> removeDevice(String deviceId);
}
