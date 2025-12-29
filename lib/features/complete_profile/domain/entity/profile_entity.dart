class ProfileEntity {
  final String id;
  final String userId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? avatarUrl;
  final String? createdAt;
  final String? updatedAt;
  final UpdatedUserEntity? updatedUser;

  ProfileEntity({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.avatarUrl,
    this.createdAt,
    this.updatedAt,
    this.updatedUser,
  });
}

class UpdatedUserEntity {
  final String id;
  final String email;
  final String? providerId;
  final String? userType;
  final String? authProvider;
  final String? createdAt;
  final String? updatedAt;

  UpdatedUserEntity({
    required this.id,
    required this.email,
    this.providerId,
    this.userType,
    this.authProvider,
    this.createdAt,
    this.updatedAt,
  });
}

