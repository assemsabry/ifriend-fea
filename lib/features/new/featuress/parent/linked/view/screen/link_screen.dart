import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/constants/imges.dart';
import 'package:ifriend_app/core/constants/strings.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/theme/styles_manager.dart';
import 'package:ifriend_app/core/widgets/custom_asset_image_widget.dart';
import 'package:ifriend_app/core/widgets/custom_button.dart';
import 'package:ifriend_app/features/new/coree/constants/def_appbar.dart';
import 'package:ifriend_app/features/new/featuress/parent/linked/controller/qrcode_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/linked/view/screen/scanqrcode_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class LinkScreen extends StatelessWidget {
  const LinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<QrCodeCubit, QrCodeState>(
      listener: (context, state) {
        if (state is QrCodePermissionGranted) {
          Get.to(() => ScanqrcodeScreen());
        }
        if (state is QrCodePermissionDenied) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Camera permission'),
              content: const Text(
                'Camera permission is permanently denied. Open settings to enable it.',
              ),
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
        }
      },
      child: Scaffold(
        appBar: DefAppbar(title: "", backIcon: true),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                  style: TextStyles.font20Black500Weight
                                      .copyWith(
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
                                        .copyWith(
                                          color: ColorsManager.baseBlack,
                                        ),
                                  ),
                                  SizedBox(height: 4.h),

                                  RichText(
                                    text: TextSpan(
                                      style: TextStyles.font14Grey500Weight
                                          .copyWith(
                                            fontWeight: FontWeight.w400,
                                          ),
                                      children: [
                                        TextSpan(
                                          text:
                                              '${AppStrings.subInstallIFriendOnChildDevice} ',
                                        ),
                                        WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
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
                                  style: TextStyles.font20Black500Weight
                                      .copyWith(
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
                                        .copyWith(
                                          color: ColorsManager.baseBlack,
                                        ),
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
                                  style: TextStyles.font20Black500Weight
                                      .copyWith(
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
                                        .copyWith(
                                          color: ColorsManager.baseBlack,
                                        ),
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
                        onPressed: () {
                          QrCodeCubit.get(context).checkAndRequestPermission();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
