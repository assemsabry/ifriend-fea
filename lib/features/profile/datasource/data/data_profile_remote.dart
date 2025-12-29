import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ifriend_app/core/di/injection.dart';
import 'package:ifriend_app/core/networking/api_constants.dart';
import '../model/ResponseProfileModel.dart';

class ProfileRemoteDataSource {
  final Dio _dio = sl<Dio>();

  Future<ResponseProfileModel> getParentProfile() async {
    final response = await _dio.get(ApiConstants.getParentProfile);

    if (response.data is Map<String, dynamic>) {
      return ResponseProfileModel.fromJson(response.data as Map<String, dynamic>);
    }

    try {
      // sometimes Dio returns decoded string
      return ResponseProfileModel.fromJson(response.data);
    } catch (_) {
      return ResponseProfileModel();
    }
  }

  Future<ResponseProfileModel> updateParentProfile({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    File? avatar,
  }) async {
    final Map<String, dynamic> body = {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
    };

    if (avatar != null) {
      final bytes = await avatar.readAsBytes();
      final base64Image = base64Encode(bytes);
      body['avatar'] = base64Image;
    }

    final response = await _dio.put(
      ApiConstants.updateParentProfile,
      data: jsonEncode(body),
      options: Options(contentType: Headers.jsonContentType),
    );

    if (response.data is Map<String, dynamic>) {
      return ResponseProfileModel.fromJson(response.data as Map<String, dynamic>);
    }

    try {
      return ResponseProfileModel.fromJson(response.data);
    } catch (_) {
      return ResponseProfileModel();
    }
  }
}
