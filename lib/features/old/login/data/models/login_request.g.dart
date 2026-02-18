// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleLoginRequest _$GoogleLoginRequestFromJson(Map<String, dynamic> json) =>
    GoogleLoginRequest(
      idToken: json['idToken'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$GoogleLoginRequestToJson(GoogleLoginRequest instance) =>
    <String, dynamic>{'idToken': instance.idToken, 'role': instance.role};

FacebookLoginRequest _$FacebookLoginRequestFromJson(
  Map<String, dynamic> json,
) => FacebookLoginRequest(
  accessToken: json['accessToken'] as String,
  role: json['role'] as String,
);

Map<String, dynamic> _$FacebookLoginRequestToJson(
  FacebookLoginRequest instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'role': instance.role,
};

RegisterDeviceRequest _$RegisterDeviceRequestFromJson(
  Map<String, dynamic> json,
) => RegisterDeviceRequest(
  deviceName: json['deviceName'] as String,
  deviceType: json['deviceType'] as String,
  fcmToken: json['fcmToken'] as String,
  deviceIdentifier: json['deviceIdentifier'] as String,
);

Map<String, dynamic> _$RegisterDeviceRequestToJson(
  RegisterDeviceRequest instance,
) => <String, dynamic>{
  'deviceName': instance.deviceName,
  'deviceType': instance.deviceType,
  'fcmToken': instance.fcmToken,
  'deviceIdentifier': instance.deviceIdentifier,
};
