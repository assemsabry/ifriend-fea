import 'package:dartz/dartz.dart';
import 'package:ifriend_app/core/networking/api_error_handler.dart';
import 'package:ifriend_app/features/old/login/domain/repositories/login_repository.dart';

class RegisterDeviceUseCase {
  final LoginRepository repository;

  RegisterDeviceUseCase(this.repository);

  Future<Either<ApiErrorHandler, void>> call() {
    return repository.registerDevice();
  }
}
