import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class GoogleLoginRequest {
  final String idToken;
  final String role;

  GoogleLoginRequest({required this.idToken, required this.role});

  Map<String, dynamic> toJson() => _$GoogleLoginRequestToJson(this);
}

@JsonSerializable()
class FacebookLoginRequest {
  final String accessToken;
  final String role;

  FacebookLoginRequest({required this.accessToken, required this.role});

  Map<String, dynamic> toJson() => _$FacebookLoginRequestToJson(this);
}

@JsonSerializable()
class RegisterDeviceRequest {
  final String deviceName;
  final String deviceType;
  final String fcmToken;
  final String deviceIdentifier;

  RegisterDeviceRequest({
    required this.deviceName,
    required this.deviceType,
    required this.fcmToken,
    required this.deviceIdentifier,
  });

  Map<String, dynamic> toJson() => _$RegisterDeviceRequestToJson(this);
}
