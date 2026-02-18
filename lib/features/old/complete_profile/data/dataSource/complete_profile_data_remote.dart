// Remote data source for complete profile
import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ifriend_app/core/di/injection.dart';

import '../../../../../core/networking/api_constants.dart';
import '../models/profile_model.dart';

class CompleteProfileRemoteDataSource {
  final Dio _dio = sl<Dio>();

  Future<CompleteProfileResponseModel> createParentProfile({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    File? avatar,
  }) async {
    // Backend expects a JSON object. Convert avatar (if provided) to a base64
    // string (no data URI / http prefix) and send as JSON.
    final Map<String, dynamic> body = {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
    };

    if (avatar != null) {
      final bytes = await avatar.readAsBytes();
      final base64Image = base64Encode(bytes);
      // include only the base64 string as requested (no http or data: prefix)
      body['avatar'] = base64Image;
    }

    final response = await _dio.post(
      ApiConstants.createParentProfile,
      data: jsonEncode(body),
      options: Options(contentType: Headers.jsonContentType),
    );

    // Parse response into model
    if (response.data is Map<String, dynamic>) {
      return CompleteProfileResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    }

    // If response.data is a String (sometimes Dio returns decoded string), try to decode
    try {
      final decoded = jsonDecode(response.data.toString());
      if (decoded is Map<String, dynamic>) {
        return CompleteProfileResponseModel.fromJson(decoded);
      }
    } catch (_) {}

    // Fallback: return empty
    return CompleteProfileResponseModel(profile: null, updatedUser: null);
  }
}
