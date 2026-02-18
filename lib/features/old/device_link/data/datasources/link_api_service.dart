import 'package:dio/dio.dart';
import 'package:ifriend_app/core/networking/api_constants.dart';
import 'package:retrofit/retrofit.dart';
import '../models/generate_qr_request.dart';
import '../models/generate_qr_response.dart';

part 'link_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class LinkApiService {
  factory LinkApiService(Dio dio, {String baseUrl}) = _LinkApiService;

  @POST(ApiConstants.generateQr)
  Future<GenerateQrResponse> generateQr(@Body() GenerateQrRequest request);
}
