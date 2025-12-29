import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:ifriend_app/core/networking/api_error_handler.dart';
import 'package:ifriend_app/features/login/data/datasources/login_api_service.dart';
import 'package:ifriend_app/features/login/data/models/login_request.dart';
import 'package:ifriend_app/features/login/data/models/login_response.dart';
import 'package:ifriend_app/features/login/domain/entities/login_entity.dart';
import 'package:ifriend_app/features/login/domain/repositories/login_repository.dart';
import 'package:uuid/uuid.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginApiService apiService;

  LoginRepositoryImpl(this.apiService);

  @override
  Future<Either<ApiErrorHandler, LoginEntity>> loginWithGoogle({
    required String idToken,
    required String role,
  }) async {
    try {
      final request = GoogleLoginRequest(idToken: idToken, role: role);
      final response = await apiService.loginWithGoogle(request);
      return Right(_mapToEntity(response));
    } on DioException catch (e) {
      return Left(ApiErrorHandler.fromDioError(e));
    } catch (e) {
      return Left(ApiErrorHandler(message: 'Unexpected error occurred'));
    }
  }

  @override
  Future<Either<ApiErrorHandler, LoginEntity>> loginWithFacebook({
    required String accessToken,
    required String role,
  }) async {
    try {
      final request = FacebookLoginRequest(
        accessToken: accessToken,
        role: role,
      );
      final response = await apiService.loginWithFacebook(request);
      return Right(_mapToEntity(response));
    } on DioException catch (e) {
      return Left(ApiErrorHandler.fromDioError(e));
    } catch (e) {
      return Left(ApiErrorHandler(message: 'Unexpected error occurred'));
    }
  }

  LoginEntity _mapToEntity(LoginResponse response) {
    return _LoginEntityImpl(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
      user: UserEntity(
        id: response.user.id,
        email: response.user.email,
        profilePicture: response.user.profilePicture,
        role: response.user.role ?? '',
        profileCompleted: response.user.profileCompleted ?? false,
        firstName: response.user.firstName ?? '',
        lastName: response.user.lastName ?? '',
      ),
    );
  }

  @override
  Future<Either<ApiErrorHandler, void>> registerDevice() async {
    final request = RegisterDeviceRequest(
      deviceName: await _getDeviceName(),
      deviceType: "mobile",
      fcmToken: "fcmToken",
      deviceIdentifier: await _getDeviceId(),
    );
    try {
      await apiService.registerDevice(request);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiErrorHandler.fromDioError(e));
    } catch (e) {
      return Left(ApiErrorHandler(message: e.toString()));
    }
  }
}

class _LoginEntityImpl extends LoginEntity {
  const _LoginEntityImpl({
    required super.accessToken,
    required super.refreshToken,
    required super.user,
  });
}

Future<String> _getDeviceId() async {
  final deviceInfo = DeviceInfoPlugin();
  String deviceId;

  try {
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id; // androidId
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? const Uuid().v4();
    } else {
      deviceId = const Uuid().v4();
    }
  } catch (e) {
    deviceId = const Uuid().v4();
  }
  return deviceId;
}

Future<String> _getDeviceType() async {
  final deviceInfo = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.isPhysicalDevice ? "mobile" : "tablet";
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.name;
    }
    return "mobile";
  } catch (_) {
    return "mobile";
  }
}

Future<String> _getDeviceName() async {
  final deviceInfo = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return '${androidInfo.manufacturer} ${androidInfo.model}';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.name;
    }
    return "Unknown Device";
  } catch (_) {
    return "Unknown Device";
  }
}
