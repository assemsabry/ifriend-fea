import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/services/endpoint.dart';
import 'package:ifriend_app/features/new/featuress/child/apps/controller/syncapps_cubit.dart';
import 'package:ifriend_app/features/new/featuress/child/home/model/childdevice_model.dart';
import 'package:ifriend_app/features/new/featuress/child/home/model/childprofile_model.dart';
import 'package:ifriend_app/features/new/coree/dio/dio_helper.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';

part 'childhome_state.dart';

class ChildHomeCubit extends Cubit<ChildHomeState> {
  ChildHomeCubit() : super(ChildHomeInitState());
  static ChildHomeCubit get(BuildContext context) => BlocProvider.of(context);

  ChildProfileModel? childProfileModel;
  Future<void> getChildProfile() async {
    emit(ChildHomeLoadingState());

    try {
      final response = await DioHelper.getData(
        url: EndPoints.getChildProfileLink,

        token: HiveHelper.getData("token"),
      );
      print(response.data);
      if (response.statusCode == 200) {
        childProfileModel = ChildProfileModel.fromJson(response.data);
        HiveHelper.addData(
          "childProfileId",
          childProfileModel!.data!.profile!.id,
        );
        emit(ChildHomeSuccessState(childProfileModel: childProfileModel!));
      } else {
        print(response.data.toString());
        emit(ChildHomeErrorState(error: response.data.toString()));
      }
    } catch (error) {
      print(error.toString());
      emit(ChildHomeErrorState(error: error.toString()));
    }
  }

  ChildDeviceModel? childDeviceModel;
  Future<void> getChildDevice() async {
    emit(ChildDeviceHomeLoadingState());

    try {
      final response = await DioHelper.getData(
        url: EndPoints.getChildDeviceLink,

        token: HiveHelper.getData("token"),
      );
      print(response.data);
      if (response.statusCode == 200) {
        childDeviceModel = ChildDeviceModel.fromJson(response.data);
        HiveHelper.addData("deviceId", childDeviceModel!.data!.device!.id);
        SyncAppsCubit.get(Get.context!).getApps();

        emit(ChildDeviceHomeSuccessState(childDeviceModel: childDeviceModel!));
      } else {
        print(response.data.toString());
        emit(ChildDeviceHomeErrorState(error: response.data.toString()));
      }
    } catch (error) {
      print(error.toString());
      emit(ChildDeviceHomeErrorState(error: error.toString()));
    }
  }

  // int currentPage = 0;

  // List<Widget> listPage = [
  //   const ChildhomeScreen(),
  //   const AllLocationsScreen(),
  //   const ChildhomeScreen(),
  //   const ProfileScreen(),
  // ];

  // void changePage(int i) {
  //   if (i == 0) {
  //     getHomeChild();
  //   }
  //   if (i == 1) {
  //     AllLocationCubit.get(Get.context!).getAllMyChildLocations();
  //   } else if (i == 2) {
  //   } else if (i == 3) {}
  //   currentPage = i;
  //   emit(OnTapState());
  // }
}
