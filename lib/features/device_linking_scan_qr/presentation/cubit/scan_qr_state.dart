import 'package:equatable/equatable.dart';
import '../../data/models/scan_qr_response.dart';

abstract class ScanQrState extends Equatable {
  const ScanQrState();
  @override
  List<Object?> get props => [];
}

class ScanQrInitial extends ScanQrState {}

class ScanQrLoading extends ScanQrState {}

class ScanQrPermissionDenied extends ScanQrState {}

class ScanQrPermissionGranted extends ScanQrState {}

class ScanQrSuccess extends ScanQrState {
  final ScanQrResponse response;
  const ScanQrSuccess(this.response);
  @override
  List<Object?> get props => [response];
}

class ScanQrFailure extends ScanQrState {
  final String message;
  const ScanQrFailure(this.message);
  @override
  List<Object?> get props => [message];
}
