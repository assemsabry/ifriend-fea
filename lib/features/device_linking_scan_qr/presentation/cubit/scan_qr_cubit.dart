import 'package:bloc/bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'scan_qr_state.dart';
import 'package:ifriend_app/features/device_linking_scan_qr/domain/usecases/scan_qr_usecase.dart';
import 'package:ifriend_app/features/device_linking_scan_qr/data/models/scan_qr_response.dart';

class ScanQrCubit extends Cubit<ScanQrState> {
  final ScanQrUseCase usecase;

  ScanQrCubit({required this.usecase}) : super(ScanQrInitial());

  Future<void> checkAndRequestPermission() async {
    // Check current status
    var status = await Permission.camera.status;
    if (status.isGranted) {
      emit(ScanQrPermissionGranted());
      return;
    }

    // Request permission
    status = await Permission.camera.request();

    if (status.isGranted) {
      emit(ScanQrPermissionGranted());
    } else if (status.isPermanentlyDenied) {
      emit(ScanQrPermissionDenied());
    } else {
      // Denied but not permanently
      emit(ScanQrFailure('Camera permission denied'));
    }
  }

  Future<void> onBarcodeDetected(String qrData) async {
    final current = state;
    if (current is ScanQrLoading) return;

    emit(ScanQrLoading());
    try {
      final ScanQrResponse res = await usecase.call(qrData);
      if (res.success) {
        emit(ScanQrSuccess(res));
      } else if (res.error != null) {
        emit(ScanQrFailure(res.error!.message));
      } else {
        emit(ScanQrFailure(res.message ?? 'Unknown server error'));
      }
    } catch (e) {
      emit(ScanQrFailure(e.toString()));
    }
  }

  void resetScan() {
    emit(ScanQrInitial());
  }
}
