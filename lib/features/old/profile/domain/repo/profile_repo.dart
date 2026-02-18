import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ifriend_app/core/networking/api_error_handler.dart';
import 'package:ifriend_app/features/old/complete_profile/domain/entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<ApiErrorHandler, ProfileEntity>> getParentProfile();
  Future<Either<ApiErrorHandler, ProfileEntity>> updateParentProfile({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    File? avatar,
  });
}
