import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/app_image.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';

class DefconWidget extends StatelessWidget {
  final String title, imagePath;
  final Color color;
  final Color? textColor;
  final VoidCallback? onTap;

  const DefconWidget({
    super.key,
    required this.title,
    required this.imagePath,
    required this.color,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(5, 5),
            ),
          ],
        ),
        child: Row(
          spacing: 15.w,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: AppImage(
                path: "assets/images/$imagePath",
                fit: BoxFit.fill,
                height: 40.h,
              ),
            ),
            CustomText(
              title: title,
              color: textColor ?? ColorsManager.baseWhite,
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
            ),
          ],
        ),
      ),
    );
  }
}
