part of 'parentprofile_cubit.dart';

@immutable
abstract class ParentProfileState {}

class ParentProfileStateInitialStates extends ParentProfileState {}

class ParentProfileLoadingStates extends ParentProfileState {}

class ParentProfileSuccessStates extends ParentProfileState {
  final ParentProfileModel parentProfileModel;

  ParentProfileSuccessStates({required this.parentProfileModel});
}

class ParentProfileErrorStates extends ParentProfileState {
  final String error;

  ParentProfileErrorStates({required this.error});
}

class ParentProfileChangeTypeStates extends ParentProfileState {}
