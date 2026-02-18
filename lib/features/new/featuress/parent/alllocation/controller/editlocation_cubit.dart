import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/helpers/connectivity_helper.dart';
import 'package:ifriend_app/core/services/endpoint.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/controller/alllocation_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/model/allsavezone_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:ifriend_app/features/new/coree/dio/dio_helper.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';

part 'editlocation_state.dart';

class EditLocationCubit extends Cubit<EditLocationState> {
  EditLocationCubit() : super(EditLocationInitial());
  static EditLocationCubit get(BuildContext context) =>
      BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();

  var locationNameController = TextEditingController();
  var locationSaveZoneController = TextEditingController();
  var locationSearchController = TextEditingController();
  String safeZoneId = "";
  Future<void> editLocation() async {
    try {
      final hasInternet = await FastConnectivityHelper.hasNetwork();
      if (!hasInternet) {
        emit(EditLocationFailure("internet"));
        return;
      }
      log("Internet: $hasInternet");

      setLoading(true);
      emit(EditLocationLoading());

      // 1) طلب API
      final value = await DioHelper.putData(
        url: EndPoints.editSafeZoneLink(safeZoneId),
        token: HiveHelper.getData("token"),
        data: {
          "childProfileId": HiveHelper.getData("parentChildId"),
          "name": locationNameController.text,
          "latitude": currentPosition?.latitude,
          "longitude": currentPosition?.longitude,
          "radius": int.parse(locationSaveZoneController.text),
        },
      );
      log("Response: ${value.data}");
      log("STATUS CODE: ${value.statusCode}");
      log("FULL RESPONSE: ${value.data}");
      if (value.data["success"] == true) {
        setLoading(false);
        AllLocationCubit.get(Get.context!).getAllMyChildLocations();
        AllLocationCubit.get(Get.context!).getAllSaveZone();
        //EditLocationModel = EditLocationModel.fromJson(value.data);

        emit(EditLocationSuccess());
      } else {
        setLoading(false);

        emit(EditLocationFailure("error"));
      }
    } catch (e) {
      // emailBackendError = true;

      // 4) خطأ Exception

      setLoading(false);

      emit(EditLocationFailure("unknown"));
    }
  }

  Future<void> deleteLocation() async {
    try {
      final hasInternet = await FastConnectivityHelper.hasNetwork();
      if (!hasInternet) {
        emit(EditLocationFailure("internet"));
        return;
      }
      log("Internet: $hasInternet");

      setLoading(true);
      emit(EditLocationLoading());

      // 1) طلب API
      final value = await DioHelper.deleteData(
        url: EndPoints.deleteSafeZoneLink(safeZoneId),
        data: {},
        token: HiveHelper.getData("token"),
      );
      log("Response: ${value.data}");
      log("STATUS CODE: ${value.statusCode}");
      log("FULL RESPONSE: ${value.data}");
      if (value.data["success"] == true) {
        setLoading(false);

        AllLocationCubit.get(Get.context!).getAllMyChildLocations();
        AllLocationCubit.get(Get.context!).getAllSaveZone();
        Navigator.pop(Get.context!);
        //EditLocationModel = EditLocationModel.fromJson(value.data);

        emit(EditLocationSuccess());
      } else {
        setLoading(false);

        emit(EditLocationFailure("error"));
      }
    } catch (e) {
      // emailBackendError = true;

      // 4) خطأ Exception

      setLoading(false);

      emit(EditLocationFailure("unknown"));
    }
  }

  LatLng? currentPosition;
  Future<void> getCurrentLocation() async {
    emit(LocationLoading());

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw "Location services disabled";
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      final position = await Geolocator.getCurrentPosition();
      currentPosition = LatLng(position.latitude, position.longitude);

      emit(LocationLoaded(position: currentPosition!));
    } catch (e) {
      emit(LocationError());
    }
  }

  void updateLocation(LatLng newPosition) {
    currentPosition = newPosition;
    emit(LocationLoaded(position: newPosition));
  }

  Future<void> searchLocation(String query) async {
    if (query.trim().isEmpty) return;

    try {
      final locations = await locationFromAddress(query);

      if (locations.isEmpty) {
        if (state is! LocationError) {
          emit(LocationError());
        }
        return;
      }

      final latLng = LatLng(
        locations.first.latitude,
        locations.first.longitude,
      );

      updateLocation(latLng);
    } catch (e) {
      if (state is! LocationError) {
        emit(LocationError());
      }
    }
  }

  void oninitial({required SafeZones safeZones}) {
    locationNameController.text = safeZones.name ?? "";
    locationSaveZoneController.text = safeZones.radius.toString();
    safeZoneId = safeZones.id.toString();
    currentPosition = LatLng(
      safeZones.latitude!.toDouble(),
      safeZones.longitude!.toDouble(),
    );
  }

  bool isFilled = false;

  void updateFormState() {
    isFilled =
        locationNameController.text.isNotEmpty &&
        locationSaveZoneController.text.isNotEmpty &&
        coinsCount > 0;
    emit(EditLocationChangeVisibility());
  }

  void updateZoneRadius(String value) {
    locationSaveZoneController.text = value;
    emit(EditLocationChangeVisibility());
  }

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    emit(EditLocationLoadingWidget());
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
    emit(EditLocationChangeVisibility());
  }

  void clearAllData() {
    formKey = GlobalKey<FormState>();
    locationNameController.clear();
    locationSaveZoneController.clear();
    locationSearchController.clear();
    coinsCount = 0;
    emit(EditLocationClearAllData());
  }

  @override
  Future<void> close() {
    locationNameController.dispose();
    locationSaveZoneController.dispose();
    locationSearchController.dispose();

    print("🔥 disposed");

    return super.close();
  }
}
