import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/features/old/login/domain/usecases/login_with_facebook.dart';
import 'package:ifriend_app/features/old/login/domain/usecases/login_with_google.dart';
import 'package:ifriend_app/features/old/login/domain/usecases/register_device.dart';
import 'package:ifriend_app/features/old/login/presentation/bloc/login_event.dart';
import 'package:ifriend_app/features/old/login/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginWithGoogleUseCase loginWithGoogleUseCase;
  final LoginWithFacebookUseCase loginWithFacebookUseCase;
  final RegisterDeviceUseCase registerDeviceUseCase;

  LoginBloc({
    required this.loginWithGoogleUseCase,
    required this.loginWithFacebookUseCase,
    required this.registerDeviceUseCase,
  }) : super(const LoginInitial()) {
    on<LoginWithGoogleEvent>(_onLoginWithGoogle);
    on<LoginWithFacebookEvent>(_onLoginWithFacebook);
    on<RegisterDeviceEvent>(_onRegisterDevice);
  }

  Future<void> _onLoginWithGoogle(
    LoginWithGoogleEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());

    final result = await loginWithGoogleUseCase(
      idToken: event.idToken,
      role: event.role,
    );

    result.fold(
      (error) => emit(LoginError(error.message ?? '')),
      (loginData) => emit(LoginSuccess(loginData)),
    );
  }

  Future<void> _onLoginWithFacebook(
    LoginWithFacebookEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());

    final result = await loginWithFacebookUseCase(
      accessToken: event.accessToken,
      role: event.role,
    );

    result.fold(
      (error) => emit(LoginError(error.message ?? '')),
      (loginData) => emit(LoginSuccess(loginData)),
    );
  }

  Future<void> _onRegisterDevice(
    RegisterDeviceEvent event,
    Emitter<LoginState> emit,
  ) async {
    // We don't change the login state UI for device registration; keep it lightweight
    final result = await registerDeviceUseCase();
    result.fold(
      (error) => emit(LoginError(error.message ?? 'Failed to register device')),
      (_) => emit(const LoginInitial()),
    );
  }
}
