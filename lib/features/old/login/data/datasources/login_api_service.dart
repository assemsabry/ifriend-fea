import 'package:dio/dio.dart';
import 'package:ifriend_app/core/networking/api_constants.dart';
import 'package:ifriend_app/features/old/login/data/models/login_request.dart';
import 'package:ifriend_app/features/old/login/data/models/login_response.dart';
import 'package:ifriend_app/core/networking/models/refresh_token_request.dart';
import 'package:retrofit/retrofit.dart';

part 'login_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class LoginApiService {
  factory LoginApiService(Dio dio, {String baseUrl}) = _LoginApiService;

  @POST(ApiConstants.googleLogin)
  Future<LoginResponse> loginWithGoogle(@Body() GoogleLoginRequest request);

  @POST(ApiConstants.facebookLogin)
  Future<LoginResponse> loginWithFacebook(@Body() FacebookLoginRequest request);

  @POST(ApiConstants.refreshToken)
  Future<LoginResponse> refreshToken(@Body() RefreshTokenRequest request);

  @POST(ApiConstants.registerDevice)
  Future<void> registerDevice(@Body() RegisterDeviceRequest request);
}
