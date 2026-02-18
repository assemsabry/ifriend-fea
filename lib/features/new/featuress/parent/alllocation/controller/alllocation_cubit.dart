import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ifriend_app/core/services/endpoint.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/model/allchild_model.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/model/allmychildlocation_model.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/model/allsavezone_model.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/model/childlocation_model.dart';
import 'package:ifriend_app/features/new/coree/dio/dio_helper.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';

part 'alllocation_state.dart';

class AllLocationCubit extends Cubit<AllLocationState> {
  AllLocationCubit() : super(AllLocationLoadingStates());

  static AllLocationCubit get(BuildContext context) => BlocProvider.of(context);

  AllsavezoneModel? allsavezoneModel;

  Future<void> getAllSaveZone() async {
    emit(AllLocationLoadingStates());

    try {
      final response = await DioHelper.getData(
        url: EndPoints.getLocationLink(HiveHelper.getData("parentChildId")),

        token: HiveHelper.getData("token"),
      );
      print(response.data);
      if (response.statusCode == 200) {
        allsavezoneModel = AllsavezoneModel.fromJson(response.data);
        fillAddresses();
        emit(AllLocationSuccessStates(allsavezoneModel: allsavezoneModel!));
      } else {
        print(response.data.toString());
        emit(AllLocationErrorStates(error: response.data.toString()));
      }
    } catch (error) {
      print(error.toString());
      emit(AllLocationErrorStates(error: error.toString()));
    }
  }

  AllMyChildLocationModel? allMyChildLocationsModel;

  Future<void> getAllMyChildLocations() async {
    emit(AllMyChildLocationsLoadingStates());

    try {
      final response = await DioHelper.getData(
        url: EndPoints.getAllMyChildLocationsLink,

        token: HiveHelper.getData("token"),
      );
      print(response.data);
      if (response.statusCode == 200) {
        allMyChildLocationsModel = AllMyChildLocationModel.fromJson(
          response.data,
        );
        fillChildAddresses();
        emit(
          AllMyChildLocationsSuccessStates(
            allMyChildLocationsModel: allMyChildLocationsModel!,
          ),
        );
      } else {
        print(response.data.toString());
        emit(AllMyChildLocationsErrorStates(error: response.data.toString()));
      }
    } catch (error) {
      print(error.toString());
      emit(AllMyChildLocationsErrorStates(error: error.toString()));
    }
  }

  AllMyChildModel? allMyChildModel;
  Future<void> getAllMyChild() async {
    emit(AllMyChildLoadingStates());

    try {
      final response = await DioHelper.getData(
        url: EndPoints.getAllMyChildLink,
        query: {"includeDevices": 'true'},
        token: HiveHelper.getData("token"),
      );
      print(response.data);
      if (response.statusCode == 200) {
        allMyChildModel = AllMyChildModel.fromJson(response.data);

        emit(AllMyChildSuccessStates(allMyChildModel: allMyChildModel!));
      } else {
        print(response.data.toString());
        emit(AllMyChildErrorStates(error: response.data.toString()));
      }
    } catch (error) {
      print(error.toString());
      emit(AllMyChildErrorStates(error: error.toString()));
    }
  }

  ChildlocationModel? childlocationModel;
  Future<void> getChildLocation({required String childId}) async {
    emit(ChildLocationLoadingStates());

    try {
      final response = await DioHelper.getData(
        url: EndPoints.getTasksLink(childId),

        token: HiveHelper.getData("token"),
      );
      print(response.data);
      if (response.statusCode == 200) {
        childlocationModel = ChildlocationModel.fromJson(response.data);

        emit(
          ChildLocationSuccessStates(childlocationModel: childlocationModel!),
        );
      } else {
        print(response.data.toString());
        emit(ChildLocationErrorStates(error: response.data.toString()));
      }
    } catch (error) {
      print(error.toString());
      emit(ChildLocationErrorStates(error: error.toString()));
    }
  }

  Future<void> fillAddresses() async {
    if (allsavezoneModel?.data?.safeZones == null) return;

    for (final zone in allsavezoneModel!.data!.safeZones!) {
      // ⛔ إحداثيات غير صالحة
      if (zone.latitude == -90 || zone.longitude == -180) {
        zone.address = "unknown";
        continue;
      }

      try {
        final placemarks = await placemarkFromCoordinates(
          zone.latitude!.toDouble(),
          zone.longitude!.toDouble(),
        );

        if (placemarks.isNotEmpty) {
          final p = placemarks.first;
          zone.address =
              '${p.street}, ${p.subLocality}, ${p.locality}, ${p.country}';
        } else {
          zone.address = "unknown";
        }
      } catch (e) {
        zone.address = "unknown";
      }
    }

    emit(AddressSuccess());
  }

  Future<void> fillChildAddresses() async {
    if (allMyChildLocationsModel?.data?.children == null) return;

    for (final child in allMyChildLocationsModel!.data!.children!) {
      // ⛔ إحداثيات غير صالحة
      if (child.currentLocation?.latitude == -90 ||
          child.currentLocation?.longitude == -180) {
        child.currentLocation?.address = "unknown";
        continue;
      }

      try {
        final placemarks = await placemarkFromCoordinates(
          child.currentLocation?.latitude!.toDouble() ?? 0,
          child.currentLocation?.longitude!.toDouble() ?? 0,
        );

        if (placemarks.isNotEmpty) {
          final p = placemarks.first;
          child.currentLocation?.address =
              '${p.street}, ${p.subLocality}, ${p.locality}, ${p.country}';
        } else {
          child.currentLocation?.address = "unknown";
        }
      } catch (e) {
        child.currentLocation?.address = "unknown";
      }
    }

    emit(AddressSuccess());
  }

  Future<void> deleteTask({required String taskId}) async {
    emit(DeleteTaskLoadingStates());

    try {
      final response = await DioHelper.deleteData(
        url: EndPoints.deleteTaskLink(taskId),
        data: {},
        token:
            //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI1Y2ExZjMwNC01NzRiLTQyNmYtYmI5ZS0wMzU3ZjBiZTg4N2YiLCJlbWFpbCI6Im11aGFubmRoYW55LmRldkBnbWFpbC5jb20iLCJ1c2VyVHlwZSI6IlBBUkVOVCIsImlhdCI6MTc2OTM4OTk2MSwiZXhwIjoxNzY5MzkwODYxfQ.AN2kuosw0U2gfjdQDT9W5V6Gn3VUkM9HHUkH9xieNdE",
            HiveHelper.getData("token"),
      );
      print(response.data);
      if (response.statusCode == 200) {
        //getAllLocation();
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

  bool isOpened = false;

  void setOpened() {
    isOpened = !isOpened;
    emit(AllLocationChangeTypeStates());
  }

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    emit(AllLocationChangeTypeStates());
  }

  int methodId = 0;

  void changeTapIndex(int index, int withdrawalMethodId) {
    methodId = withdrawalMethodId;
    emit(AllLocationChangeTypeStates());
  }
}
