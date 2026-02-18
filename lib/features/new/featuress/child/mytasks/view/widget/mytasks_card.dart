import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/app_image.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/features/new/featuress/child/mytasks/model/mytasks_model.dart';
import 'package:ifriend_app/features/new/featuress/child/mytasks/view/widget/asdone_botton.dart';

class MytasksCard extends StatelessWidget {
  final void Function()? onTap;
  final Tasks? task;
  const MytasksCard({super.key, this.onTap, this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Column(
        spacing: 7.h,
        crossAxisAlignment: .start,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              CustomText(
                title: task?.title ?? "Clean Your Room",
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
              Row(
                spacing: 4.w,
                children: [
                  AppImage(path: "assets/svg/Money-Coin.svg"),
                  CustomText(
                    title: "${task?.coins ?? 0} Coins",
                    fontSize: 15.sp,
                    color: ColorsManager.gold,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ],
          ),
          CustomText(
            title: task?.description ?? "Brush for 2 minutes before bedtime.",
            fontSize: 16.sp,
            color: ColorsManager.neutral600,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 10.h),
          MarkAsDoneButton(onTap: onTap),
        ],
      ),
    );
  }
}
