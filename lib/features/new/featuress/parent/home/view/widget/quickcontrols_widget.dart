import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';

class QuickcontrolsWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  const QuickcontrolsWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5.h,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),

            decoration: BoxDecoration(
              color: ColorsManager.primary50,
              borderRadius: BorderRadius.circular(99.r),
            ),
            child: Icon(icon, color: ColorsManager.primary),
          ),
        ),

        CustomText(
          title: title,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: ColorsManager.neutral700,
        ),
      ],
    );
  }
}
