import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';
import 'package:ifriend_app/core/services/endpoint.dart';
import 'package:ifriend_app/features/new/coree/helper/google_service.dart';
import 'package:ifriend_app/features/new/featuress/auth/login/model/login_model.dart';
import 'package:ifriend_app/features/new/featuress/role/controller/role_cubit.dart';
import 'package:ifriend_app/features/new/coree/dio/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  final GoogleAuthService googleAuthService = GoogleAuthService();

  LoginModel? googleLoginModel;
  bool isLoading = false;
  Future<void> loginWithGoogle() async {
    setLoading(true);
    emit(GoogleAuthLoading());

    final token = await googleAuthService.signInWithGoogle();

    if (token == null) {
      emit(GoogleAuthFailure("Google Sign In failed"));
      setLoading(false);
      return;
    }

    try {
      final value = await DioHelper.postData(
        url: EndPoints.googleLogInLink,
        data: {
          "idToken": token,
          "role": RoleCubit.get(Get.context!).userRole == UserRole.CHILD
              ? "CHILD"
              : "PARENT",
        },
        option: true,
      );

      if (value.data["success"] == true) {
        googleLoginModel = LoginModel.fromJson(value.data);
        HiveHelper.addData("step", "2");
        setLoading(false);

        HiveHelper.addData("token", googleLoginModel!.data!.accessToken!);
        HiveHelper.addData(
          "refreshToken",
          googleLoginModel!.data!.refreshToken!,
        );
        HiveHelper.addData("isNewUser", googleLoginModel!.data!.isNewUser!);
        HiveHelper.addData("role", googleLoginModel!.data!.user!.userType!);

        emit(GoogleAuthSuccess(googleLoginModel: googleLoginModel!));
      } else {
        setLoading(false);

        emit(GoogleAuthFailure("Google Sign In failed"));
      }
    } catch (e) {
      emit(GoogleAuthFailure("Google Sign In failed"));
      setLoading(false);
    }
  }

  void setLoading(bool value) {
    isLoading = value;
    emit(LoginLoadingWidget());
  }

  bool isVisible = true;

  void changeVisibility() {
    isVisible = !isVisible;

    emit(LoginChangeVisibility());
  }

  // void clearAllData() {
  //   formKey = GlobalKey<FormState>();
  //   emailController.clear();
  //   passwordController.clear();
  //   emit(LoginClearAllData());
  // }

  // @override
  // Future<void> close() {
  //   emailController.dispose();
  //   passwordController.dispose();

  //   log("🔥 disposed");

  //   return super.close();
  // }
}
