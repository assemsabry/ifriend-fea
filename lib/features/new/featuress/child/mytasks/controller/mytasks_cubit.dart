import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/core/services/endpoint.dart';
import 'package:ifriend_app/features/new/featuress/child/mytasks/model/mytasks_model.dart';
import 'package:ifriend_app/features/new/coree/dio/dio_helper.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';

part 'mytasks_state.dart';

class MyTasksCubit extends Cubit<MyTasksState> {
  MyTasksCubit() : super(MyTasksLoadingStates());

  static MyTasksCubit get(BuildContext context) => BlocProvider.of(context);

  MyTasksModel? myTasksModel;

  Future<void> getAllMyTasks() async {
    emit(MyTasksLoadingStates());

    try {
      final response = await DioHelper.getData(
        url: EndPoints.updateMyTaskLink(HiveHelper.getData("childProfileId")),
        query: {"isActive": true},
        token: HiveHelper.getData("token"),
      );
      print(response.data);
      if (response.statusCode == 200) {
        myTasksModel = MyTasksModel.fromJson(response.data);

        emit(MyTasksSuccessStates(myTasksModel: myTasksModel!));
      } else {
        print(response.data.toString());
        emit(MyTasksErrorStates(error: response.data.toString()));
      }
    } catch (error) {
      print(error.toString());
      emit(MyTasksErrorStates(error: error.toString()));
    }
  }

  Future<void> markTaskAsDone({required String taskId}) async {
    emit(MyTasksUpdateLoadingStates());

    try {
      final response = await DioHelper.postData(
        url: EndPoints.markTaskAsDoneLink(taskId),
        data: {"childProfileId": HiveHelper.getData("childProfileId")},
        token: HiveHelper.getData("token"),
        option: true,
      );

      print(response.data);
      print(response.statusCode);
      print(HiveHelper.getData("childProfileId"));
      print(HiveHelper.getData("token"));
      print(taskId);

      if (response.statusCode == 200) {
        getAllMyTasks();
        emit(MyTasksUpdateSuccessStates());
      } else {
        print(response.data.toString());
        emit(MyTasksUpdateErrorStates(error: response.data.toString()));
      }
    } catch (error) {
      print(error.toString());
      emit(MyTasksUpdateErrorStates(error: error.toString()));
    }
  }
}
