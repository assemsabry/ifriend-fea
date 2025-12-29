import 'package:dartz/dartz.dart';
import 'package:ifriend_app/core/networking/api_error_handler.dart';
import 'package:ifriend_app/features/device_management/data/datasources/device_management_remote_datasource.dart';
import 'package:ifriend_app/features/device_management/domain/entities/device_entity.dart';
import 'package:ifriend_app/features/device_management/domain/repositories/device_management_repository.dart';

class DeviceManagementRepositoryImpl implements DeviceManagementRepository {
  final DeviceManagementRemoteDataSource remoteDataSource;

  DeviceManagementRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ApiErrorHandler, List<DeviceEntity>>> getLinkedDevices() async {
    try {
      final devices = await remoteDataSource.getLinkedDevices();

      // Map to domain entities
      final entities = devices
          .map(
            (device) => DeviceEntity(
              userId: device.userId,
              id: device.id,
              deviceId: device.deviceIdentifier,
              deviceModel: device.deviceName,
              childName: null,
              childAvatar: null,
              batteryLevel: null,
              linkedAt: device.createdAt,
              lastSeen: device.lastActive,
            ),
          )
          .toList();

      return Right(entities);
    } catch (e) {
      return Left(ApiErrorHandler(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiErrorHandler, bool>> removeDevice(String deviceId) async {
    try {
      final success = await remoteDataSource.removeDevice(deviceId);
      return Right(success);
    } catch (e) {
      return Left(ApiErrorHandler(message: e.toString()));
    }
  }
}
