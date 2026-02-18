import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/features/new/config/themes/app_colors.dart';

ThemeData appTheme() {
  return ThemeData(
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
    scaffoldBackgroundColor: ColorsManager.neutral50,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.primary,
    ),
    checkboxTheme: CheckboxThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      side: const BorderSide(width: 2), // سماكة الحدود
      splashRadius: 30, // حجم تأثير اللمس
    ),
    primaryColor: AppColors.primary,
    useMaterial3: true,
    // fontFamily:
    //     // HiveHelper.getData("role")==""?
    //     FontConstants.fontFamily,
    iconTheme: IconThemeData(color: AppColors.primary, size: 18.sp),
  );
}
