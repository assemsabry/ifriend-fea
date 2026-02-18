import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/theme/font_manager.dart';
import 'package:ifriend_app/core/theme/styles_manager.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/features/new/featuress/auth/login/controller/login_cubit.dart';
import 'package:ifriend_app/features/new/featuress/auth/login/view/widget/sociallogin_botton.dart';
import 'package:ifriend_app/features/new/featuress/child/auth/comleteprofile/controller/childcompleteprofile_cubit.dart';
import 'package:ifriend_app/features/new/featuress/child/auth/comleteprofile/view/screen/completechild_profile.dart';
import 'package:ifriend_app/features/new/featuress/child/home/view/screen/childhome_screen.dart';
import 'package:ifriend_app/features/new/featuress/parent/completeprofile/controller/completeprofile_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/completeprofile/view/screen/completeprofile_screen.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/view/screen/parenthome_page.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is GoogleAuthLoading) {}
          if (state is GoogleAuthFailure) {
            Toastification().show(
              context: context,
              title: CustomText(
                title: state.error,
                fontSize: 14.sp,
                fontWeight: FontWeightManager.regular,
                fontFamily: FontConstants.fontFamily,
                color: ColorsManager.neutral600,
              ),
              type: ToastificationType.error,
            );
          }
          //  HiveHelper.addData("isLinked", true);

          if (state is GoogleAuthSuccess) {
            if (state.googleLoginModel.data!.user!.userType == "PARENT" &&
                state.googleLoginModel.data!.isNewUser == true) {
              CompleteProfileCubit.get(context).oninit(
                email: state.googleLoginModel.data!.user!.email!,
                firstName: state.googleLoginModel.data!.user!.firstName!,
                lastName: state.googleLoginModel.data!.user!.lastName!,
              );
              Get.offAll(() => const CompleteprofileScreen());
            } else if (state.googleLoginModel.data!.user!.userType ==
                    "PARENT" &&
                state.googleLoginModel.data!.isNewUser == false) {
              Get.offAll(() => const ParenthomePage());
            } else if (state.googleLoginModel.data!.user!.userType == "CHILD" &&
                state.googleLoginModel.data!.isNewUser == true) {
              ChildCompleteProfileCubit.get(context).oninit(
                firstName: state.googleLoginModel.data!.user!.firstName!,
                lastName: state.googleLoginModel.data!.user!.lastName!,
                image: state.googleLoginModel.data!.user!.avatarUrl!,
              );
              Get.offAll(() => const CompletechildProfile());
            } else if (state.googleLoginModel.data!.user!.userType == "CHILD" &&
                state.googleLoginModel.data!.isNewUser == false) {
              Get.offAll(() => const ChildhomeScreen());
            }
          }
        },
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: ColorsManager.primary,
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ColorsManager.primary, ColorsManager.primary700],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SafeArea(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          _buildTopSection(),
                          Expanded(
                            child: _buildCenterIllustration(
                              LoginCubit.get(context).isLoading,
                            ),
                          ),
                          _buildBottomCard(
                            context,
                            LoginCubit.get(context).isLoading,
                          ),
                        ],
                      ),
                      if (LoginCubit.get(context).isLoading)
                        _buildLoadingOverlay(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).pushReplacementNamed(Routes.userRoleScreen);
          },
          child: Container(
            width: 48.w,
            height: 48.w,
            decoration: const BoxDecoration(
              color: ColorsManager.back,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
          ),
        ),
      ),
    );
  }

  Widget _buildCenterIllustration(bool isLoading) {
    return Center(
      child: Opacity(
        opacity: isLoading ? 0.5 : 1.0,
        child: Image.asset(
          'assets/images/login.png',
          width: 280.w,
          height: 280.w,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildBottomCard(BuildContext context, bool isLoading) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            SizedBox(height: 12.h),
            _buildDescription(),
            SizedBox(height: 32.h),
            _buildGoogleButton(context, isLoading),
            SizedBox(height: 16.h),
            _buildFacebookButton(context, isLoading),
            SizedBox(height: 16.h),
            //   if (isLoading) _buildLoadingOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return RichText(
      text: TextSpan(
        style: TextStyles.font32Black600Weight,
        children: [
          const TextSpan(text: 'Welcome\nto '),
          TextSpan(
            text: 'I Friend',
            style: TextStyle(
              color: const Color(0xFF2196F3),
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(text: ' control !'),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      'Start your journey in protecting and monitoring your child with ease and intelligence.',
      style: TextStyles.font14Grey500Weight,
      maxLines: 3,
    );
  }

  Widget _buildGoogleButton(BuildContext context, bool isLoading) {
    return SocialloginBotton(
      onPressed: LoginCubit.get(context).isLoading
          ? null
          : LoginCubit.get(context).loginWithGoogle,
      backgroundColor: ColorsManager.primary,
      icon: Image.asset("assets/images/google.png"),
      text: 'Login With Google',
      isEnabled: !isLoading,
    );
  }

  Widget _buildFacebookButton(BuildContext context, bool isLoading) {
    return SocialloginBotton(
      onPressed: () {
        // Get.to(() => const RoleScreen());
      },

      // onPressed: isLoading ? null : _handleFacebookSignIn,
      backgroundColor: ColorsManager.primary,
      icon: Image.asset("assets/images/facebook.png"),
      text: 'Login With Facebook',
      isEnabled: !isLoading,
    );
  }

  Widget _buildLoadingOverlay() {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100.h),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
