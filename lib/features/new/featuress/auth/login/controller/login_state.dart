part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class GoogleAuthLoading extends LoginState {}

class GoogleAuthSuccess extends LoginState {
  final LoginModel googleLoginModel;
  GoogleAuthSuccess({required this.googleLoginModel});
}

class GoogleAuthFailure extends LoginState {
  final String error;
  GoogleAuthFailure(this.error);
}

class LoginChangeVisibility extends LoginState {}

class LoginChangeType extends LoginState {}

class LoginChangeButtonColor extends LoginState {}

class LoginClearAllData extends LoginState {}

class LoginLoadingWidget extends LoginState {}
