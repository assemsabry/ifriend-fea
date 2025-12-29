import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:ifriend_app/features/device_linking_scan_qr/data/datasources/scan_qr_data_remote.dart';
import 'package:ifriend_app/features/device_linking_scan_qr/domain/repository/scan_qr_repo.dart';
import 'package:ifriend_app/features/device_linking_scan_qr/data/models/scan_qr_response.dart';

class ScanQrRepositoryImpl implements ScanQrRepository {
  final ScanQrRemoteDataSource remote;

  ScanQrRepositoryImpl({required this.remote});

  @override
  Future<ScanQrResponse> scanQr(String qrData) async {
    final response = await remote.sendQr(qrData);
    return ScanQrResponse.fromJson(response);
  }

  @override
  Future<bool> confirmLink({required String qrCodeData}) async {

    
    return await remote.confirmLink(
      qrCodeData: qrCodeData,
    );
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
}
