part of 'childhome_cubit.dart';

abstract class ChildHomeState {}

class ChildHomeInitState extends ChildHomeState {}

class AppChangedBottomNavState extends ChildHomeState {}

class CloseBottomNavState extends ChildHomeState {}

class IsDrawerOpenState extends ChildHomeState {}

class OnTapState extends ChildHomeState {}

class ChildSwitchLoadingState extends ChildHomeState {}

class ChildSwitchSuccessState extends ChildHomeState {}

class ChildSwitchErrorState extends ChildHomeState {}

class ChildHomeLoadingState extends ChildHomeState {}

class ChildHomeSuccessState extends ChildHomeState {
  final ChildProfileModel childProfileModel;
  ChildHomeSuccessState({required this.childProfileModel});
}

class ChildHomeErrorState extends ChildHomeState {
  final String error;
  ChildHomeErrorState({required this.error});
}

class ChildDeviceHomeLoadingState extends ChildHomeState {}

class ChildDeviceHomeSuccessState extends ChildHomeState {
  final ChildDeviceModel childDeviceModel;
  ChildDeviceHomeSuccessState({required this.childDeviceModel});
}

class ChildDeviceHomeErrorState extends ChildHomeState {
  final String error;
  ChildDeviceHomeErrorState({required this.error});
}
