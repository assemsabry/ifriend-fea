import 'package:dartz/dartz.dart';
import 'package:ifriend_app/core/networking/api_error_handler.dart';
import '../entities/child_qr_code_entity.dart';
import '../repositories/device_repository.dart';

class GenerateChildQrUseCase {
  final DeviceRepository _deviceRepository;

  GenerateChildQrUseCase(this._deviceRepository);

  Future<Either<ApiErrorHandler, ChildQrCodeEntity>> call() async {
    return await _deviceRepository.generateChildQr();
  }
}
