// Model classes for Complete Profile response and nested objects
import 'package:ifriend_app/features/old/complete_profile/domain/entity/profile_entity.dart';

class CompleteProfileResponseModel {
  final ProfileModel? profile;
  final UpdatedUserModel? updatedUser;

  CompleteProfileResponseModel({this.profile, this.updatedUser});

  factory CompleteProfileResponseModel.fromJson(Map<String, dynamic> json) {
    // The API returns a wrapper like: { success: true, data: { profile: { profile: {...}, updatedUser: {...} } } }
    Map<String, dynamic>? root = json;

    // Drill down to `data.profile` if present
    if (root['data'] is Map<String, dynamic>) {
      final data = root['data'] as Map<String, dynamic>;
      if (data['profile'] is Map<String, dynamic>) {
        final profileContainer = data['profile'] as Map<String, dynamic>;
        // The actual profile object may be under `profile` key inside profileContainer
        final profileJson =
            (profileContainer['profile'] is Map<String, dynamic>)
            ? profileContainer['profile'] as Map<String, dynamic>
            : profileContainer;

        final updatedUserJson = profileContainer['updatedUser'];

        return CompleteProfileResponseModel(
          profile: ProfileModel.fromJson(profileJson),
          updatedUser:
              updatedUserJson != null && updatedUserJson is Map<String, dynamic>
              ? UpdatedUserModel.fromJson(
                  updatedUserJson,
                )
              : null,
        );
      }

      // Fallback: data itself might be the profile
      return CompleteProfileResponseModel(
        profile: ProfileModel.fromJson(data),
        updatedUser: null,
      );
    }

    // If top-level contains profile directly
    if (root['profile'] is Map<String, dynamic>) {
      return CompleteProfileResponseModel(
        profile: ProfileModel.fromJson(root['profile'] as Map<String, dynamic>),
        updatedUser: (root['updatedUser'] is Map<String, dynamic>)
            ? UpdatedUserModel.fromJson(
                root['updatedUser'] as Map<String, dynamic>,
              )
            : null,
      );
    }

    // Fallback empty
    return CompleteProfileResponseModel(profile: null, updatedUser: null);
  }

  Map<String, dynamic> toJson() => {
    'profile': profile?.toJson(),
    'updatedUser': updatedUser?.toJson(),
  };

  ProfileEntity? toEntity() {
    if (profile == null) return null;
    return ProfileEntity(
      id: profile!.id,
      userId: profile!.userId,
      firstName: profile!.firstName,
      lastName: profile!.lastName,
      phoneNumber: profile!.phoneNumber,
      avatarUrl: profile!.avatarUrl,
      createdAt: profile!.createdAt,
      updatedAt: profile!.updatedAt,
      updatedUser: updatedUser != null
          ? UpdatedUserEntity(
              id: updatedUser!.id,
              email: updatedUser!.email,
              providerId: updatedUser!.providerId,
              userType: updatedUser!.userType,
              authProvider: updatedUser!.authProvider,
              createdAt: updatedUser!.createdAt,
              updatedAt: updatedUser!.updatedAt,
            )
          : null,
    );
  }
}

class ProfileModel {
  final String id;
  final String userId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? avatarUrl;
  final String? createdAt;
  final String? updatedAt;

  ProfileModel({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.avatarUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      avatarUrl: json['avatarUrl']?.toString(),
      createdAt: json['createdAt']?.toString(),
      updatedAt: json['updatedAt']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'firstName': firstName,
    'lastName': lastName,
    'phoneNumber': phoneNumber,
    'avatarUrl': avatarUrl,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}

class UpdatedUserModel {
  final String id;
  final String email;
  final String? providerId;
  final String? userType;
  final String? authProvider;
  final String? createdAt;
  final String? updatedAt;

  UpdatedUserModel({
    required this.id,
    required this.email,
    this.providerId,
    this.userType,
    this.authProvider,
    this.createdAt,
    this.updatedAt,
  });

  factory UpdatedUserModel.fromJson(Map<String, dynamic> json) {
    return UpdatedUserModel(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      providerId: json['providerId']?.toString(),
      userType: json['userType']?.toString(),
      authProvider: json['authProvider']?.toString(),
      createdAt: json['createdAt']?.toString(),
      updatedAt: json['updatedAt']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'providerId': providerId,
    'userType': userType,
    'authProvider': authProvider,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}
