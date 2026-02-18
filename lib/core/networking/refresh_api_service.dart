import 'package:dio/dio.dart';
import 'package:ifriend_app/core/networking/models/refresh_token_request.dart';
import 'package:ifriend_app/features/old/login/data/models/login_response.dart';
import 'package:retrofit/retrofit.dart';
part 'refresh_api_service.g.dart';

@RestApi()
abstract class RefreshApiService {
  factory RefreshApiService(Dio dio, {String baseUrl}) = _RefreshApiService;

  @POST('/auth/refresh')
  Future<LoginResponse> refreshToken(@Body() RefreshTokenRequest request);
}
