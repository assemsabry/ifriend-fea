import 'package:ifriend_app/features/old/device_linking_scan_qr/domain/repository/scan_qr_repo.dart';

class ConfirmLinkUseCase {
  final ScanQrRepository repository;

  ConfirmLinkUseCase(this.repository);

  Future<bool> call({required String qrCodeData}) async {
    return await repository.confirmLink(qrCodeData: qrCodeData);
  }
}
