import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/theme/font_manager.dart';

class TextStyles {
  static TextStyle get font16White400Weight => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightManager.regular,
        fontFamily: FontConstants.fontFamily,
        color: ColorsManager.neutral50,
      );
  static TextStyle get font32Black600Weight => TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeightManager.semiBold,
        fontFamily: FontConstants.fontFamily,
        color: ColorsManager.baseBlack,
      );
  static TextStyle get font26Black600Weight => TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeightManager.semiBold,
        fontFamily: FontConstants.fontFamily,
        color: ColorsManager.baseBlack,
      );
  static TextStyle get font20Black500Weight => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeightManager.medium,
        fontFamily: FontConstants.fontFamily,
        color: ColorsManager.baseBlack,
      );
  static TextStyle get font16Grey500Weight => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightManager.medium,
        fontFamily: FontConstants.fontFamily,
        color: ColorsManager.neutral600,
      );
  static TextStyle get font14Grey500Weight => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightManager.medium,
        fontFamily: FontConstants.fontFamily,
        color: ColorsManager.neutral600,
      );
  static TextStyle get font15Grey400Weight => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightManager.regular,
        fontFamily: FontConstants.fontFamily,
        color: ColorsManager.neutral600,
      );
  static TextStyle get font18White500Weight => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeightManager.medium,
        fontFamily: FontConstants.fontFamily,
        color: ColorsManager.baseWhite,
      );
}
