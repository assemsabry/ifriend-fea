import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/core/services/endpoint.dart';
import 'package:ifriend_app/features/new/coree/dio/dio_helper.dart';
import 'package:ifriend_app/features/new/featuress/child/auth/qrcode/model/generatecode_model.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';

part 'qrcode_state.dart';

class QrcodeCubit extends Cubit<QrcodeState> {
  QrcodeCubit() : super(QrcodeInitial());

  static QrcodeCubit get(BuildContext context) => BlocProvider.of(context);
  Timer? _timer;
  GeneratecodeModel? generatecodeModel;
  Future<void> generateQrCode() async {
    final deviceId = await HiveHelper.getDeviceId();
    emit(GenerateQrCodeLoadingStates());
    try {
      final response = await DioHelper.postData(
        url: EndPoints.generateQrCode,
        token: HiveHelper.getData("token"),
        data: {"deviceId": deviceId.toString()},
        option: true,
      );

      if (response.statusCode == 200) {
        generatecodeModel = GeneratecodeModel.fromJson(response.data);
        startCheckingApproval();
        emit(
          GenerateQrCodeSuccessStates(generatecodeModel: generatecodeModel!),
        );
      } else {
        emit(QrCodeErrorStates(error: response.data.toString()));
      }
    } catch (e) {
      emit(GenerateQrCodeErrorStates(error: e.toString()));
    }
  }

  Future<void> regenerateQrCode() async {
    // final deviceId = await HiveHelper.getDeviceId();
    emit(GenerateQrCodeLoadingStates());
    try {
      final response = await DioHelper.postData(
        url: EndPoints.regenerateQrCode,
        token: HiveHelper.getData("token"),
        data: {"requestId": generatecodeModel!.data!.requestId!},
        option: true,
      );

      if (response.statusCode == 200) {
        generatecodeModel = GeneratecodeModel.fromJson(response.data);
        startCheckingApproval();
        emit(
          GenerateQrCodeSuccessStates(generatecodeModel: generatecodeModel!),
        );
      } else {
        emit(QrCodeErrorStates(error: response.data.toString()));
      }
    } catch (e) {
      emit(GenerateQrCodeErrorStates(error: e.toString()));
    }
  }

  // void startCheckingApproval() {
  //   _timer?.cancel(); // نلغي أي تايمر سابق

  //   _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
  //     checkApproval();
  //   });
  // }

  // void stopCheckingApproval() {
  //   _timer?.cancel();
  //   _timer = null;
  // }

  bool isChecking = false;

  Future<void> checkApproval() async {
    if (isChecking) return; // 👈 يمنع التكرار

    isChecking = true;
    try {
      final response = await DioHelper.getData(
        url: EndPoints.getLinkStatusChildLink,
        token: HiveHelper.getData("token"),
      );

      if (response.statusCode == 200) {
        final List requests = response.data['data']['requests'];

        final hasApproved = requests.any(
          (item) => item['status'] == 'APPROVED',
        );

        if (hasApproved) {
          _timer?.cancel();
          emit(QrCodeSuccessStates());
        } else {
          emit(QrCodePendingStates());
        }
      } else {
        emit(QrCodeErrorStates(error: response.data.toString()));
      }
    } catch (e) {
      emit(QrCodeErrorStates(error: e.toString()));
    } finally {
      isChecking = false;
    }
  }

  bool _isPolling = false;

  void startCheckingApproval() {
    if (_isPolling) return;

    _isPolling = true;
    _pollApproval();
  }

  void stopCheckingApproval() {
    _isPolling = false;
  }

  Future<void> _pollApproval() async {
    while (_isPolling) {
      await Future.delayed(const Duration(seconds: 3));

      if (!_isPolling) break;

      try {
        final response = await DioHelper.getData(
          url: EndPoints.getLinkStatusChildLink,
          token: HiveHelper.getData("token"),
        );

        if (response.statusCode == 200) {
          final List requests = response.data['data']['requests'];

          final hasApproved = requests.any(
            (item) => item['status'] == 'APPROVED',
          );

          if (hasApproved) {
            _isPolling = false;
            emit(QrCodeSuccessStates());
            break;
          } else {
            emit(QrCodePendingStates());
          }
        } else {
          emit(QrCodeErrorStates(error: response.data.toString()));
        }
      } catch (e) {
        emit(QrCodeErrorStates(error: e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    stopCheckingApproval();
    return super.close();
  }
}
