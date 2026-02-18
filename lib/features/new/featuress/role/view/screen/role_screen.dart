import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/theme/font_manager.dart';
import 'package:ifriend_app/core/theme/styles_manager.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/core/widgets/def_button.dart';
import 'package:ifriend_app/features/new/featuress/auth/login/view/screen/login_screen.dart';
import 'package:ifriend_app/features/new/featuress/role/controller/role_cubit.dart';
import 'package:ifriend_app/features/new/featuress/role/view/widget/role_card.dart';
import 'package:toastification/toastification.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoleCubit, RoleState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F7F9),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32.h),
                  Text(
                    "Who’s using the device?",
                    style: TextStyles.font26Black600Weight,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Choose your role to continue — Parent or Child.",
                    style: TextStyles.font15Grey400Weight,
                  ),
                  SizedBox(height: 28.h),
                  RoleCard(
                    selected:
                        RoleCubit.get(context).userRole == UserRole.PARENT,
                    title: "I’m a Parent",
                    description:
                        "Set screen limits, monitor activity, and keep your child safe online.",
                    imagePath: 'assets/images/parent.png',
                    onTap: () {
                      RoleCubit.get(context).onTypeChange(0);
                    },
                  ),
                  SizedBox(height: 16.h),
                  RoleCard(
                    selected: RoleCubit.get(context).userRole == UserRole.CHILD,
                    title: "I’m a Child",
                    description:
                        "Play, learn, and use your apps safely — with your parent’s guidance.",
                    imagePath: 'assets/images/child.png',
                    onTap: () {
                      RoleCubit.get(context).onTypeChange(1);
                    },
                  ),
                  const Spacer(),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 120.h,
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                DefButton(
                  title: "Continue",
                  onPressed: () {
                    if (RoleCubit.get(context).userRole != UserRole.none) {
                      Get.to(() => LoginScreen());
                    } else {
                      Toastification().show(
                        context: context,
                        title: CustomText(
                          title: "Please select a role",
                          fontSize: 14.sp,
                          fontWeight: FontWeightManager.regular,
                          fontFamily: FontConstants.fontFamily,
                          color: ColorsManager.neutral600,
                        ),
                        type: ToastificationType.error,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
