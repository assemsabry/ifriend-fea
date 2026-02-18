import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';

class DefrichText extends StatelessWidget {
  final String title;
  final bool? optional;
  final Color? textColor;
  const DefrichText({
    super.key,
    required this.title,
    this.optional,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: textColor ?? ColorsManager.baseBlack,
        ),
        children: [
          // if (requiredStyle)
          TextSpan(
            text: optional == true ? " (اختياري)" : "",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: ColorsManager.primary,
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}
