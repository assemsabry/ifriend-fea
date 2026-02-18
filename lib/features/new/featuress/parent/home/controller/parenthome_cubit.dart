import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/services/endpoint.dart';
import 'package:ifriend_app/features/new/featuress/parent/profile/controller/parentprofile_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/profile/view/screen/parentprofile_screen.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/controller/alllocation_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/view/screen/alllocations_screen.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/model/parenthome_model.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/view/screen/parenthome_screen.dart';
import 'package:ifriend_app/features/new/coree/dio/dio_helper.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';

part 'parenthome_state.dart';

class ParentHomeCubit extends Cubit<ParentHomeState> {
  ParentHomeCubit() : super(ParentHomeInitState());
  static ParentHomeCubit get(BuildContext context) => BlocProvider.of(context);

  HomeParentModel? homeParentModel;
  Future<void> getHomeParent({required String childId}) async {
    emit(ParentHomeLoadingState());

    try {
      final response = await DioHelper.getData(
        url: EndPoints.getHomeParentLink,
        token: HiveHelper.getData("token"),
        query: {"childId": childId},
      );
      print(response.data);
      if (response.statusCode == 200) {
        homeParentModel = HomeParentModel.fromJson(response.data);
        HiveHelper.addData("childId", childId);
        HiveHelper.addData("deviceId", homeParentModel?.data?.child?.deviceId);

        HiveHelper.addData("parentChildId", homeParentModel?.data?.child?.id);

        print(homeParentModel!.toJson());
        emit(ParentHomeSuccessState(model: homeParentModel!));
      } else {
        print(response.data.toString());
        emit(ParentHomeErrorState(error: response.data.toString()));
      }
    } catch (error) {
      print(error.toString());
      emit(ParentHomeErrorState(error: error.toString()));
    }
  }

  int currentPage = 0;

  List<Widget> listPage = [
    const ParenthomeScreen(),
    const AllLocationsScreen(),
    const ParenthomeScreen(),
    const ParentProfileScreen(),
  ];

  void changePage(int i) {
    if (i == 0) {
      getHomeParent(childId: "");
    }
    if (i == 1) {
      AllLocationCubit.get(Get.context!).getAllMyChildLocations();
    } else if (i == 2) {
    } else if (i == 3) {
      ParentProfileCubit.get(Get.context!).getProfile();
    }
    currentPage = i;
    emit(OnTapState());
  }
}
