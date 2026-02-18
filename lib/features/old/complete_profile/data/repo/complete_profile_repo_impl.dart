import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ifriend_app/features/old/complete_profile/domain/repo/complete_profile_repo.dart';
import '../dataSource/complete_profile_data_remote.dart';
import '../models/profile_model.dart';
import 'package:ifriend_app/core/networking/api_error_handler.dart';
import 'package:ifriend_app/features/old/complete_profile/domain/entity/profile_entity.dart';

class CompleteProfileRepositoryImpl implements CompleteProfileRepository {
  final CompleteProfileRemoteDataSource remoteDataSource;

  CompleteProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<ApiErrorHandler, ProfileEntity>> createParentProfile({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    File? avatar,
  }) async {
    try {
      final CompleteProfileResponseModel model = await remoteDataSource
          .createParentProfile(
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            email: email,
            avatar: avatar,
          );

      final entity = model.toEntity();
      if (entity == null) {
        return Left(
          ApiErrorHandler(message: 'Failed to parse profile response'),
        );
      }

      return Right(entity);
    } on DioException catch (e) {
      return Left(ApiErrorHandler.fromDioError(e));
    } catch (e) {
      return Left(ApiErrorHandler(message: 'Unexpected error occurred'));
    }
  }
}
