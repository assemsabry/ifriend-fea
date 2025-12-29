import 'package:equatable/equatable.dart';
import 'package:ifriend_app/features/child_profile/presentation/bloc/child_profile_event.dart';

class ChildProfileState extends Equatable {
  final String name;
  final DateTime? dateOfBirth;
  final Gender? gender;
  final String? avatarPath;
  final bool isValid;

  const ChildProfileState({
    this.name = '',
    this.dateOfBirth,
    this.gender,
    this.avatarPath,
    this.isValid = false,
  });

  ChildProfileState copyWith({
    String? name,
    DateTime? dateOfBirth,
    Gender? gender,
    String? avatarPath,
    bool? isValid,
  }) {
    return ChildProfileState(
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      avatarPath: avatarPath ?? this.avatarPath,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [name, dateOfBirth, gender, avatarPath, isValid];
}

