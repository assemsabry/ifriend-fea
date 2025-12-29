import 'package:dio/dio.dart';
import 'package:ifriend_app/core/networking/api_constants.dart';
import 'dart:convert';

/// Simple remote data source that calls the `/link/verify-qr` endpoint using Dio.
class ScanQrRemoteDataSource {
  final Dio dio;

  ScanQrRemoteDataSource({required this.dio});

  /// Verifies QR code by extracting qrToken and calling /link/verify-qr
  /// Returns a map with `success`, `data`, or `error` fields
  Future<Map<String, dynamic>> sendQr(String qrData) async {
    try {
      // Extract qrToken from QR data (assuming JSON format)
      String qrToken = qrData;
      try {
        final decoded = jsonDecode(qrData);
        if (decoded is Map && decoded.containsKey('qrToken')) {
          qrToken = decoded['qrToken'];
        }
      } catch (_) {
        // If not JSON, use raw data as token
      }

      final response = await dio.post(
        ApiConstants.scanQr,
        data: {'qrCodeData': qrToken},
      );
      

      
      final data = response.data;
      // If server returned a JSON map, handle properly. Otherwise treat as non-JSON error (HTML/text).
      if (data is Map) {
        // Case 1: Standard wrapped response { "success": true, "data": { ... } }
        if (data['success'] == true) {
          return {'success': true, 'data': data['data']};
        }

        // Case 2: Direct response { "requestId": "...", "child": ... }
        if (data.containsKey('requestId') || data.containsKey('child')) {
          return {'success': true, 'data': data};
        }

        // JSON error response
        return {
          'success': false,
          'error': data['error'] ?? {'message': data['message'] ?? 'Invalid server response', 'code': 'INVALID_RESPONSE'},
        };
      } else {
        // Non-JSON response (e.g. HTML from 404 page). Don't try to index it as a Map.
        final String msg = response.statusMessage ?? data.toString();
        return {
          'success': false,
          'error': {'message': msg, 'code': 'INVALID_RESPONSE'},
        };
      }
    } catch (e) {
      String message = 'An unexpected error occurred';
      if (e is DioException) {
        if (e.response != null && e.response?.data is Map) {
          final data = e.response!.data as Map;
          if (data.containsKey('error') && data['error'] is Map) {
            message = data['error']['message'] ?? e.message ?? message;
          } else if (data.containsKey('message')) {
            message = data['message'];
          } else {
             message = e.message ?? message;
          }
        } else {
           message = e.message ?? message;
        }
      } else {
        message = e.toString();
      }
      
      return {
        'success': false,
        'error': {'message': message, 'code': 'NETWORK_ERROR'},
      };
    }
  }

  /// Calls `/link/confirm` with the given qrToken.
  /// Returns true when the backend responds with a success status.
  Future<bool> confirmLink({
    required String qrCodeData,
  }) async {
    try {
      
      final resp = await dio.post(
        ApiConstants.confirmLink,
        data: {
          'qrCodeData': qrCodeData,
        },
      );
      
      final data = resp.data;
      if (resp.statusCode == 200) {
        if (data is Map && data['success'] == true) {
          return true;
        }
        // Server returned 200 but not success
        final String msg = (data is Map && (data['message'] != null)) ? data['message'].toString() : 'Failed to confirm link';
        throw Exception(msg);
      } else {
        // Non-200 responses may return HTML/text; don't index them as Map.
        final String msg = (data is Map && data['message'] != null)
            ? data['message'].toString()
            : resp.statusMessage ?? data?.toString() ?? 'Failed to confirm link';
        throw Exception(msg);
      }
    } catch (e) {
      // If endpoint returned 404, try legacy endpoint `/link/confirm-link` as a fallback.
      if (e is DioException && e.response?.statusCode == 404) {
        try {
          final fallback = await dio.post(
            '/link/confirm-link',
            data: {
              'qrCodeData': qrCodeData,
            },
          );
          final fdata = fallback.data;
          if (fallback.statusCode == 200 && fdata is Map && fdata['success'] == true) {
            return true;
          }
          final String msg = (fdata is Map && fdata['message'] != null) ? fdata['message'].toString() : fallback.statusMessage ?? 'Failed to confirm link (fallback)';
          throw Exception(msg);
        } catch (ex) {
          String msg2 = 'Connection error';
          if (ex is DioException) {
            msg2 = ex.response?.data?['message'] ?? ex.response?.data?['error']?['message'] ?? ex.message ?? 'Server error';
          } else {
            msg2 = ex.toString();
          }
          throw Exception(msg2);
        }
      }

      String msg = 'Connection error';
      if (e is DioException) {
         msg = e.response?.data?['message'] ?? e.response?.data?['error']?['message'] ?? e.message ?? 'Server error';
      } else {
        msg = e.toString();
      }
      throw Exception(msg);
    }
  }
}
