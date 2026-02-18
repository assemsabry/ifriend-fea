import 'package:dartz/dartz.dart';
import 'package:ifriend_app/core/networking/api_error_handler.dart';
import 'package:ifriend_app/features/old/login/domain/entities/login_entity.dart';

abstract class LoginRepository {
  Future<Either<ApiErrorHandler, LoginEntity>> loginWithGoogle({
    required String idToken,
    required String role,
  });

  Future<Either<ApiErrorHandler, LoginEntity>> loginWithFacebook({
    required String accessToken,
    required String role,
  });

  Future<Either<ApiErrorHandler, void>> registerDevice();
}
