import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/core/helpers/connectivity_helper.dart';
import 'package:ifriend_app/features/new/coree/dio/dio_helper.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';
import 'package:ifriend_app/features/new/coree/service/endpoint.dart';

part 'completeprofile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit() : super(CompleteProfileInitial());
  static CompleteProfileCubit get(BuildContext context) =>
      BlocProvider.of(context);
  var formKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();

  Future<void> completeProfile() async {
    setLoading(true);
    emit(CompleteProfileLoading());
    try {
      final hasInternet = await FastConnectivityHelper.hasNetwork();
      if (!hasInternet) {
        setLoading(false);

        emit(CompleteProfileFailure(error: "check your internet connection"));
        return;
      }
      log("Internet: $hasInternet");
      final normalizedPhone = _normalizePhone(phoneNumberController.text);

      if (!(normalizedPhone.length == 11 && normalizedPhone.startsWith('0'))) {
        setLoading(false);
        emit(
          CompleteProfileFailure(
            error: 'Phone number must be 11 digits (e.g. 011xxxxxxxx)',
          ),
        );
        return;
      }
      // 1) طلب API
      final value = await DioHelper.postDataWithFile(
        url: EndPoints.completeProfileLink,
        token: HiveHelper.getData("token"),
        data: {
          "firstName": firstNameController.text,
          "lastName": lastNameController.text,
          "phoneNumber": normalizedPhone,
          "email": emailController.text,
        },
        file: image.isEmpty ? null : image.first,
        fileKey: "avatar",
      );
      log("response: $value");
      log("response: ${value.data}");

      if (value.data["success"] == true) {
        setLoading(false);
        clearAllData();
        emit(CompleteProfileSuccess());
      } else {
        setLoading(false);

        emit(
          CompleteProfileFailure(
            error:
                value.data["message"] ??
                "there is an error in the data, try again",
          ),
        );
      }
    } catch (e) {
      setLoading(false);
      log(e.toString());
      emit(CompleteProfileFailure(error: "  $e  "));
    }
  }

  String _normalizePhone(String input) {
    var digits = input.replaceAll(RegExp(r'[^0-9]'), '');

    // Remove international prefix variants for Egypt
    if (digits.startsWith('00')) {
      // e.g. 00201112345678 -> remove leading 00 -> 201112345678
      digits = digits.replaceFirst(RegExp(r'^00'), '');
    }
    if (digits.startsWith('20')) {
      // remove country code -> remaining should be without leading 0
      digits = digits.substring(2);
    }

    // At this point, digits is expected to be either 10 digits (without leading 0)
    // or 11 digits (with leading 0). Normalize to leading 0 + 10 digits.
    if (digits.length == 10) {
      digits = '0$digits';
    }

    return digits;
  }

  List<File> image = [];
  String? imageUrl;
  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );

      if (result != null) {
        PlatformFile file = result.files.single;

        if (file.path != null) {
          image = [File(file.path!)];
        }

        emit(PickFileSuccessStates());

        log('Picked file: ${file.name}');
      } else {
        log('User canceled the picker');
      }
    } catch (e) {
      log('An error occurred while picking the file: $e');
    }
  }

  void oninit({
    required String email,
    required String firstName,
    required String lastName,
  }) {
    emailController.text = email;
    firstNameController.text = firstName;
    lastNameController.text = lastName;
  }

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    emit(CompleteProfileIsLoadingWidget());
  }

  bool isValida = false;

  void setIsValida(bool value) {
    isValida = value;
    emit(CompleteProfileChangeRequidedWidget());
  }

  void clearAllData() {
    formKey = GlobalKey<FormState>();
    firstNameController.clear();
    lastNameController.clear();
    phoneNumberController.clear();
    emailController.clear();

    emit(CompleteProfileClearAllData());
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();

    print("🔥 CompleteProfileCubit disposed");

    return super.close();
  }
}
