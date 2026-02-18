import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/features/new/config/themes/app_colors.dart';

class CustomTextBotton extends StatelessWidget {
  final String title;
  final Color? color;
  final FontWeight? fontWeight;
  final MainAxisAlignment mainAxisAlignment;
  final TextDecoration? decoration;
  final void Function()? onPressed;
  final double? fontSize;
  const CustomTextBotton({
    super.key,
    required this.title,
    this.color,
    this.onPressed,
    required this.mainAxisAlignment,
    this.fontWeight,
    this.decoration,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        TextButton(
          onPressed: onPressed,
          child: CustomText(
            title: title,
            fontSize: fontSize ?? 16.sp,
            color: color ?? AppColors.primary,
            fontWeight: fontWeight ?? FontWeight.w500,
            decoration: decoration,
          ),
        ),
      ],
    );
  }
}
