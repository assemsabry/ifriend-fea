import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';

class DefButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final Color? textcolor;
  final Color? buttoncolor;
  final double? minWidth;
  final double? height;
  final double? borderRadius;

  final Widget? widget;
  final bool? isLoading;
  final BorderSide? side;
  final Color? loadingColor;

  final void Function()? onLongPress;

  const DefButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.textcolor,
    this.buttoncolor,
    this.minWidth,
    this.height,
    this.widget,
    this.isLoading = false,
    this.side,
    this.onLongPress,
    this.loadingColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(
        side: side ?? const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
      ),
      clipBehavior: Clip.antiAlias,
      height: height ?? MediaQuery.of(context).size.height * 0.067,
      minWidth: minWidth ?? MediaQuery.of(context).size.width * 0.9,
      color: buttoncolor ?? ColorsManager.primary,
      onPressed: onPressed,
      onLongPress: onLongPress,
      child:
          widget ??
          CustomText(
            title: title,
            color: textcolor ?? ColorsManager.baseWhite,

            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
    );
  }
}
