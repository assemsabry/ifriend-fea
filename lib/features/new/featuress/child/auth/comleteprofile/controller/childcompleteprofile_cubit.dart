import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/core/helpers/connectivity_helper.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/features/new/coree/dio/dio_helper.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';
import 'package:ifriend_app/features/new/coree/service/endpoint.dart';

part 'childcompleteprofile_state.dart';

enum Gender { none, boy, girl }

class ChildCompleteProfileCubit extends Cubit<ChildCompleteProfileState> {
  ChildCompleteProfileCubit() : super(ChildCompleteProfileInitial());
  static ChildCompleteProfileCubit get(BuildContext context) =>
      BlocProvider.of(context);
  var formKey = GlobalKey<FormState>();

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var dateOfBirthController = TextEditingController();

  final List<String> avatarPaths = [
    'assets/images/avatar1.png',
    'assets/images/avatar2.png',
    'assets/images/avatar3.png',
    'assets/images/avatar4.png',
    'assets/images/avatar5.png',
  ];
  String imageUrl = "";
  String? selectedAvatarPath;
  void onAvatarSelected(String avatarPath) {
    selectedAvatarPath = avatarPath;
    emit(ChildCompleteProfileChangeVisibility());
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorsManager.primary,
              onPrimary: Colors.white,
              onSurface: ColorsManager.baseBlack,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // context.read<ChildProfileBloc>().add(DateOfBirthChanged(picked));
      final pickedDate = DateTime(picked.year, picked.month, picked.day);

      final formattedDate =
          "${pickedDate.year.toString().padLeft(4, '0')}-"
          "${pickedDate.month.toString().padLeft(2, '0')}-"
          "${pickedDate.day.toString().padLeft(2, '0')}";

      dateOfBirthController.text = formattedDate;

      log("Sending date: $formattedDate");
    }
    emit(ChildCompleteProfileChangeVisibility());
  }

  Future<void> completeChildProfile() async {
    setLoading(true);
    emit(ChildCompleteProfileLoading());
    try {
      final hasInternet = await FastConnectivityHelper.hasNetwork();
      if (!hasInternet) {
        setLoading(false);

        emit(
          ChildCompleteProfileFailure(error: "check your internet connection"),
        );
        return;
      }
      log("Internet: $hasInternet");

      // 1) طلب API
      final value = await DioHelper.postData(
        url: EndPoints.completeChildProfileLink,
        token: HiveHelper.getData("token"),
        data: {
          "firstName": firstNameController.text,
          "lastName": lastNameController.text,
          "dateOfBirth": dateOfBirthController.text.trim(),
          "gender": gender.name.toUpperCase(),
          "avatar": imageUrl,
        },
        option: true,
        // file: image.isEmpty ? null : image.first,
        // fileKey: "avatar",
      );
      log("response: $value");
      log("response: ${value.data}");

      if (value.data["success"] == true) {
        setLoading(false);
        clearAllData();
        emit(ChildCompleteProfileSuccess());
      } else {
        setLoading(false);

        emit(
          ChildCompleteProfileFailure(error: value.data["error"]["message"]),
        );
      }
    } catch (e) {
      setLoading(false);
      log(e.toString());
      emit(ChildCompleteProfileFailure(error: "  $e  "));
    }
  }

  Gender gender = Gender.none;

  void onGenderChange(int index) {
    gender = index == 0 ? Gender.boy : Gender.girl;
    log(gender.name);
    emit(ChildCompleteProfileChangeVisibility());
  }

  void oninit({
    required String firstName,
    required String lastName,
    required String image,
  }) {
    firstNameController.text = firstName;
    lastNameController.text = lastName;
    imageUrl = image;
  }

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    emit(ChildCompleteProfileIsLoadingWidget());
  }

  bool isValida = false;

  void setIsValida(bool value) {
    isValida = value;
    emit(ChildCompleteProfileChangeRequidedWidget());
  }

  void clearAllData() {
    formKey = GlobalKey<FormState>();
    firstNameController.clear();
    lastNameController.clear();
    dateOfBirthController.clear();

    emit(ChildCompleteProfileClearAllData());
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    dateOfBirthController.dispose();

    print("🔥 CompleteProfileCubit disposed");

    return super.close();
  }
}
