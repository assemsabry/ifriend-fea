import 'package:dartz/dartz.dart';
import 'package:ifriend_app/core/networking/api_error_handler.dart';
import 'package:ifriend_app/features/old/login/domain/entities/login_entity.dart';
import 'package:ifriend_app/features/old/login/domain/repositories/login_repository.dart';

class LoginWithGoogleUseCase {
  final LoginRepository repository;

  LoginWithGoogleUseCase(this.repository);

  Future<Either<ApiErrorHandler, LoginEntity>> call({
    required String idToken,
    required String role,
  }) {
    return repository.loginWithGoogle(idToken: idToken, role: role);
  }
}
