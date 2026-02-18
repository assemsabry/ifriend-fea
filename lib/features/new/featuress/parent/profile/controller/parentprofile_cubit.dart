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
import 'package:ifriend_app/features/new/featuress/parent/profile/model/parentprofile_model.dart';

part 'parentprofile_state.dart';

class ParentProfileCubit extends Cubit<ParentProfileState> {
  ParentProfileCubit() : super(ParentProfileLoadingStates());

  static ParentProfileCubit get(BuildContext context) =>
      BlocProvider.of(context);

  ParentProfileModel? parentProfileModel;

  Future<void> getProfile() async {
    emit(ParentProfileLoadingStates());

    try {
      final response = await DioHelper.getData(
        url: EndPoints.getProfileLink,

        token: HiveHelper.getData("token"),
      );
      print(response.data);
      if (response.statusCode == 200) {
        parentProfileModel = ParentProfileModel.fromJson(response.data);

        emit(
          ParentProfileSuccessStates(parentProfileModel: parentProfileModel!),
        );
      } else {
        print(response.data.toString());
        emit(ParentProfileErrorStates(error: response.data.toString()));
      }
    } catch (error) {
      print(error.toString());
      emit(ParentProfileErrorStates(error: error.toString()));
    }
  }
}
