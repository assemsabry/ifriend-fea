import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/constants/imges.dart';
import 'package:ifriend_app/core/constants/strings.dart';
import 'package:ifriend_app/core/helpers/extensions.dart';
import 'package:ifriend_app/core/routing/routes.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/theme/styles_manager.dart';
import 'package:ifriend_app/core/widgets/custom_asset_image_widget.dart';
import 'package:ifriend_app/core/widgets/custom_button.dart';
import '../../core/widgets/custom_button_back.dart';
import 'package:ifriend_app/features/device_linking_scan_qr/presentation/cubit/scan_qr_cubit.dart';
import 'package:ifriend_app/features/device_linking_scan_qr/presentation/cubit/scan_qr_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class StepsToLinkWithChildDeviceScreen extends StatelessWidget {
  const StepsToLinkWithChildDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 72,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CustomButtonBack(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Make content scrollable and keep button fixed at bottom
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16, width: double.infinity),
                      Text(
                        AppStrings.linkYourChildDevice,
                        style: TextStyles.font20Black500Weight.copyWith(
                          fontSize: 26.sp,
                          color: ColorsManager.baseBlack,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        AppStrings.subLinkYourChildDevice,
                        style: TextStyles.font14Grey500Weight.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 22.h),
                      Row(
                        children: [
                          Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: ColorsManager.primary,
                            ),
                            child: Center(
                              child: Text(
                                "01",
                                style: TextStyles.font20Black500Weight.copyWith(
                                  fontSize: 22.sp,
                                  color: ColorsManager.baseWhite,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.installIFriendOnChildDevice,
                                  style: TextStyles.font18White500Weight
                                      .copyWith(color: ColorsManager.baseBlack),
                                ),
                                SizedBox(height: 4.h),

                                RichText(
                                  text: TextSpan(
                                    style: TextStyles.font14Grey500Weight
                                        .copyWith(fontWeight: FontWeight.w400),
                                    children: [
                                      TextSpan(
                                        text:
                                            '${AppStrings.subInstallIFriendOnChildDevice} ',
                                      ),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: CustomAssetImageWidget(
                                          Images.logo,
                                          height: 25,
                                          width: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 22.h),
                      Row(
                        children: [
                          Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: ColorsManager.primary,
                            ),
                            child: Center(
                              child: Text(
                                "02",
                                style: TextStyles.font20Black500Weight.copyWith(
                                  fontSize: 22.sp,
                                  color: ColorsManager.baseWhite,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.getTheQrCode,
                                  style: TextStyles.font18White500Weight
                                      .copyWith(color: ColorsManager.baseBlack),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  AppStrings.subGetTheQrCode,
                                  style: TextStyles.font14Grey500Weight
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 22.h),
                      Row(
                        children: [
                          Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: ColorsManager.primary,
                            ),
                            child: Center(
                              child: Text(
                                "03",
                                style: TextStyles.font20Black500Weight.copyWith(
                                  fontSize: 22.sp,
                                  color: ColorsManager.baseWhite,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.scanTheCode,
                                  style: TextStyles.font18White500Weight
                                      .copyWith(color: ColorsManager.baseBlack),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  AppStrings.subScanTheCode,
                                  style: TextStyles.font14Grey500Weight
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),

              SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      label: AppStrings.scanNow,
                      height: 55,
                      textStyle: TextStyles.font18White500Weight,
                      onPressed: () async {
                        // Request camera permission before navigating to the scanner
                        final cubit = context.read<ScanQrCubit>();
                        await cubit.checkAndRequestPermission();
                        final state = cubit.state;
                        if (state is ScanQrPermissionDenied) {
                          // Permission permanently denied — show settings dialog
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Camera permission'),
                              content: const Text(
                                  'Camera permission is permanently denied. Open settings to enable it.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    openAppSettings();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Settings'),
                                ),
                              ],
                            ),
                          );
                        } else if (state is ScanQrInitial || state is ScanQrPermissionGranted) {
                          // Permission granted — navigate to scanner
                          context.pushNamed(Routes.deviceLinkingScanQrScreen);
                        } else if (state is ScanQrFailure) {
                          // Show error
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Permission error'),
                              content: Text(state.message),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
