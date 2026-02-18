import 'package:equatable/equatable.dart';

abstract class LoginEntity extends Equatable {
  final String accessToken;
  final String refreshToken;
  final UserEntity user;

  const LoginEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  @override
  List<Object?> get props => [accessToken, refreshToken, user];
}

class UserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? profilePicture;
  final String role;
  final bool profileCompleted;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.profilePicture,
    required this.role,
    required this.profileCompleted,
  });

  // Compatibility getter so existing call-sites using `user.name` keep working.
  // Joins firstName and lastName with a space. If lastName is empty returns firstName.
  String get name {
    if (firstName.isEmpty && lastName.isEmpty) return '';
    if (lastName.isEmpty) return firstName;
    return '$firstName $lastName';
  }

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    profilePicture,
    role,
    profileCompleted,
  ];
}
