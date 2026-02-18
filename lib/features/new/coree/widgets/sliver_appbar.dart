
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/theme/styles_manager.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/features/new/coree/widgets/def_search_field.dart';

SliverAppBar advancedDoctorAppBar({
  required BuildContext context,
  required String title,
}) {
  return SliverAppBar(
    pinned: true,
    elevation: 0,
    automaticallyImplyLeading: false,

    expandedHeight: 220.h,
    collapsedHeight: 140.h,
    backgroundColor: ColorsManager.neutral50,

    leadingWidth: Get.width,
    title: Text("App Management", style: TextStyles.font20Black500Weight),

    flexibleSpace: LayoutBuilder(
      builder: (context, constraints) {
        final isCompact =
            constraints.maxHeight <= 140.h + MediaQuery.of(context).padding.top;
        // log('isCompact: $isCompact');
        return Container(
          color: ColorsManager.neutral50,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Stack(
            clipBehavior: Clip.none,

            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!isCompact)
                    CustomText(
                      title: "Choose which apps you want to\n allow or block.",
                      color: ColorsManager.neutral600,
                      textAlign: TextAlign.center,
                    ),
                  SizedBox(height: 30.h),

                  DefSearchField(label: "Search for apps"),

                  SizedBox(height: 16.h),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );
}
