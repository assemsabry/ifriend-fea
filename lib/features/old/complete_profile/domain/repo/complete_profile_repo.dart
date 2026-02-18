import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ifriend_app/core/networking/api_error_handler.dart';

import '../entity/profile_entity.dart';

abstract class CompleteProfileRepository {
  Future<Either<ApiErrorHandler, ProfileEntity>> createParentProfile({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    File? avatar,
  });
}
