import 'package:equatable/equatable.dart';
import 'package:ifriend_app/features/login/domain/entities/login_entity.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final LoginEntity loginData;

  const LoginSuccess(this.loginData);

  @override
  List<Object?> get props => [loginData];
}

class LoginError extends LoginState {
  final String message;

  const LoginError(this.message);

  @override
  List<Object?> get props => [message];
}
