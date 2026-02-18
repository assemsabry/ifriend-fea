import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ifriend_app/core/services/endpoint.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.api,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 40),
        receiveTimeout: const Duration(seconds: 40),
        sendTimeout: const Duration(seconds: 40),
        headers: {'Content-Type': 'application/json'},
        validateStatus: (status) {
          return status != null && status < 600;
        },
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',

      if (token != null) 'Authorization': 'Bearer $token',
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    bool? option,
    String? token,
    String? lang,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      // if (lang != null) 'Accept-Language': lang,
    };

    int retryCount = 3;
    for (int i = 0; i < retryCount; i++) {
      try {
        final response = await dio.post(
          url,
          data: data,
          queryParameters: query,

          options: Options(
            receiveTimeout: const Duration(seconds: 90), // 10 sec timeout
            sendTimeout: const Duration(seconds: 90),
          ),
        );
        if (kDebugMode) {
          log('Data: ${jsonEncode(data)}');
        }
        if (kDebugMode) {
          log('Response: ${response.data}');
        }
        return response;
      } on DioException catch (e) {
        if (e.response?.statusCode == 503 && i < retryCount - 1) {
          if (kDebugMode) {
            print('503 error, retrying (${i + 1}/$retryCount)...');
          }
          await Future.delayed(const Duration(seconds: 2));
          continue;
        }
        throw Exception('Failed to send data: ${e.message}');
      }
    }
    throw Exception('Request failed after multiple attempts');
  }

  static Future<Response> postDataWithFile({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    File? file,
    String? token,
    String? fileKey,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    try {
      if (kDebugMode) {
        print('Sending data: $data');
      }

      FormData formData = FormData.fromMap({
        ...data,
        if (file != null)
          fileKey ?? "avatar": await MultipartFile.fromFile(file.path),

        //  filename: file.path.split('/').last),
      });
      if (kDebugMode) {
        print(file);
      }
      print(formData.fields);
      print(formData.files);

      final response = await dio.post(
        url,
        data: formData,
        queryParameters: query,
      );

      if (kDebugMode) {
        print('Response: ${response.data}');
      }

      return response;
    } catch (e) {
      if (kDebugMode) {
        log('Erroreeeeeeeeeeeeee: $e');
      }

      rethrow;
    }
  }

  static Future<Response> postDataWithFiles({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    List<File>? files,
    String? token,
    String fileKey = "mediaFiles",
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    try {
      final formData = FormData();

      data.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });

      if (files != null && files.isNotEmpty) {
        for (var file in files) {
          formData.files.add(
            MapEntry(
              "mediaFiles",
              await MultipartFile.fromFile(
                file.path,
                //filename: file.path.split('/').last,
              ),
            ),
          );
        }
      }

      return await dio.post(url, data: formData, queryParameters: query);
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> deleteData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    return await dio.delete(
      url,
      options: Options(
        headers: {
          "Accept": "application/json",
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ),
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    return await dio.patch(
      url,

      options: Options(
        headers: {
          "Accept": "application/json",
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ),
      data: data,
    );
  }
}
