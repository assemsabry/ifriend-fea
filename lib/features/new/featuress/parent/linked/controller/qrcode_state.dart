part of 'qrcode_cubit.dart';

@immutable
abstract class QrCodeState {}

class QrCodeInitial extends QrCodeState {}

class QrCodePageChanged extends QrCodeState {}

class QrCodeTypeChanged extends QrCodeState {}

class QrCodePermissionGranted extends QrCodeState {}

class QrCodePermissionDenied extends QrCodeState {}

class QrCodeFailure extends QrCodeState {
  final String message;
  QrCodeFailure(this.message);
}

class ScanQrCodeSuccess extends QrCodeState {
  final SuccessScanModel scanModel;
  ScanQrCodeSuccess(this.scanModel);
}

class ScanQrCodeLoading extends QrCodeState {}

class ScanQrCodeFailure extends QrCodeState {
  final String message;
  ScanQrCodeFailure(this.message);
}

class QrCodeConfirmFailure extends QrCodeState {
  final String message;
  QrCodeConfirmFailure(this.message);
}

class QrCodeConfirmSuccess extends QrCodeState {}

class QrCodeConfirmLoading extends QrCodeState {}

class QrCodeIsLoadingWidget extends QrCodeState {}
