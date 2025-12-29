import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ifriend_app/core/networking/api_error_handler.dart';
import 'package:ifriend_app/features/complete_profile/domain/entity/profile_entity.dart';
import 'package:ifriend_app/features/profile/domain/repo/profile_repo.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<ApiErrorHandler, ProfileEntity>> call({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    File? avatar,
  }) async {
    return await repository.updateParentProfile(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
      avatar: avatar,
    );
  }
}
