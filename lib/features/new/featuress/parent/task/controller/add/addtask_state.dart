part of 'addtask_cubit.dart';

@immutable
abstract class AddTaskState {}

class AddTaskInitial extends AddTaskState {}

class AddTaskLoading extends AddTaskState {}

class AddTaskSuccess extends AddTaskState {
  // final LoginModel loginModel;

  // LoginSuccess({required this.loginModel});
}

class AddTaskFailure extends AddTaskState {
  final String error;
  AddTaskFailure(this.error);
}

class AddTaskChangeVisibility extends AddTaskState {}

class AddTaskLoadingWidget extends AddTaskState {}

class AddTaskClearAllData extends AddTaskState {}
