import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/services/endpoint.dart';
import 'package:ifriend_app/features/new/featuress/parent/task/controller/view/ptasks_cubit.dart';
import 'package:ifriend_app/features/new/coree/dio/dio_helper.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';

part 'addtask_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());
  static AddTaskCubit get(BuildContext context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  // AddTaskModel? AddTaskModel;

  Future<void> addTask() async {
    try {
      // final hasInternet = await FastConnectivityHelper.hasNetwork();
      // if (!hasInternet) {
      //   emit(AddTaskFailure("internet"));
      //   return;
      // }
      // log("Internet: $hasInternet");

      setLoading(true);
      emit(AddTaskLoading());

      // 1) طلب API
      final value = await DioHelper.postData(
        url: EndPoints.createTaskLink,
        token: HiveHelper.getData("token"),
        data: {
          "childProfileId": HiveHelper.getData("parentChildId"),
          "title": titleController.text,
          "description": descriptionController.text,
          "coins": coinsCount,
        },
        option: true,
      );
      log("Response: ${value.data}");
      log("STATUS CODE: ${value.statusCode}");
      log("FULL RESPONSE: ${value.data}");
      if (value.data["success"] == true) {
        setLoading(false);
        Navigator.pop(Get.context!);
        PTasksCubit.get(Get.context!).getPTasks();
        //AddTaskModel = AddTaskModel.fromJson(value.data);

        emit(AddTaskSuccess());
      } else {
        setLoading(false);

        emit(AddTaskFailure("error"));
      }
    } catch (e) {
      // emailBackendError = true;

      // 4) خطأ Exception
      if (kDebugMode) print(e);

      setLoading(false);

      emit(AddTaskFailure("unknown"));
    }
  }

  bool isFilled = false;

  void updateFormState() {
    isFilled =
        titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        coinsCount > 0;
    emit(AddTaskChangeVisibility());
  }

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    emit(AddTaskLoadingWidget());
  }

  int coinsCount = 0;

  void changeCoinsCount(int value, bool isPlus) {
    if (isPlus) {
      if (coinsCount + value <= 5) {
        coinsCount += value;
      } else {
        coinsCount = 5;
      }
    } else {
      if (coinsCount - value >= 0) {
        coinsCount -= value;
      } else {
        coinsCount = 0;
      }
    }
    emit(AddTaskChangeVisibility());
  }

  void clearAllData() {
    formKey = GlobalKey<FormState>();
    titleController.clear();
    descriptionController.clear();
    coinsCount = 0;
    emit(AddTaskClearAllData());
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();

    print("🔥 disposed");

    return super.close();
  }
}
