import 'package:dartz/dartz.dart';
import 'package:ifriend_app/core/networking/api_error_handler.dart';
import 'package:ifriend_app/features/login/domain/entities/login_entity.dart';
import 'package:ifriend_app/features/login/domain/repositories/login_repository.dart';

class LoginWithFacebookUseCase {
  final LoginRepository repository;

  LoginWithFacebookUseCase(this.repository);

  Future<Either<ApiErrorHandler, LoginEntity>> call({
    required String accessToken,
    required String role,
  }) {
    return repository.loginWithFacebook(accessToken: accessToken, role: role);
  }
}
