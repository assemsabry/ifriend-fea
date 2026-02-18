import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/helpers/connectivity_helper.dart';
import 'package:ifriend_app/core/services/endpoint.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/view/screen/parenthome_page.dart';
import 'package:ifriend_app/features/new/featuress/parent/linked/model/successscan_model.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ifriend_app/features/new/coree/dio/dio_helper.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';

part 'qrcode_state.dart';

class QrCodeCubit extends Cubit<QrCodeState> {
  QrCodeCubit() : super(QrCodeInitial());
  static QrCodeCubit get(BuildContext context) => BlocProvider.of(context);

  String? scannedQrToken;

  Future<void> checkAndRequestPermission() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      emit(QrCodePermissionGranted());
      return;
    }

    status = await Permission.camera.request();

    if (status.isGranted) {
      emit(QrCodePermissionGranted());
    } else if (status.isPermanentlyDenied) {
      emit(QrCodePermissionDenied());
    } else {
      emit(QrCodePermissionDenied());
    }
  }

  SuccessScanModel? scanModel;
  Future<void> scanQrLinkDevice({required String qrCodeData}) async {
    if (isLoading) return;
    scannedQrToken = qrCodeData;
    setLoading(true);
    emit(ScanQrCodeLoading());
    try {
      final hasInternet = await FastConnectivityHelper.hasNetwork();
      if (!hasInternet) {
        setLoading(false);

        emit(ScanQrCodeFailure("check your internet connection"));
        return;
      }
      log("Internet: $hasInternet");

      // 1) طلب API
      final value = await DioHelper.postData(
        url: EndPoints.scanQrLinkDeviceLink,
        token: HiveHelper.getData("token"),
        option: true,
        data: {"qrCodeData": qrCodeData},
      );

      if (value.data["success"] == true) {
        setLoading(false);
        scanModel = SuccessScanModel.fromJson(value.data);
        emit(ScanQrCodeSuccess(scanModel!));
      } else {
        setLoading(false);

        emit(
          ScanQrCodeFailure(
            value.data["message"] ?? "there is an error in the data, try again",
          ),
        );
      }
    } catch (e) {
      setLoading(false);

      emit(ScanQrCodeFailure(e.toString()));
    }
  }

  void resetScan() {
    emit(QrCodeInitial());
  }

  Future<void> confirmQrLinkDevice({required String qrCodeData}) async {
    setLoading(true);
    emit(QrCodeConfirmLoading());
    try {
      final hasInternet = await FastConnectivityHelper.hasNetwork();
      if (!hasInternet) {
        setLoading(false);

        emit(QrCodeConfirmFailure("check your internet connection"));
        return;
      }
      log("Internet: $hasInternet");

      final value = await DioHelper.postData(
        url: EndPoints.confirmQrLinkDeviceLink,
        token: HiveHelper.getData("token"),
        option: true,
        data: {"qrCodeData": qrCodeData},
      );

      if (value.data["success"] == true) {
        setLoading(false);
        Get.offAll(() => ParenthomePage());
        emit(QrCodeConfirmSuccess());
      } else {
        setLoading(false);

        emit(
          QrCodeConfirmFailure(
            value.data["message"] ?? "there is an error in the data, try again",
          ),
        );
      }
    } catch (e) {
      setLoading(false);

      emit(QrCodeConfirmFailure(e.toString()));
    }
  }

  final MobileScannerController controller = MobileScannerController();

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    emit(QrCodeIsLoadingWidget());
  }

  int? currentType;

  void onTypeChange(int index) {
    currentType = index;
    emit(QrCodeTypeChanged());
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
