import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/services/endpoint.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/model/modes_model.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/model/timepicker_type.dart';
import 'package:ifriend_app/features/new/coree/dio/dio_helper.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';
import 'package:ifriend_app/features/new/featuress/parent/devices/model/parentdevices_model.dart';
import 'package:ifriend_app/features/new/featuress/parent/profile/model/parentprofile_model.dart';

part 'parentdevices_state.dart';

class ParentDevicesCubit extends Cubit<ParentDevicesState> {
  ParentDevicesCubit() : super(ParentDevicesLoadingStates());

  static ParentDevicesCubit get(BuildContext context) =>
      BlocProvider.of(context);

  ParentdevicesModel? parentDevicesModel;

  Future<void> getDevices() async {
    emit(ParentDevicesLoadingStates());

    try {
      final response = await DioHelper.getData(
        url: EndPoints.getDevicesLink,

        token: HiveHelper.getData("token"),
      );
      print(response.data);
      if (response.statusCode == 200) {
        parentDevicesModel = ParentdevicesModel.fromJson(response.data);

        emit(
          ParentDevicesSuccessStates(parentDevicesModel: parentDevicesModel!),
        );
      } else {
        print(response.data.toString());
        emit(ParentDevicesErrorStates(error: response.data.toString()));
      }
    } catch (error) {
      print(error.toString());
      emit(ParentDevicesErrorStates(error: error.toString()));
    }
  }
}
