import 'package:dartz/dartz.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:ifriend_app/core/networking/api_error_handler.dart';
import '../../domain/entities/child_qr_code_entity.dart';
import '../../domain/repositories/device_repository.dart';
import '../datasources/link_api_service.dart';
import '../models/generate_qr_request.dart';

class LinkRepositoryImpl implements DeviceRepository {
  final LinkApiService _linkApiService;

  LinkRepositoryImpl(this._linkApiService);

  @override
  Future<Either<ApiErrorHandler, ChildQrCodeEntity>> generateChildQr() async {
    try {
      final deviceId = await _getDeviceId();
      final deviceModel = await _getDeviceModel();
      final batteryLevel = await _getBatteryLevel();

      final request = GenerateQrRequest(
        deviceId: deviceId,
        deviceModel: deviceModel,
        batteryPercentage: batteryLevel,
      );

      final response = await _linkApiService.generateQr(request);

      // Defensive: map nullable API response fields into non-nullable entity fields
      final qrToken = response.data.qrToken ?? response.data.requestId ?? '';
      final expiresAt = response.data.expiresAt ?? '';

      return Right(ChildQrCodeEntity(qrToken: qrToken, expiresAt: expiresAt));
    } on DioException catch (error) {
      return Left(ApiErrorHandler.fromDioError(error));
    } catch (error) {
      return Left(ApiErrorHandler(message: error.toString()));
    }
  }

  Future<String> _getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    String deviceId;

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id; // androidId
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? const Uuid().v4();
      } else {
        deviceId = const Uuid().v4();
      }
    } catch (e) {
      deviceId = const Uuid().v4();
    }
    return deviceId;
  }

  Future<String?> _getDeviceModel() async {
    final deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return '${androidInfo.manufacturer} ${androidInfo.model}';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.name;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<int?> _getBatteryLevel() async {
    try {
      final battery = Battery();
      return await battery.batteryLevel;
    } catch (_) {
      return null;
    }
  }
}
