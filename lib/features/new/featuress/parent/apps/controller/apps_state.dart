part of 'apps_cubit.dart';

@immutable
abstract class AppsState {}

class AppsStateInitialStates extends AppsState {}

class AppsLoadingStates extends AppsState {}

class AppsSuccessStates extends AppsState {
  final AppsModel appsModel;

  AppsSuccessStates({required this.appsModel});
}

class AppsErrorStates extends AppsState {
  final String error;

  AppsErrorStates({required this.error});
}

class AppsSwitchLoadingStates extends AppsState {}

class AppsSwitchSuccessStates extends AppsState {}

class AppsSwitchErrorStates extends AppsState {
  final String error;

  AppsSwitchErrorStates({required this.error});
}

class AppsChangeTypeStates extends AppsState {}
