import 'package:ifriend_app/features/old/device_linking_scan_qr/domain/repository/scan_qr_repo.dart';
import 'package:ifriend_app/features/old/device_linking_scan_qr/data/models/scan_qr_response.dart';

class ScanQrUseCase {
  final ScanQrRepository repository;

  ScanQrUseCase(this.repository);

  Future<ScanQrResponse> call(String qrData) async {
    return repository.scanQr(qrData);
  }
}
