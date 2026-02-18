import 'package:equatable/equatable.dart';

abstract class DeviceLinkEvent extends Equatable {
  const DeviceLinkEvent();

  @override
  List<Object> get props => [];
}

class GenerateQrToken extends DeviceLinkEvent {}
