part of 'childcompleteprofile_cubit.dart';

@immutable
abstract class ChildCompleteProfileState {}

class ChildCompleteProfileInitial extends ChildCompleteProfileState {}

class ChildCompleteProfileLoading extends ChildCompleteProfileState {}

class ChildCompleteProfileSuccess extends ChildCompleteProfileState {}

class ChildCompleteProfileFailure extends ChildCompleteProfileState {
  final String error;

  ChildCompleteProfileFailure({required this.error});
}

class ChildCompleteProfileChangeRequidedWidget
    extends ChildCompleteProfileState {}

class ChildCompleteProfileChangeVisibility extends ChildCompleteProfileState {}

class ChildCompleteProfileIsLoadingWidget extends ChildCompleteProfileState {}

class ChildCompleteProfileClearAllData extends ChildCompleteProfileState {}

class PickFileSuccessStates extends ChildCompleteProfileState {}
