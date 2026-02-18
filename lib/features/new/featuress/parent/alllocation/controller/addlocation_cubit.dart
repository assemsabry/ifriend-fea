import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/helpers/connectivity_helper.dart';
import 'package:ifriend_app/core/services/endpoint.dart';
import 'package:ifriend_app/features/new/coree/dio/dio_helper.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/controller/alllocation_cubit.dart';
import 'package:latlong2/latlong.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';

part 'addlocation_state.dart';

class AddLocationCubit extends Cubit<AddLocationState> {
  AddLocationCubit() : super(AddLocationInitial());
  static AddLocationCubit get(BuildContext context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();

  var locationNameController = TextEditingController();
  var locationSaveZoneController = TextEditingController(text: "1000");
  var locationSearchController = TextEditingController();

  Future<void> addLocation() async {
    try {
      final hasInternet = await FastConnectivityHelper.hasNetwork();
      if (!hasInternet) {
        emit(AddLocationFailure("internet"));
        return;
      }
      log("Internet: $hasInternet");

      setLoading(true);
      emit(AddLocationLoading());

      // 1) طلب API
      final value = await DioHelper.postData(
        url: EndPoints.createLocationLink,
        token: HiveHelper.getData("token"),
        data: {
          "childProfileId": HiveHelper.getData("parentChildId"),
          "name": locationNameController.text,
          "latitude": currentPosition?.latitude,
          "longitude": currentPosition?.longitude,
          "radius": int.parse(locationSaveZoneController.text),
        },
        option: true,
      );
      log("Response: ${value.data}");
      log("STATUS CODE: ${value.statusCode}");
      log("FULL RESPONSE: ${value.data}");
      if (value.data["success"] == true) {
        setLoading(false);
        Navigator.pop(Get.context!);
        AllLocationCubit.get(Get.context!).getAllMyChildLocations();
        AllLocationCubit.get(Get.context!).getAllSaveZone();
        //AddLocationModel = AddLocationModel.fromJson(value.data);

        emit(AddLocationSuccess());
      } else {
        setLoading(false);

        emit(AddLocationFailure("error"));
      }
    } catch (e) {
      // emailBackendError = true;

      // 4) خطأ Exception

      setLoading(false);

      emit(AddLocationFailure("unknown"));
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

  bool isFilled = false;

  void updateFormState() {
    isFilled =
        locationNameController.text.isNotEmpty &&
        locationSaveZoneController.text.isNotEmpty &&
        coinsCount > 0;
    emit(AddLocationChangeVisibility());
  }

  void updateZoneRadius(String value) {
    locationSaveZoneController.text = value;
    emit(AddLocationChangeVisibility());
  }

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    emit(AddLocationLoadingWidget());
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
    emit(AddLocationChangeVisibility());
  }

  void clearAllData() {
    formKey = GlobalKey<FormState>();
    locationNameController.clear();
    locationSaveZoneController.clear();
    locationSearchController.clear();
    coinsCount = 0;
    emit(AddLocationClearAllData());
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
