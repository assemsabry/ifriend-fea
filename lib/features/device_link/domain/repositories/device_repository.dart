import 'package:dartz/dartz.dart';
import 'package:ifriend_app/core/networking/api_error_handler.dart';
import '../entities/child_qr_code_entity.dart';

abstract class DeviceRepository {
  Future<Either<ApiErrorHandler, ChildQrCodeEntity>> generateChildQr();
}
