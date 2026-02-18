import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/app_image.dart';
import 'package:ifriend_app/core/widgets/custom_bottonshet.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/model/parenthome_model.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/view/widget/childsheet_widget.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({
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
    required this.imageUrl,
    this.children,
  });

  final String title;
  final String imageUrl;
  final bool? size;
  final bool? backIcon;
  final Widget? widget;
  final bool? isBackShow;
  final Color? color;
  final Color? textColor;
  final List<AllChildren>? children;

  final bool? centerTitle;
  final double? fontSize;
  final void Function()? onPressed;
  final FontWeight? fontWeight;
  final Widget? titleWidget;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorsManager.neutral50,

      backgroundColor: color ?? ColorsManager.neutral50,
      centerTitle: centerTitle ?? false,
      foregroundColor: ColorsManager.primary,
      titleSpacing: 10.w,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: ColorsManager.baseWhite,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22.r,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: AppImage(path: imageUrl),
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      title: title,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    Row(
                      children: [
                        Icon(
                          Iconsax.battery_full,
                          size: 20.sp,
                          color: ColorsManager.primary,
                        ),
                        SizedBox(width: 4.w),
                        CustomText(
                          title: "55%",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorsManager.primary,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 10.w),
                InkWell(
                  onTap: () {
                    CustomBottomSheet.show(
                      context: context,
                      height: Get.height * 0.5,
                      child: SwitchDeviceWidget(children: children!),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Icon(
                      Iconsax.add,
                      size: 30.sp,
                      color: ColorsManager.baseBlack,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: ColorsManager.baseWhite,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Iconsax.notification, size: 25.sp, color: Colors.black),
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 10.w,
                      minHeight: 10.h,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
