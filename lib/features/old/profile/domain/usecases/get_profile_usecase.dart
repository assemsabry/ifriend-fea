import 'package:dartz/dartz.dart';
import 'package:ifriend_app/core/networking/api_error_handler.dart';
import 'package:ifriend_app/features/old/complete_profile/domain/entity/profile_entity.dart';
import 'package:ifriend_app/features/old/profile/domain/repo/profile_repo.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<Either<ApiErrorHandler, ProfileEntity>> call() async {
    return await repository.getParentProfile();
  }
}
