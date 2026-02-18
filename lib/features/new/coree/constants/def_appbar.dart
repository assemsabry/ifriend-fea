import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';

class DefAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DefAppbar({
    super.key,
    required this.title,
    this.size = false,
    this.onPressed,
    this.backIcon,
    this.widget,
    this.isBackShow,
    this.color,
    this.centerTitle,
    this.fontSize,
    this.fontWeight,
    this.textColor,

    this.titleWidget,
  });

  final String title;
  final bool? size;
  final bool? backIcon;
  final Widget? widget;
  final bool? isBackShow;
  final Color? color;
  final Color? textColor;

  final bool? centerTitle;
  final double? fontSize;
  final void Function()? onPressed;
  final FontWeight? fontWeight;
  final Widget? titleWidget;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorsManager.neutral50,
      automaticallyImplyLeading: false,

      backgroundColor: color ?? ColorsManager.neutral50,
      centerTitle: centerTitle ?? false,
      foregroundColor: ColorsManager.primary,
      titleSpacing: 10.w,
      title: backIcon == true
          ? Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: ColorsManager.borderColor),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Iconsax.arrow_left,
                        color:
                            // (color != null)
                            //     ? Colors.white
                            //     :
                            ColorsManager.baseBlack,
                      ),
                      onPressed: onPressed ?? () => Navigator.pop(context),
                    ),
                  ),
                ),
                Center(
                  child:
                      titleWidget ??
                      CustomText(
                        title: title,
                        color: textColor ?? ColorsManager.baseBlack,
                        fontSize: fontSize ?? 20.sp,
                        fontWeight: fontWeight ?? FontWeight.w500,
                      ),
                ),
              ],
            )
          : CustomText(
              title: title,
              color: textColor ?? ColorsManager.baseBlack,

              fontSize: fontSize ?? 16.sp,
              fontWeight: fontWeight ?? FontWeight.w500,
            ),

      actions: [widget ?? const Text("")],

      //     leadingWidth: 100.w,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
