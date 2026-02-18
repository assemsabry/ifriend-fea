part of 'completeprofile_cubit.dart';

@immutable
abstract class CompleteProfileState {}

class CompleteProfileInitial extends CompleteProfileState {}

class CompleteProfileLoading extends CompleteProfileState {}

class CompleteProfileSuccess extends CompleteProfileState {}

class CompleteProfileFailure extends CompleteProfileState {
  final String error;

  CompleteProfileFailure({required this.error});
}

class CompleteProfileChangeRequidedWidget extends CompleteProfileState {}

class CompleteProfileChangeVisibility extends CompleteProfileState {}

class CompleteProfileIsLoadingWidget extends CompleteProfileState {}

class CompleteProfileClearAllData extends CompleteProfileState {}

class PickFileSuccessStates extends CompleteProfileState {}
