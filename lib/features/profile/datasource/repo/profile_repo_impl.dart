import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ifriend_app/core/networking/api_error_handler.dart';
import 'package:ifriend_app/features/profile/datasource/data/data_profile_remote.dart';
import 'package:ifriend_app/features/profile/domain/repo/profile_repo.dart';
import 'package:ifriend_app/features/profile/datasource/model/ResponseProfileModel.dart';
import 'package:ifriend_app/features/complete_profile/domain/entity/profile_entity.dart';
import 'dart:io';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<ApiErrorHandler, ProfileEntity>> getParentProfile() async {
    try {
      final ResponseProfileModel model = await remoteDataSource.getParentProfile();

      // Convert to entity using the existing CompleteProfile mapping
      final profileModel = model.data?.profile;
      if (profileModel == null) {
        return Left(ApiErrorHandler(message: 'Profile not found'));
      }

      final entity = ProfileEntity(
        id: profileModel.id ?? '',
        userId: profileModel.userId ?? '',
        firstName: profileModel.firstName ?? '',
        lastName: profileModel.lastName ?? '',
        phoneNumber: profileModel.phoneNumber ?? '',
        avatarUrl: profileModel.avatarUrl?.toString(),
        createdAt: profileModel.createdAt,
        updatedAt: profileModel.updatedAt,
        updatedUser: profileModel.user != null
            ? UpdatedUserEntity(
                id: profileModel.user?.id ?? '',
                email: profileModel.user?.email ?? '',
                providerId: null,
                userType: profileModel.user?.userType,
                authProvider: null,
                createdAt: null,
                updatedAt: null,
              )
            : null,
      );

      return Right(entity);
    } on DioException catch (e) {
      return Left(ApiErrorHandler.fromDioError(e));
    } catch (e) {
      return Left(ApiErrorHandler(message: 'Unexpected error occurred'));
    }
  }

  @override
  Future<Either<ApiErrorHandler, ProfileEntity>> updateParentProfile({required String firstName, required String lastName, required String phoneNumber, required String email, File? avatar}) async {
    try {
      final ResponseProfileModel model = await remoteDataSource.updateParentProfile(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        email: email,
        avatar: avatar,
      );

      final profileModel = model.data?.profile;
      if (profileModel == null) {
        return Left(ApiErrorHandler(message: 'Failed to parse updated profile'));
      }

      final entity = ProfileEntity(
        id: profileModel.id ?? '',
        userId: profileModel.userId ?? '',
        firstName: profileModel.firstName ?? '',
        lastName: profileModel.lastName ?? '',
        phoneNumber: profileModel.phoneNumber ?? '',
        avatarUrl: profileModel.avatarUrl?.toString(),
        createdAt: profileModel.createdAt,
        updatedAt: profileModel.updatedAt,
        updatedUser: profileModel.user != null
            ? UpdatedUserEntity(
                id: profileModel.user?.id ?? '',
                email: profileModel.user?.email ?? '',
                providerId: null,
                userType: profileModel.user?.userType,
                authProvider: null,
                createdAt: null,
                updatedAt: null,
              )
            : null,
      );

      return Right(entity);
    } on DioException catch (e) {
      return Left(ApiErrorHandler.fromDioError(e));
    } catch (e) {
      return Left(ApiErrorHandler(message: 'Unexpected error occurred'));
    }
  }
}
