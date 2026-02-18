import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/app_image.dart';
import 'package:ifriend_app/core/widgets/custom_bottonshet.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/controller/modes_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/model/modes_model.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/view/screen/editmodes_screen.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/view/widget/dayswarb_widget.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/model/appmode_model.dart';

class DefmodesCard extends StatelessWidget {
  final Modes modes;
  final AppMode appMode;
  final Set<int>? selectedDays;
  final bool? isAllDays;
  const DefmodesCard({
    super.key,
    required this.modes,
    required this.appMode,
    this.selectedDays,
    this.isAllDays,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorsManager.baseWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        spacing: 5.h,
        crossAxisAlignment: .start,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              AppImage(path: appMode.imagePath, height: 55.h, width: 55.w),
              InkWell(
                onTap: () {
                  ModesCubit.get(context).initTimesFromBackend(modes);
                  CustomBottomSheet.show(
                    context: context,
                    height: Get.height * 0.7,

                    child: EditmodesScreen(modes: modes, appMode: appMode),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ColorsManager.neutral50,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    spacing: 5.w,
                    mainAxisSize: .min,
                    children: [
                      Icon(
                        Iconsax.edit,
                        size: 25.sp,
                        color: ColorsManager.neutral600,
                      ),
                      CustomText(
                        title: "Edit mode",
                        color: ColorsManager.neutral600,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          CustomText(
            title: appMode.title,
            color: ColorsManager.baseBlack,
            fontSize: 22.sp,
            fontWeight: FontWeight.w500,
          ),
          CustomText(
            title:
                "${modes.startTime.toString()} - ${modes.endTime.toString()}",
            color: ColorsManager.neutral500,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
          DayswarbWidget(selectedDays: selectedDays, isAllDays: isAllDays),
          // Container(
          //   padding: EdgeInsets.all(12),
          //   decoration: BoxDecoration(
          //     color: ColorsManager.primary.withOpacity(0.1),
          //     borderRadius: BorderRadius.circular(30.r),
          //   ),
          //   child: CustomText(
          //     title: "All day",
          //     color: ColorsManager.primary,
          //     fontSize: 12.sp,
          //     fontWeight: FontWeight.w400,
          //   ),
          // ),

          //DaysselectorWidget(),
        ],
      ),
    );
  }
}
