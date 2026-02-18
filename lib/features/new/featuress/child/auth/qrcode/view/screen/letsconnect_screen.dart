import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/theme/styles_manager.dart';
import 'package:ifriend_app/core/widgets/def_button.dart';
import 'package:ifriend_app/features/new/config/themes/sizing.dart';
import 'package:ifriend_app/features/new/coree/constants/def_appbar.dart';
import 'package:ifriend_app/features/new/featuress/child/auth/qrcode/controller/qrcode_cubit.dart';
import 'package:ifriend_app/features/new/featuress/child/auth/qrcode/view/screen/show_qr_code_screen.dart';

class LetsconnectScreen extends StatelessWidget {
  const LetsconnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefAppbar(title: "", backIcon: true),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  'Let’s Connect Your Device!',
                  style: TextStyles.font26Black600Weight,
                ),
                SizedBox(height: 12.h),
                Text(
                  'Your parent will scan a QR code from their phone to link your device safely.',
                  style: TextStyles.font16Grey500Weight.copyWith(
                    fontWeight: FontWeight.normal,
                    color: ColorsManager.neutral500,
                  ),
                ),
                SizedBox(height: 40.h),
                _buildStep(
                  '01',
                  'Ready to Scan',
                  'Make sure your parent’s phone is nearby. When you’re ready, tap the button below to show your QR code.',
                ),
                SizedBox(height: 24.h),
                _buildStep(
                  '02',
                  'Show the QR Code',
                  'Hold your phone steady and show this code to your parent’s camera.',
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
          // if (state is DeviceLinkLoading)
          // Container(
          //   color: Colors.black54,
          //   child: const Center(
          //     child: CircularProgressIndicator(color: ColorsManager.primary),
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100.h,
        padding: AppSizing.customPadding(),
        child: Column(
          children: [
            DefButton(
              title: 'Show My QR Code',
              onPressed: () {
                QrcodeCubit.get(context).generateQrCode();
                Get.to(() => QrCodeChildScreen());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String number, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: ColorsManager.primary,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: ColorsManager.baseWhite,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: ColorsManager.baseBlack,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                description,
                style: TextStyle(
                  color: ColorsManager.neutral600,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
