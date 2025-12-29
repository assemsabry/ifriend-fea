import 'package:shared_preferences/shared_preferences.dart';
import 'package:ifriend_app/features/login/domain/entities/login_entity.dart';

class AuthLocalDataSource {
  final SharedPreferences prefs;

  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyUserId = 'user_id';
  static const String _keyUserEmail = 'user_email';
  // Keep the old key for backwards compatibility when reading, but prefer first/last below
  static const String _keyUserName = 'user_name';
  static const String _keyUserFirstName = 'user_first_name';
  static const String _keyUserLastName = 'user_last_name';
  static const String _keyUserRole = 'user_role';
  static const String _keyUserProfilePicture = 'user_profile_picture';
  static const String _keyProfileCompleted = 'profile_completed';

  AuthLocalDataSource(this.prefs);

  Future<void> saveAuthData({
    required String accessToken,
    required String refreshToken,
    required String userId,
    required String email,
    required String firstName,
    required String lastName,
    required String role,
    String? profilePicture,
  }) async {
    await prefs.setString(_keyAccessToken, accessToken);
    await prefs.setString(_keyRefreshToken, refreshToken);
    await prefs.setString(_keyUserId, userId);
    await prefs.setString(_keyUserEmail, email);
    // Save both first/last separately, and also save a combined name for older code that may read it
    await prefs.setString(_keyUserFirstName, firstName);
    await prefs.setString(_keyUserLastName, lastName);
    final combined = [firstName, lastName].where((s) => s.isNotEmpty).join(' ');
    await prefs.setString(_keyUserName, combined);
    await prefs.setString(_keyUserRole, role);
    if (profilePicture != null) {
      await prefs.setString(_keyUserProfilePicture, profilePicture);
    }

    // Debug: masked log to confirm tokens were saved
    try {
      final maskedAccess = accessToken.length > 10 ? '${accessToken.substring(0, 6)}...${accessToken.substring(accessToken.length - 4)}' : accessToken;
      final maskedRefresh = refreshToken.length > 10 ? '${refreshToken.substring(0, 6)}...${refreshToken.substring(refreshToken.length - 4)}' : refreshToken;
      print('AuthLocalDataSource: saved accessToken=$maskedAccess refreshToken=$maskedRefresh');
    } catch (_) {}
  }

  Future<void> setProfileCompleted(bool completed) async {
    await prefs.setBool(_keyProfileCompleted, completed);
  }

  bool isProfileCompleted() => prefs.getBool(_keyProfileCompleted) ?? false;

  UserEntity? getStoredUser() {
    final id = prefs.getString(_keyUserId);
    final email = prefs.getString(_keyUserEmail);
    // Prefer explicit first/last if available, else fall back to combined name
    final firstName = prefs.getString(_keyUserFirstName);
    final lastName = prefs.getString(_keyUserLastName);
    final combinedName = prefs.getString(_keyUserName);
    final role = prefs.getString(_keyUserRole);
    final profilePicture = prefs.getString(_keyUserProfilePicture);

    if (id == null || email == null || /*name == null ||*/ role == null) return null;

    String fn = '';
    String ln = '';
    if (firstName != null || lastName != null) {
      fn = firstName ?? '';
      ln = lastName ?? '';
    } else if (combinedName != null && combinedName.isNotEmpty) {
      final nameParts = combinedName.split(' ');
      fn = nameParts.first;
      ln = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
    }

    return UserEntity(
      id: id,
      email: email,

      firstName: fn,
      lastName: ln,
      profilePicture: profilePicture,
      role: role,
      profileCompleted: isProfileCompleted(),
    );
  }

  String? getAccessToken() {
    final t = prefs.getString(_keyAccessToken);
    try {
      if (t != null && t.isNotEmpty) {
        final masked = t.length > 10 ? '${t.substring(0, 6)}...${t.substring(t.length - 4)}' : t;
        print('AuthLocalDataSource: getAccessToken -> $masked');
      } else {
        print('AuthLocalDataSource: getAccessToken -> null');
      }
    } catch (_) {}
    return t;
  }

  String? getRefreshToken() {
    final t = prefs.getString(_keyRefreshToken);
    try {
      if (t != null && t.isNotEmpty) {
        final masked = t.length > 10 ? '${t.substring(0, 6)}...${t.substring(t.length - 4)}' : t;
        print('AuthLocalDataSource: getRefreshToken -> $masked');
      } else {
        print('AuthLocalDataSource: getRefreshToken -> null');
      }
    } catch (_) {}
    return t;
  }

  String? getUserId() => prefs.getString(_keyUserId);

  String? getUserEmail() => prefs.getString(_keyUserEmail);

  // Keep a helper that returns the combined name (compat)
  String? getUserName() {
    final fn = prefs.getString(_keyUserFirstName);
    final ln = prefs.getString(_keyUserLastName);
    if ((fn == null || fn.isEmpty) && (ln == null || ln.isEmpty)) {
      return prefs.getString(_keyUserName);
    }
    return [fn, ln].where((s) => s != null && s.isNotEmpty).join(' ');
  }

  String? getUserRole() => prefs.getString(_keyUserRole);

  String? getUserProfilePicture() => prefs.getString(_keyUserProfilePicture);

  bool isLoggedIn() => getAccessToken() != null && getRefreshToken() != null;

  Future<void> clear() async {
    await prefs.remove(_keyAccessToken);
    await prefs.remove(_keyRefreshToken);
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserEmail);
    await prefs.remove(_keyUserName);
    await prefs.remove(_keyUserFirstName);
    await prefs.remove(_keyUserLastName);
    await prefs.remove(_keyUserRole);
    await prefs.remove(_keyUserProfilePicture);
    await prefs.remove(_keyProfileCompleted);
  }

  // Save only tokens (used when refresh endpoint returns only accessToken)
  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await prefs.setString(_keyAccessToken, accessToken);
    await prefs.setString(_keyRefreshToken, refreshToken);
    try {
      final maskedAccess = accessToken.length > 10 ? '${accessToken.substring(0, 6)}...${accessToken.substring(accessToken.length - 4)}' : accessToken;
      final maskedRefresh = refreshToken.length > 10 ? '${refreshToken.substring(0, 6)}...${refreshToken.substring(refreshToken.length - 4)}' : refreshToken;
      print('AuthLocalDataSource: saved tokens accessToken=$maskedAccess refreshToken=$maskedRefresh');
    } catch (_) {}
  }

  // Update only access token
  Future<void> setAccessToken(String accessToken) async {
    await prefs.setString(_keyAccessToken, accessToken);
    try {
      final masked = accessToken.length > 10 ? '${accessToken.substring(0, 6)}...${accessToken.substring(accessToken.length - 4)}' : accessToken;
      print('AuthLocalDataSource: setAccessToken -> $masked');
    } catch (_) {}
  }

  // Update only refresh token
  Future<void> setRefreshToken(String refreshToken) async {
    await prefs.setString(_keyRefreshToken, refreshToken);
    try {
      final masked = refreshToken.length > 10 ? '${refreshToken.substring(0, 6)}...${refreshToken.substring(refreshToken.length - 4)}' : refreshToken;
      print('AuthLocalDataSource: setRefreshToken -> $masked');
    } catch (_) {}
  }
}
