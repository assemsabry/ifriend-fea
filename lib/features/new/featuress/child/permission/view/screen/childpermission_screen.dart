import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/core/widgets/def_button.dart';
import 'package:ifriend_app/features/new/config/themes/sizing.dart';
import 'package:ifriend_app/features/new/coree/constants/def_appbar.dart';
import 'package:ifriend_app/features/new/featuress/child/auth/qrcode/view/screen/letsconnect_screen.dart';
import 'package:ifriend_app/features/new/featuress/child/permission/controller/permission_cubit.dart';
import 'package:ifriend_app/features/old/permissions/presentation/widgets/permission_card.dart';

class ChildpermissionScreen extends StatelessWidget {
  const ChildpermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PermissionCubit()..checkDevicePermissions(),
      child: BlocConsumer<PermissionCubit, PermissionState>(
        listener: (context, state) {
          if (state is PermissionError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }

          if (state is PermissionLoaded && state.allGranted) {}
        },
        builder: (context, state) {
          final cubit = PermissionCubit.get(context);

          if (state is PermissionLoaded) {}

          return Scaffold(
            backgroundColor: ColorsManager.baseWhite,
            appBar: DefAppbar(
              title: "",
              color: ColorsManager.baseWhite,
              backIcon: true,
            ),
            body: Container(
              padding: AppSizing.customPadding(),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 16.h),
                  // Illustration icon
                  Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorsManager.primary.withOpacity(0.1),
                      border: Border.all(
                        color: ColorsManager.primary.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.verified_user_outlined,
                      size: 60.sp,
                      color: ColorsManager.primary,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Title
                  CustomText(
                    title: "Enable Permission",
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorsManager.baseBlack,
                    fontFamily: 'Poppins',
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 8.h),
                  // Subtitle
                  CustomText(
                    title:
                        "Allow access to enhance functionality and improve experience.",
                    textAlign: TextAlign.center,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsManager.neutral500,
                    fontFamily: 'Poppins',
                  ),
                  SizedBox(height: 32.h),
                  // Permission cards
                  PermissionCard(
                    icon: Icons.notifications_outlined,
                    title: 'Enable Notification Access',
                    description:
                        'This helps us monitor notifications for safety and parental alerts.',
                    isGranted: cubit.notificationGranted,
                    onTap: () {
                      cubit.requestPermission('notification');
                    },
                  ),
                  PermissionCard(
                    icon: Icons.location_on_outlined,
                    title: 'Allow Location Access',
                    description:
                        'Used to show your child\'s location and keep them safe.',
                    isGranted: cubit.locationGranted,
                    onTap: () {
                      cubit.requestPermission('location');
                    },
                  ),
                  PermissionCard(
                    icon: Icons.phone_android_outlined,
                    title: 'Allow Device Access',
                    description:
                        'We need access to your device settings to manage screen time and app use.',
                    isGranted: cubit.deviceGranted,
                    onTap: () {
                      cubit.requestPermission('device');
                    },
                  ),
                  PermissionCard(
                    icon: Icons.bar_chart_outlined,
                    title: 'Grant Usage Access',
                    description:
                        'We use this permission to track which apps are used and for how long.',
                    isGranted: cubit.usageGranted,
                    onTap: () {
                      cubit.requestPermission('usage');
                    },
                  ),
                  // PermissionCard(
                  //   icon: Icons.wifi,
                  //   title: 'Allow Bloc ADS',
                  //   description:
                  //       'We need access to your device settings to manage screen time and app use.',
                  //   isGranted: deviceGranted,
                  //   onTap: () {
                  //     cubit.requestDeviceAccess();
                  //   },
                  // ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: 100.h,
              padding: AppSizing.customPadding(),
              child: Column(
                children: [
                  DefButton(
                    title: "Enable Permission",
                    buttoncolor: cubit.allGranted
                        ? ColorsManager.primary
                        : ColorsManager.primary.withOpacity(0.3),
                    onPressed: cubit.allGranted
                        ? () {
                            Get.to(() => LetsconnectScreen());
                          }
                        : () {},
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
