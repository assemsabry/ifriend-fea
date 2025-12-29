import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';

class QrCodeChildScreen extends StatelessWidget {
  final String qrToken;

  const QrCodeChildScreen({super.key, required this.qrToken});

  @override
  Widget build(BuildContext context) {
    // QR data structure
    final Map<String, dynamic> qrData = {
      "type": "CHILD_DEVICE_LINK",
      "qrToken": qrToken,
    };
    final String qrDataString = jsonEncode(qrData);

    return Scaffold(
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
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                // No shadow explicitly asked, but often looks better. Sticking to simple as per design.
              ),
              child: QrImageView(
                data: qrDataString,
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
            ),
            // "Plenty of vertical spacing" - implied by Centered usage, but let's add some spacer if needed or just rely on Center.
          ],
        ),
      ),
    );
  }
}
