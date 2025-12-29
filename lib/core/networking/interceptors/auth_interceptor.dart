import 'package:dio/dio.dart';
import 'package:ifriend_app/core/helpers/auth_local_datasource.dart';
import 'package:ifriend_app/core/networking/api_constants.dart';
import 'package:ifriend_app/core/networking/models/refresh_token_request.dart';
import 'package:ifriend_app/features/login/data/models/login_response.dart';
import 'package:ifriend_app/core/services/navigation_service.dart';
import 'dart:async';
import 'dart:convert';

class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource _authLocalDataSource;
  final Dio _dio; // Main Dio instance might be needed or we create a temp one for refresh

  // Shared future so concurrent 401 requests wait on the same refresh
  Future<LoginResponse>? _refreshingFuture;

  AuthInterceptor(this._authLocalDataSource, this._dio);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var token = _authLocalDataSource.getAccessToken();

    // Debug log to help diagnose missing Authorization header and token state
    try {
      if (token != null && token.isNotEmpty) {
        final masked = token.length > 10 ? '${token.substring(0, 6)}...${token.substring(token.length - 4)}' : token;
        print('AuthInterceptor: attaching access token (masked): $masked');
      } else {
        print('AuthInterceptor: no access token found in AuthLocalDataSource');
      }
    } catch (_) {}

    // If we have a token, proactively check its expiry. If expired, try to refresh before sending the request.
    if (token != null && token.isNotEmpty && _isTokenExpired(token)) {
      print('AuthInterceptor: access token appears expired, attempting refresh before request');

      final refreshToken = _authLocalDataSource.getRefreshToken();
      if (refreshToken == null) {
        // No refresh token -> force logout
        await _handleRefreshFailureOnRequest(options, handler);
        return;
      }

      try {
        // Use shared future so multiple concurrent requests wait on same refresh
        _refreshingFuture ??= _refreshToken(refreshToken);
        final future = _refreshingFuture!;
        LoginResponse newTokens;
        try {
          newTokens = await future;
        } finally {
          _refreshingFuture = null;
        }

        // Save new tokens and user info if available
        try {
          await _authLocalDataSource.saveAuthData(
            accessToken: newTokens.accessToken,
            refreshToken: newTokens.refreshToken,
            userId: newTokens.user.id,
            email: newTokens.user.email,
            firstName: newTokens.user.firstName ?? newTokens.user.name ?? '',
            lastName: newTokens.user.lastName ?? '',
            role: newTokens.user.role ?? '',
            profilePicture: newTokens.user.profilePicture,
          );
        } catch (_) {
          // Fallback: at least save tokens
          await _authLocalDataSource.saveTokens(accessToken: newTokens.accessToken, refreshToken: newTokens.refreshToken);
        }

        token = newTokens.accessToken;

        try {
          final masked = token.length > 10 ? '${token.substring(0, 6)}...${token.substring(token.length - 4)}' : token;
          print('AuthInterceptor: refresh successful, new access token (masked): $masked');
        } catch (_) {}
      } catch (e) {
        // Refresh failed -> logout and stop the request
        await _handleRefreshFailureOnRequest(options, handler);
        return;
      }
    }

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  // Helper to decode JWT and check exp claim (with small leeway)
  bool _isTokenExpired(String token, {int leewaySeconds = 30}) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return false;
      var payload = parts[1];
      // Add padding if needed for base64 decoding
      switch (payload.length % 4) {
        case 2:
          payload += '==';
          break;
        case 3:
          payload += '=';
          break;
        case 1:
          payload += '===';
          break;
        default:
          break;
      }
      final decoded = utf8.decode(base64Url.decode(payload));
      final Map<String, dynamic> map = json.decode(decoded) as Map<String, dynamic>;
      final expRaw = map['exp'];
      int? exp;
      if (expRaw is int) exp = expRaw;
      if (expRaw is String) exp = int.tryParse(expRaw);
      if (exp == null) return false;
      final now = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
      return now >= (exp - leewaySeconds);
    } catch (_) {
      // If we can't parse token, assume it's expired so we attempt a refresh proactively.
      return true;
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Only attempt refresh for 401 unauthorized from server AND when the server indicates TOKEN_EXPIRED
    if (err.response?.statusCode == 401) {
      // Avoid retry loops
      final alreadyRetried = (err.requestOptions.extra['retried'] == true);
      if (alreadyRetried) {
        handler.next(err);
        return;
      }

      bool isTokenExpired = false;
      try {
        final data = err.response?.data;
        if (data is Map<String, dynamic>) {
          final errorObj = data['error'];
          if (errorObj is Map<String, dynamic>) {
            final code = errorObj['code'];
            if (code is String && code.toUpperCase() == 'TOKEN_EXPIRED') {
              isTokenExpired = true;
            }
          }
        }
      } catch (_) {}

      if (!isTokenExpired) {
        // Not a token-expiry issue, don't attempt refresh here
        handler.next(err);
        return;
      }

      final refreshToken = _authLocalDataSource.getRefreshToken();
      if (refreshToken == null) {
        // No refresh token -> force logout
        await _handleRefreshFailure(err, handler);
        return;
      }

      try {
        // Use shared future to avoid multiple refresh calls. Subsequent 401s will await this future.
        _refreshingFuture ??= _refreshToken(refreshToken);

        final future = _refreshingFuture!;
        LoginResponse newTokens;
        try {
          newTokens = await future;
        } catch (e) {
          // Refresh failed
          await _handleRefreshFailure(err, handler);
          return;
        } finally {
          // ensure we clear the shared future so subsequent cycles can start a new refresh
          _refreshingFuture = null;
        }

        // Save new tokens and user info if available
        try {
          await _authLocalDataSource.saveAuthData(
            accessToken: newTokens.accessToken,
            refreshToken: newTokens.refreshToken,
            userId: newTokens.user.id,
            email: newTokens.user.email,
            firstName: newTokens.user.firstName ?? newTokens.user.name ?? '',
            lastName: newTokens.user.lastName ?? '',
            role: newTokens.user.role ?? '',
            profilePicture: newTokens.user.profilePicture,
          );
        } catch (_) {
          // Fallback: at least save tokens
          await _authLocalDataSource.saveTokens(accessToken: newTokens.accessToken, refreshToken: newTokens.refreshToken);
        }

        // Retry the failed request with new token
        final opts = err.requestOptions;
        final requestOptions = Options(
          method: opts.method,
          // copy other important fields
          responseType: opts.responseType,
          contentType: opts.contentType,
          extra: (() {
            final m = Map<String, dynamic>.from(opts.extra);
            m['retried'] = true;
            return m;
          })(),
          followRedirects: opts.followRedirects,
          validateStatus: opts.validateStatus,
          receiveDataWhenStatusError: opts.receiveDataWhenStatusError,
          sendTimeout: opts.sendTimeout,
          receiveTimeout: opts.receiveTimeout,
        );

        // Ensure headers exist and set Authorization on the options used for retry
        final headers = Map<String, dynamic>.from(opts.headers);
        headers['Authorization'] = 'Bearer ${newTokens.accessToken}';
        requestOptions.headers = headers;

        // Debug: show what we'll send with retry
        try {
          final masked = newTokens.accessToken.length > 10 ? '${newTokens.accessToken.substring(0, 6)}...${newTokens.accessToken.substring(newTokens.accessToken.length - 4)}' : newTokens.accessToken;
          print('AuthInterceptor: retrying request ${opts.path} with Authorization: Bearer $masked');
          print('AuthInterceptor: retry headers: ${requestOptions.headers}');
        } catch (_) {}

        final response = await _dio.request(
          opts.path,
          data: opts.data,
          queryParameters: opts.queryParameters,
          options: requestOptions,
          cancelToken: opts.cancelToken,
          onReceiveProgress: opts.onReceiveProgress,
          onSendProgress: opts.onSendProgress,
        );

        return handler.resolve(response);
      } catch (e) {
        // Any unexpected error during refresh flow -> force logout
        await _handleRefreshFailure(err, handler);
        return;
      }
    }

    handler.next(err);
  }

  Future<void> _handleRefreshFailure(DioException err, ErrorInterceptorHandler handler) async {
    try {
      await _authLocalDataSource.clear();
    } catch (_) {}
    // Navigate to login using global navigator so user doesn't see raw errors
    NavigationService.navigateToLoginAndClearStack();
    handler.next(err);
  }

  // Separate handler for request-time failures where we only have a RequestInterceptorHandler
  Future<void> _handleRefreshFailureOnRequest(RequestOptions reqOptions, RequestInterceptorHandler handler) async {
    // If refresh fails before sending the request, DO NOT cancel or remove the
    // Authorization header. Keep the existing header (even if expired) so the
    // server can respond with a 401 and an error code (e.g., TOKEN_EXPIRED)
    // which allows the onError handler to perform the refresh/ retry flow.
    try {
      print('AuthInterceptor: refresh failed during onRequest — keeping existing Authorization header and proceeding');
    } catch (_) {}

    // Ensure we attach the existing access token (if any) to the outgoing
    // request headers — before we proceed — because earlier we set the header
    // only after the expiry/refresh branch. If refresh failed, attach the old
    // token so server sees it and can return a clear TOKEN_EXPIRED error.
    try {
      final existingToken = _authLocalDataSource.getAccessToken();
      if (existingToken != null && existingToken.isNotEmpty) {
        final headers = Map<String, dynamic>.from(reqOptions.headers);
        headers['Authorization'] = 'Bearer $existingToken';
        reqOptions.headers = headers;
        try {
          final masked = existingToken.length > 10 ? '${existingToken.substring(0, 6)}...${existingToken.substring(existingToken.length - 4)}' : existingToken;
          print('AuthInterceptor: attached existing access token (masked) after failed refresh: $masked');
        } catch (_) {}
      }
    } catch (_) {}

    // Proceed with the (possibly modified) request options so server receives the
    // Authorization header and can indicate token-expiry instead of missing-token.
    handler.next(reqOptions);
  }

  Future<LoginResponse> _refreshToken(String refreshToken) async {
    final tempDio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        connectTimeout: ApiConstants.connectionTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
      ),
    );

    try {
      final response = await tempDio.post(
        ApiConstants.refreshToken,
        data: RefreshTokenRequest(refreshToken: refreshToken).toJson(),
      );

      // Defensive: ensure response data contains expected fields before parsing
      final responseData = response.data;
      try {
        print('AuthInterceptor: refresh response raw: $responseData');
      } catch (_) {}

      if (responseData is! Map<String, dynamic>) {
        throw Exception('refresh_response_unexpected_type');
      }

      // The LoginResponse.fromJson accepts either {data: {...}} or {...}
      final inner = responseData['data'] as Map<String, dynamic>? ?? responseData;

      // If server returned full login payload, parse normally
      if (inner['accessToken'] != null && inner['refreshToken'] != null && inner['user'] != null) {
        return LoginResponse.fromJson(response.data);
      }

      // Handle partial response where only accessToken is returned (common case)
      if (inner['accessToken'] != null) {
        final String newAccessToken = inner['accessToken'] as String;

        // Try to reuse existing refresh token and user info from local storage
        final existingRefresh = _authLocalDataSource.getRefreshToken();
        var storedUser = _authLocalDataSource.getStoredUser();

        // If storedUser is missing, try to decode the new access token to extract user claims
        if (storedUser == null) {
          // Try to read basic user id/email from prefs. This is more robust
          // than trying to decode the JWT in some environments.
          final uid = _authLocalDataSource.getUserId();
          final uemail = _authLocalDataSource.getUserEmail();
          if (uid != null && uid.isNotEmpty && uemail != null && uemail.isNotEmpty && existingRefresh != null) {
            final userDataFromPrefs = UserData(
              id: uid,
              email: uemail,
              firstName: null,
              lastName: null,
              profilePicture: null,
              role: null,
              profileCompleted: null,
            );

            return LoginResponse(
              accessToken: newAccessToken,
              refreshToken: existingRefresh,
              user: userDataFromPrefs,
            );
          }
          // If we couldn't get minimal info, fall through to error below
        }

        if (existingRefresh == null || storedUser == null) {
          // Can't complete refresh flow without existing refresh token or user info
          // Try to salvage: if refresh token exists, accept accessToken-only and
          // create a minimal user placeholder so caller can save tokens.
          if (existingRefresh != null) {
            try {
              // Try decode id/email from token
              final payload = _decodeJwtPayload(newAccessToken);
              final idFromToken = (payload['userId'] ?? payload['id'])?.toString() ?? '';
              final emailFromToken = (payload['email'] ?? '')?.toString() ?? '';
              final fallbackUser = UserData(
                id: idFromToken,
                email: emailFromToken,
                firstName: null,
                lastName: null,
                profilePicture: null,
                role: null,
                profileCompleted: null,
              );
              print('AuthInterceptor: refresh returned accessToken only, using fallback user from token/prefs');
              return LoginResponse(
                accessToken: newAccessToken,
                refreshToken: existingRefresh,
                user: fallbackUser,
              );
            } catch (_) {
              // final fallback: empty user
              final emptyUser = UserData(
                id: '',
                email: '',
                firstName: null,
                lastName: null,
                profilePicture: null,
                role: null,
                profileCompleted: null,
              );
              print('AuthInterceptor: refresh returned accessToken only, using empty fallback user');
              return LoginResponse(
                accessToken: newAccessToken,
                refreshToken: existingRefresh,
                user: emptyUser,
              );
            }
          }
          throw Exception('refresh_response_missing_fields');
        }

        // Map storedUser (UserEntity) to LoginResponse.UserData
        final userData = UserData(
          id: storedUser.id,
          email: storedUser.email,
          firstName: storedUser.firstName,
          lastName: storedUser.lastName,
          profilePicture: storedUser.profilePicture,
          role: storedUser.role,
          profileCompleted: storedUser.profileCompleted,
        );

        return LoginResponse(
          accessToken: newAccessToken,
          refreshToken: existingRefresh,
          user: userData,
        );
      }

      // Otherwise response doesn't contain usable tokens
      throw Exception('refresh_response_missing_fields');
    } catch (e) {
      try {
        // If it's a DioException we can log more details
        if (e is DioException) {
          try {
            print('AuthInterceptor: refresh token request failed: status=${e.response?.statusCode} data=${e.response?.data}');
          } catch (_) {}
        } else {
          print('AuthInterceptor: refresh token request failed: $e');
        }
      } catch (_) {}
      // Bubble up the error so caller can handle (and trigger logout)
      rethrow;
    }
  }

  // Helper to decode JWT payload into Map
  Map<String, dynamic> _decodeJwtPayload(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return {};
      var payload = parts[1];
      switch (payload.length % 4) {
        case 2:
          payload += '==';
          break;
        case 3:
          payload += '=';
          break;
        case 1:
          payload += '===';
          break;
        default:
          break;
      }
      final decoded = utf8.decode(base64Url.decode(payload));
      final Map<String, dynamic> map = json.decode(decoded) as Map<String, dynamic>;
      return map;
    } catch (_) {
      return {};
    }
  }
}
