import 'package:equatable/equatable.dart';

class ChildQrCodeEntity extends Equatable {
  final String qrToken;
  final String expiresAt;

  const ChildQrCodeEntity({
    required this.qrToken,
    required this.expiresAt,
  });

  @override
  List<Object?> get props => [qrToken, expiresAt];
}
