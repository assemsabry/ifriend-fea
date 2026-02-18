import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/core/services/endpoint.dart';
import 'package:ifriend_app/features/new/featuress/parent/task/model/ptask_model.dart';
import 'package:ifriend_app/features/new/coree/dio/dio_helper.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';

part 'ptasks_state.dart';

class PTasksCubit extends Cubit<PTasksState> {
  PTasksCubit() : super(PTasksLoadingStates());

  static PTasksCubit get(BuildContext context) => BlocProvider.of(context);

  PTasksModel? pTasksModel;

  Future<void> getPTasks() async {
    emit(PTasksLoadingStates());

    try {
      final response = await DioHelper.getData(
        url: EndPoints.getTasksLink(HiveHelper.getData("parentChildId")),

        token: HiveHelper.getData("token"),
      );
      print(response.data);
      if (response.statusCode == 200) {
        pTasksModel = PTasksModel.fromJson(response.data);

        emit(PTasksSuccessStates(pTasksModel: pTasksModel!));
      } else {
        print(response.data.toString());
        emit(PTasksErrorStates(error: response.data.toString()));
      }
    } catch (error) {
      print(error.toString());
      emit(PTasksErrorStates(error: error.toString()));
    }
  }

  Future<void> editTasks({
    required String taskId,
    required bool isDefault,
  }) async {
    emit(EditTaskLoadingStates());

    try {
      final response = await DioHelper.putData(
        url: EndPoints.editTaskLink(taskId),
        data: {"isActive": isDefault},
        token: HiveHelper.getData("token"),
      );
      print(response.data);
      if (response.statusCode == 200) {
        pTasksModel = PTasksModel.fromJson(response.data);
        getPTasks();

        emit(EditTaskSuccessStates());
      } else {
        print(response.data.toString());
        emit(EditTaskErrorStates(error: response.data.toString()));
      }
    } catch (error) {
      print(error.toString());
      emit(EditTaskErrorStates(error: error.toString()));
    }
  }

  Future<void> deleteTask({required String taskId}) async {
    emit(DeleteTaskLoadingStates());

    try {
      final response = await DioHelper.deleteData(
        url: EndPoints.deleteTaskLink(taskId),
        data: {},
        token:
            // token:
            //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI1Y2ExZjMwNC01NzRiLTQyNmYtYmI5ZS0wMzU3ZjBiZTg4N2YiLCJlbWFpbCI6Im11aGFubmRoYW55LmRldkBnbWFpbC5jb20iLCJ1c2VyVHlwZSI6IlBBUkVOVCIsImlhdCI6MTc2OTM4OTk2MSwiZXhwIjoxNzY5MzkwODYxfQ.AN2kuosw0U2gfjdQDT9W5V6Gn3VUkM9HHUkH9xieNdE",
            HiveHelper.getData("token"),
      );
      print(response.data);
      if (response.statusCode == 200) {
        getPTasks();
        emit(DeleteTaskSuccessStates());
      } else {
        print(response.data.toString());
        emit(DeleteTaskErrorStates(error: response.data.toString()));
      }
    } catch (error) {
      print(error.toString());
      emit(DeleteTaskErrorStates(error: error.toString()));
    }
  }

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    emit(PTasksChangeTypeStates());
  }

  int methodId = 0;

  void changeTapIndex(int index, int withdrawalMethodId) {
    methodId = withdrawalMethodId;
    emit(PTasksChangeTypeStates());
  }
}
