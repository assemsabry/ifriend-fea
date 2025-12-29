// dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/theme/styles_manager.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool outline;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double radius;
  final double height;
  final EdgeInsetsGeometry? padding;
  final Widget? leading;
  final TextStyle? textStyle;
  final bool enabled;

  const CustomButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.outline = false,
    this.backgroundColor,
    this.foregroundColor,
    this.radius = 16.0,
    this.height = 48.0,
    this.padding,
    this.leading,
    this.textStyle,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? ColorsManager.primary;
    final fg = foregroundColor ?? ColorsManager.baseWhite;
    final btnChild = isLoading
        ? SizedBox(
      width: 20.w,
      height: 20.w,
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(fg),
      ),
    )
        : Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leading != null) ...[
          leading!,
          SizedBox(width: 8.w),
        ],
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: textStyle ??
                TextStyles.font15Grey400Weight.copyWith(
                  color: outline ? (foregroundColor ?? bg) : fg,
                ),
          ),
        ),
      ],
    );

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius.r),
    );

    final ButtonStyle style = outline
        ? OutlinedButton.styleFrom(
      backgroundColor: Colors.transparent,
      side: BorderSide(color: backgroundColor ?? ColorsManager.primary),
      shape: shape,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      minimumSize: Size(double.infinity, height.h),
    ).copyWith(
      foregroundColor: MaterialStateProperty.all(foregroundColor ?? backgroundColor ?? ColorsManager.primary),
    )
        : ElevatedButton.styleFrom(
      backgroundColor: enabled ? bg : bg.withOpacity(0.5),
      foregroundColor: fg,
      shape: shape,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      minimumSize: Size(double.infinity, height.h),
    );

    final child = SizedBox(
      height: height.h,
      width: double.infinity,
      child: Center(child: btnChild),
    );

    return Padding(
      padding: EdgeInsets.zero,
      child: outline
          ? OutlinedButton(
        onPressed: (enabled && !isLoading) ? onPressed : null,
        style: style,
        child: child,
      )
          : ElevatedButton(
        onPressed: (enabled && !isLoading) ? onPressed : null,
        style: style,
        child: child,
      ),
    );
  }
}
