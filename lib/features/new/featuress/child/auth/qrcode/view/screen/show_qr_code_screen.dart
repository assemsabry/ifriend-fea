import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/features/new/featuress/child/home/view/screen/childhome_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/features/new/featuress/child/auth/qrcode/controller/qrcode_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class QrCodeChildScreen extends StatelessWidget {
  const QrCodeChildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<QrcodeCubit, QrcodeState>(
      listener: (context, state) {
        if (state is QrCodeSuccessStates) {
          Get.offAll(() => ChildhomeScreen());
        }
      },
      child: Scaffold(
        backgroundColor: ColorsManager.neutral50, // App light background
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'QR Code Child',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: ColorsManager.baseBlack,
              fontFamily: 'Poppins',
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.all(8.w),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.arrow_back,
                  color: ColorsManager.baseBlack,
                  size: 24.sp,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Scan this QR Code',
                style: TextStyle(
                  color: ColorsManager.primary,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600, // Semi-bold for emphasis
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 30.h),
              BlocBuilder<QrcodeCubit, QrcodeState>(
                buildWhen: (previous, current) =>
                    current is GenerateQrCodeSuccessStates,
                builder: (context, state) {
                  if (state is GenerateQrCodeLoadingStates) {
                    return Skeletonizer(
                      child: QrImageView(
                        data: "",
                        version: QrVersions.auto,
                        size: 280.w,
                        foregroundColor: ColorsManager.primary,
                        // Make it rounded/dotted if possible.
                        // dataModuleStyle controls the shape of the dots.
                        dataModuleStyle: const QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.circle,
                          color: ColorsManager.primary,
                        ),
                        eyeStyle: const QrEyeStyle(
                          eyeShape: QrEyeShape.circle,
                          color: ColorsManager.primary,
                        ),
                      ),
                    );
                  } else if (state is GenerateQrCodeErrorStates) {
                    return Skeletonizer(
                      child: QrImageView(
                        data: "",
                        version: QrVersions.auto,
                        size: 280.w,
                        foregroundColor: ColorsManager.primary,
                        // Make it rounded/dotted if possible.
                        // dataModuleStyle controls the shape of the dots.
                        dataModuleStyle: const QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.circle,
                          color: ColorsManager.primary,
                        ),
                        eyeStyle: const QrEyeStyle(
                          eyeShape: QrEyeShape.circle,
                          color: ColorsManager.primary,
                        ),
                      ),
                    );
                  }
                  if (state is GenerateQrCodeSuccessStates) {
                    return Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: ColorsManager.borderColor,
                          width: 1.w,
                        ),
                      ),
                      child: QrImageView(
                        data: QrcodeCubit.get(
                          context,
                        ).generatecodeModel!.data!.qrCodeData!,
                        version: QrVersions.auto,
                        size: 280.w,
                        foregroundColor: ColorsManager.primary,
                        // Make it rounded/dotted if possible.
                        // dataModuleStyle controls the shape of the dots.
                        dataModuleStyle: const QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.circle,
                          color: ColorsManager.primary,
                        ),
                        eyeStyle: const QrEyeStyle(
                          eyeShape: QrEyeShape.circle,
                          color: ColorsManager.primary,
                        ),
                      ),
                    );
                  }
                  return Skeletonizer(
                    child: QrImageView(
                      data: "",
                      version: QrVersions.auto,
                      size: 280.w,
                      foregroundColor: ColorsManager.primary,
                      // Make it rounded/dotted if possible.
                      // dataModuleStyle controls the shape of the dots.
                      dataModuleStyle: const QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.circle,
                        color: ColorsManager.primary,
                      ),
                      eyeStyle: const QrEyeStyle(
                        eyeShape: QrEyeShape.circle,
                        color: ColorsManager.primary,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
