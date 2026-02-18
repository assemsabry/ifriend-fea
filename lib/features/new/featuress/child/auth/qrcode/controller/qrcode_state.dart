part of 'qrcode_cubit.dart';

abstract class QrcodeState {}

class QrcodeInitial extends QrcodeState {}

class QrcodeNavigate extends QrcodeState {}

class QrCodeLoadingStates extends QrcodeState {}

class QrCodeSuccessStates extends QrcodeState {}

class GenerateQrCodeLoadingStates extends QrcodeState {}

class GenerateQrCodeSuccessStates extends QrcodeState {
  final GeneratecodeModel generatecodeModel;
  GenerateQrCodeSuccessStates({required this.generatecodeModel});
}

class GenerateQrCodeErrorStates extends QrcodeState {
  final String error;
  GenerateQrCodeErrorStates({required this.error});
}

class QrCodePendingStates extends QrcodeState {}

class QrCodeErrorStates extends QrcodeState {
  final String error;

  QrCodeErrorStates({required this.error});
}
