import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final UserData user;
  final String? message;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    this.message,
  });

  // The API returns a wrapper: { "success": true, "data": { ... } }
  // Accept either the wrapped response or an already-unwrapped map.
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    return _$LoginResponseFromJson(data);
  }

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class UserData {
  final String id;
  final String email;
  final String? firstName; // changed from `name`
  final String? lastName; // new field
  @JsonKey(name: 'profile_picture')
  final String? profilePicture;
  final String? role;
  final bool? profileCompleted;

  UserData({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.role,
    this.profileCompleted,
  });

  // Compatibility getter to provide `name` for older call-sites or direct access.
  String? get name {
    if ((firstName == null || firstName!.isEmpty) &&
        (lastName == null || lastName!.isEmpty)) {
      return null;
    }
    if (lastName == null || lastName!.isEmpty) return firstName;
    if (firstName == null || firstName!.isEmpty) return lastName;
    return '${firstName!} ${lastName!}';
  }

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
