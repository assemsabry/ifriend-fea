import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ifriend_app/core/networking/api_error_handler.dart';
import 'package:ifriend_app/features/complete_profile/domain/entity/profile_entity.dart';
import 'package:ifriend_app/features/complete_profile/domain/repo/complete_profile_repo.dart';

class CreateParentProfileUseCase {
  final CompleteProfileRepository repository;

  CreateParentProfileUseCase(this.repository);

  Future<Either<ApiErrorHandler, ProfileEntity>> call({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    File? avatar,
  }) async {
    return await repository.createParentProfile(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
      avatar: avatar,
    );
  }
}
