import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/theme/font_manager.dart';

class CustomText extends StatelessWidget {
  final TextAlign? textAlign;
  final String title;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final int? maxLines;
  final bool? softWrap;
  final TextOverflow? overflow;
  final String? fontFamily;
  final double? letterSpacing;
  const CustomText({
    super.key,
    required this.title,
    this.fontSize,
    this.textAlign,
    this.color,
    this.fontWeight,
    this.decoration,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.letterSpacing,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      maxLines: maxLines ?? 2,
      title,
      overflow: overflow,
      softWrap: softWrap,
      style: TextStyle(
        decoration: decoration,
        fontFamily: fontFamily ?? FontConstants.fontFamily,
        letterSpacing: letterSpacing,
        fontSize: fontSize ?? 14.sp,
        overflow: TextOverflow.ellipsis,
        color: color ?? Colors.black,
        decorationColor: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    );
  }
}
