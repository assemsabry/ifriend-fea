import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/core/services/endpoint.dart';
import 'package:ifriend_app/features/new/featuress/parent/apps/model/apps_model.dart';
import 'package:ifriend_app/features/new/coree/dio/dio_helper.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';

part 'apps_state.dart';

class AppsCubit extends Cubit<AppsState> {
  AppsCubit() : super(AppsLoadingStates());

  static AppsCubit get(BuildContext context) => BlocProvider.of(context);

  AppsModel? appsModel;
  String? allCount = "0";
  String? allowCount = "0";
  String? blockCount = "0";
  Future<void> getAllApps() async {
    emit(AppsLoadingStates());

    try {
      final response = await DioHelper.getData(
        url: EndPoints.getAllAppsLink(HiveHelper.getData("deviceId")),

        token: HiveHelper.getData("token"),
      );
      print(response.data);
      print(response.statusCode);

      if (response.statusCode == 200) {
        appsModel = AppsModel.fromJson(response.data);
        allCount = appsModel?.data?.apps?.length.toString();
        allowCount = appsModel?.data?.apps
            ?.where((element) => element.isBlocked == false)
            .length
            .toString();
        blockCount = appsModel?.data?.apps
            ?.where((element) => element.isBlocked == true)
            .length
            .toString();
        emit(AppsSuccessStates(appsModel: appsModel!));
      } else {
        print(response.data.toString());
        emit(AppsErrorStates(error: response.data.toString()));
      }
    } catch (error) {
      print(error.toString());
      emit(AppsErrorStates(error: error.toString()));
    }
  }

  Future<void> switchApp({
    required String appId,
    required bool isBlocked,
  }) async {
    emit(AppsSwitchLoadingStates());

    try {
      final response = await DioHelper.putData(
        url: EndPoints.switchAppLink(appId),
        data: {"isBlocked": isBlocked},
        token: HiveHelper.getData("token"),
      );
      print(response.data);
      if (response.statusCode == 200) {
        getAllApps();
        emit(AppsSwitchSuccessStates());
      } else {
        print(response.data.toString());
        emit(AppsSwitchErrorStates(error: response.data.toString()));
      }
    } catch (error) {
      print(error.toString());
      emit(AppsSwitchErrorStates(error: error.toString()));
    }
  }

  // Future<void> deleteTask({required String taskId}) async {
  //   emit(DeleteTaskLoadingStates());

  //   try {
  //     final response = await DioHelper.deleteData(
  //       url: EndPoints.deleteTaskLink(taskId),
  //       data: {},
  //       // token:
  //       //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI1Y2ExZjMwNC01NzRiLTQyNmYtYmI5ZS0wMzU3ZjBiZTg4N2YiLCJlbWFpbCI6Im11aGFubmRoYW55LmRldkBnbWFpbC5jb20iLCJ1c2VyVHlwZSI6IlBBUkVOVCIsImlhdCI6MTc2OTM4OTk2MSwiZXhwIjoxNzY5MzkwODYxfQ.AN2kuosw0U2gfjdQDT9W5V6Gn3VUkM9HHUkH9xieNdE",
  //       //HiveHelper.getData("token"),
  //     );
  //     print(response.data);
  //     if (response.statusCode == 200) {
  //       //getApps();
  //       emit(DeleteTaskSuccessStates());
  //     } else {
  //       print(response.data.toString());
  //       emit(DeleteTaskErrorStates(error: response.data.toString()));
  //     }
  //   } catch (error) {
  //     print(error.toString());
  //     emit(DeleteTaskErrorStates(error: error.toString()));
  //   }
  // }

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    emit(AppsChangeTypeStates());
  }

  int methodId = 0;

  void changeTapIndex(int index, int withdrawalMethodId) {
    methodId = withdrawalMethodId;
    emit(AppsChangeTypeStates());
  }
}
