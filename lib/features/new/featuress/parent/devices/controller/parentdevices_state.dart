part of 'parentdevices_cubit.dart';

@immutable
abstract class ParentDevicesState {}

class ParentDevicesStateInitialStates extends ParentDevicesState {}

class ParentDevicesLoadingStates extends ParentDevicesState {}

class ParentDevicesSuccessStates extends ParentDevicesState {
  final ParentdevicesModel parentDevicesModel;

  ParentDevicesSuccessStates({required this.parentDevicesModel});
}

class ParentDevicesErrorStates extends ParentDevicesState {
  final String error;

  ParentDevicesErrorStates({required this.error});
}

class ParentDevicesChangeTypeStates extends ParentDevicesState {}
