import 'package:equatable/equatable.dart';
import '../../domain/entities/child_qr_code_entity.dart';

abstract class DeviceLinkState extends Equatable {
  const DeviceLinkState();
  
  @override
  List<Object> get props => [];
}

class DeviceLinkInitial extends DeviceLinkState {}

class DeviceLinkLoading extends DeviceLinkState {}

class DeviceLinkQrLoaded extends DeviceLinkState {
  final ChildQrCodeEntity qrCode;

  const DeviceLinkQrLoaded({required this.qrCode});

  @override
  List<Object> get props => [qrCode];
}

class DeviceLinkError extends DeviceLinkState {
  final String message;

  const DeviceLinkError({required this.message});

  @override
  List<Object> get props => [message];
}
