import 'package:dio/dio.dart';

class ApiErrorHandler {
  final String? message; // nullable: null means "silent" (don't show to user)
  final int? statusCode;

  ApiErrorHandler({
    required this.message,
    this.statusCode,
  });

  factory ApiErrorHandler.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiErrorHandler(
          message: 'Connection timeout. Please try again.',
          statusCode: null,
        );
      case DioExceptionType.badResponse:
        return ApiErrorHandler._fromResponse(error.response, error.requestOptions);
      case DioExceptionType.cancel:
        return ApiErrorHandler(
          message: 'Request cancelled',
          statusCode: null,
        );
      default:
        return ApiErrorHandler(
          message: 'Network error. Please check your connection.',
          statusCode: null,
        );
    }
  }

  factory ApiErrorHandler._fromResponse(Response? response, RequestOptions? requestOptions) {
    if (response == null) {
      return ApiErrorHandler(
        message: 'Unknown error occurred',
        statusCode: null,
      );
    }

    final data = response.data;
    String? message = 'An error occurred';

    // If the request was marked as session_expired, return a silent error
    if (requestOptions != null && (requestOptions.extra['session_expired'] == true)) {
      return ApiErrorHandler(message: null, statusCode: response.statusCode);
    }

    // Some APIs return structured error with a code, handle TOKEN_EXPIRED centrally
    try {
      if (data is Map<String, dynamic>) {
        final errorObj = data['error'];
        if (errorObj is Map<String, dynamic>) {
          final code = errorObj['code'];
          if (code is String && code.toUpperCase() == 'TOKEN_EXPIRED') {
            // Make this silent — the interceptor has already handled refresh/logout
            return ApiErrorHandler(message: null, statusCode: response.statusCode);
          }
        }
      }
    } catch (_) {}

    if (data is Map<String, dynamic>) {
      // Try several common error fields safely and ensure we only assign Strings
      dynamic msgValue = data['message'] ?? data['error'] ?? data['detail'] ?? data['errors'] ?? data['error_description'];

      if (msgValue != null) {
        if (msgValue is String) {
          message = msgValue;
        } else if (msgValue is Map) {
          // If it's a nested map, try to extract a string message from common keys
          final nested = msgValue['message'] ?? msgValue['error'] ?? msgValue['detail'];
          if (nested is String) {
            message = nested;
          } else {
            // Fallback to a string representation
            message = nested?.toString() ?? msgValue.toString();
          }
        } else if (msgValue is List) {
          // Join lists into a readable string
          try {
            message = msgValue.map((e) => e.toString()).join(', ');
          } catch (_) {
            message = msgValue.toString();
          }
        } else {
          // Final fallback: convert whatever it is to a string
          message = msgValue.toString();
        }
      } else {
        // If no common keys, attempt to use response.statusMessage if available
        if (response.statusMessage != null && response.statusMessage!.isNotEmpty) {
          message = response.statusMessage!;
        }
      }
    } else if (data is String) {
      // Some APIs return a plain string body
      message = data;
    } else {
      // Fallback to response.statusMessage if present
      if (response.statusMessage != null && response.statusMessage!.isNotEmpty) {
        message = response.statusMessage!;
      }
    }

    return ApiErrorHandler(
      message: message,
      statusCode: response.statusCode,
    );
  }

  @override
  String toString() => message ?? '';
}