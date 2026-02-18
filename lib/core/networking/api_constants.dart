class ApiConstants {
  static const String baseUrl = 'https://api.i-friend.cloud/api/v1/application';

  static const String googleLogin = '/auth/google';
  static const String facebookLogin = '/auth/facebook';
  static const String refreshToken = '/auth/refresh';
  static const String createParentProfile = '/profile/create-parent-profile';
  static const String getParentProfile = '/profile/get-parent-profile';
  static const String updateParentProfile = '/profile/update-parent-profile';
  static const String scanQr = '/link/scan-qr';
  static const String verifyQr = '/link/verify-qr';
  static const String confirmLink = '/link/confirm-link';
  static const String generateQr = '/link/generate-qr';

  // Device Management
  static const String getUserDevice = '/device/user-device';
  static const String registerDevice = '/device/register-device';
  static const String getLinkedDevices = '/device/child-devices';
  static const String updateDevice = '/device/update-device';
  static const String removeDevice = '/device/remove-device';
  static const String updateActivity = '/device/update-activity';

  // Notifications
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
