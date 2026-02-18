import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/features/new/featuress/parent/apps/controller/apps_cubit.dart';

class AppsAppbar extends StatelessWidget implements PreferredSizeWidget {
  const AppsAppbar({
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
    return BlocBuilder<AppsCubit, AppsState>(
      builder: (context, state) {
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: Container(
              height: 66.h,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  _buildCategoryChip(
                    "All",
                    AppsCubit.get(context).allCount.toString(),
                    true,
                  ),
                  SizedBox(width: 10.w),
                  _buildCategoryChip(
                    "Allow",
                    AppsCubit.get(context).allowCount.toString(),
                    false,
                  ),
                  SizedBox(width: 10.w),
                  _buildCategoryChip(
                    "Blocked",
                    AppsCubit.get(context).blockCount.toString(),
                    false,
                  ),
                ],
              ),
            ),
          ),

          actions: [widget ?? const Text("")],

          //     leadingWidth: 100.w,
        );
      },
    );
  }

  Widget _buildCategoryChip(String label, String count, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: isSelected
            ? ColorsManager.primary
            : ColorsManager.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: ColorsManager.primary100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : ColorsManager.primary,
              shape: BoxShape.circle,
            ),
            child: Text(
              count,
              style: TextStyle(
                fontSize: 12.sp,
                color: isSelected ? ColorsManager.primary : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : ColorsManager.primary,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 66.h);
}
