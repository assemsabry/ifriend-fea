import 'package:ifriend_app/core/helpers/auth_local_datasource.dart';
import 'package:ifriend_app/features/login/data/models/login_response.dart';

/// Parses a raw API response (which may be wrapped like {"success": true, "data": {...}})
/// and saves access/refresh tokens + basic user info using [AuthLocalDataSource].
///
/// Returns the constructed [LoginResponse] on success, or `null` if required
/// fields (accessToken / refreshToken) are missing.
Future<LoginResponse?> processAndSaveLoginResponse(
  Map<String, dynamic> rawJson,
  AuthLocalDataSource localDataSource,
) async {
  if (rawJson.isEmpty) return null;

  // The API sometimes wraps the payload in a 'data' field.
  final data = (rawJson['data'] is Map<String, dynamic>)
      ? (rawJson['data'] as Map<String, dynamic>)
      : rawJson;

  // Support both camelCase and snake_case keys.
  String? accessToken = (data['accessToken'] ?? data['access_token'])?.toString();
  String? refreshToken = (data['refreshToken'] ?? data['refresh_token'])?.toString();

  if (accessToken == null || refreshToken == null || accessToken.isEmpty || refreshToken.isEmpty) {
    return null; // required tokens missing
  }

  final userMap = (data['user'] is Map<String, dynamic>) ? (data['user'] as Map<String, dynamic>) : <String, dynamic>{};

  // Extract user fields with safe fallbacks and type conversions.
  final String id = userMap['id']?.toString() ?? userMap['user_id']?.toString() ?? '';
  final String email = userMap['email']?.toString() ?? '';
  // Support new fields: firstName / lastName. Fall back to combined `name` for compatibility.
  final String firstName = userMap['firstName']?.toString() ?? userMap['first_name']?.toString() ?? '';
  final String lastName = userMap['lastName']?.toString() ?? userMap['last_name']?.toString() ?? '';
  final String nameFallback = userMap['name']?.toString() ?? '';
  final String role = userMap['role']?.toString() ?? 'PARENT';

  String? profilePicture = userMap['profile_picture'] ?? userMap['profilePicture'];

  bool profileCompleted = false;
  if (userMap.containsKey('profileCompleted')) {
    final val = userMap['profileCompleted'];
    if (val is bool) profileCompleted = val;
    if (val is num) profileCompleted = val != 0;
    if (val is String) profileCompleted = (val.toLowerCase() == 'true');
  } else if (userMap.containsKey('profile_completed')) {
    final val = userMap['profile_completed'];
    if (val is bool) profileCompleted = val;
    if (val is num) profileCompleted = val != 0;
    if (val is String) profileCompleted = (val.toLowerCase() == 'true');
  }

  final user = UserData(
    id: id,
    email: email,
    firstName: firstName.isNotEmpty ? firstName : (nameFallback.isNotEmpty ? nameFallback.split(' ').first : ''),
    lastName: lastName.isNotEmpty ? lastName : (nameFallback.isNotEmpty ? (nameFallback.split(' ').length > 1 ? nameFallback.split(' ').sublist(1).join(' ') : '') : ''),
    profilePicture: profilePicture,
    role: role,
    profileCompleted: profileCompleted,
  );

  final loginResponse = LoginResponse(
    accessToken: accessToken,
    refreshToken: refreshToken,
    user: user,
    message: data['message']?.toString(),
  );

  // Persist the auth data locally
  await localDataSource.saveAuthData(
    accessToken: accessToken,
    refreshToken: refreshToken,
    userId: id,
    email: email,
    firstName: firstName.isNotEmpty ? firstName : (nameFallback.isNotEmpty ? nameFallback.split(' ').first : ''),
    lastName: lastName.isNotEmpty ? lastName : (nameFallback.isNotEmpty ? (nameFallback.split(' ').length > 1 ? nameFallback.split(' ').sublist(1).join(' ') : '') : ''),
    role: role,
    profilePicture: profilePicture,
  );

  return loginResponse;
}
