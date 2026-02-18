import 'package:equatable/equatable.dart';

abstract class ChildProfileEvent extends Equatable {
  const ChildProfileEvent();

  @override
  List<Object?> get props => [];
}

class NameChanged extends ChildProfileEvent {
  final String name;

  const NameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class DateOfBirthChanged extends ChildProfileEvent {
  final DateTime dateOfBirth;

  const DateOfBirthChanged(this.dateOfBirth);

  @override
  List<Object?> get props => [dateOfBirth];
}

class GenderSelected extends ChildProfileEvent {
  final Gender gender;

  const GenderSelected(this.gender);

  @override
  List<Object?> get props => [gender];
}

class AvatarSelected extends ChildProfileEvent {
  final String avatarPath;

  const AvatarSelected(this.avatarPath);

  @override
  List<Object?> get props => [avatarPath];
}

class SubmitChildProfile extends ChildProfileEvent {
  const SubmitChildProfile();
}

enum Gender { boy, girl }
