part of 'parenthome_cubit.dart';

abstract class ParentHomeState {}

class ParentHomeInitState extends ParentHomeState {}

class AppChangedBottomNavState extends ParentHomeState {}

class CloseBottomNavState extends ParentHomeState {}

class IsDrawerOpenState extends ParentHomeState {}

class OnTapState extends ParentHomeState {}

class ParentSwitchLoadingState extends ParentHomeState {}

class ParentSwitchSuccessState extends ParentHomeState {}

class ParentSwitchErrorState extends ParentHomeState {}

class ParentHomeLoadingState extends ParentHomeState {}

class ParentHomeSuccessState extends ParentHomeState {
  final HomeParentModel model;
  ParentHomeSuccessState({required this.model});
}

class ParentHomeErrorState extends ParentHomeState {
  final String error;
  ParentHomeErrorState({required this.error});
}
