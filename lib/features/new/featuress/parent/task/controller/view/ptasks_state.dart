part of 'ptasks_cubit.dart';

@immutable
abstract class PTasksState {}

class PTasksStateInitialStates extends PTasksState {}

class PTasksLoadingStates extends PTasksState {}

class PTasksSuccessStates extends PTasksState {
  final PTasksModel pTasksModel;

  PTasksSuccessStates({required this.pTasksModel});
}

class PTasksErrorStates extends PTasksState {
  final String error;

  PTasksErrorStates({required this.error});
}

class DeleteTaskLoadingStates extends PTasksState {}

class DeleteTaskSuccessStates extends PTasksState {}

class DeleteTaskErrorStates extends PTasksState {
  final String error;

  DeleteTaskErrorStates({required this.error});
}

class EditTaskLoadingStates extends PTasksState {}

class EditTaskSuccessStates extends PTasksState {}

class EditTaskErrorStates extends PTasksState {
  final String error;

  EditTaskErrorStates({required this.error});
}

class PTasksChangeTypeStates extends PTasksState {}

class PTasksCleanDataStates extends PTasksState {}

class PickFileSuccessStates extends PTasksState {}
