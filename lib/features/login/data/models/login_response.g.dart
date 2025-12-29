// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: UserData.fromJson(json['user'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'user': instance.user,
      'message': instance.message,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
  id: json['id'] as String,
  email: json['email'] as String,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  profilePicture: json['profile_picture'] as String?,
  role: json['role'] as String?,
  profileCompleted: json['profileCompleted'] as bool?,
);

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'profile_picture': instance.profilePicture,
  'role': instance.role,
  'profileCompleted': instance.profileCompleted,
};
