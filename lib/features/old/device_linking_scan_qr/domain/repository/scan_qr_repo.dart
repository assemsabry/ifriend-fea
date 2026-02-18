import 'package:ifriend_app/features/old/device_linking_scan_qr/data/models/scan_qr_response.dart';

abstract class ScanQrRepository {
  Future<ScanQrResponse> scanQr(String qrData);

  Future<bool> confirmLink({required String qrCodeData});
}
