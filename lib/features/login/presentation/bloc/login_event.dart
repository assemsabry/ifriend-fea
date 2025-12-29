import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginWithGoogleEvent extends LoginEvent {
  final String idToken;
  final String role;

  const LoginWithGoogleEvent({
    required this.idToken,
    required this.role,
  });

  @override
  List<Object?> get props => [idToken, role];
}

class LoginWithFacebookEvent extends LoginEvent {
  final String accessToken;
  final String role;

  const LoginWithFacebookEvent({
    required this.accessToken,
    required this.role,
  });

  @override
  List<Object?> get props => [accessToken, role];
}

class RegisterDeviceEvent extends LoginEvent {
  const RegisterDeviceEvent();
}
