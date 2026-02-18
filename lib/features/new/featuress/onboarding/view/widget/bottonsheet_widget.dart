import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/constants/imges.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/theme/styles_manager.dart';
import 'package:ifriend_app/core/widgets/custom_asset_image_widget.dart';
import 'package:ifriend_app/features/new/config/themes/app_colors.dart';

class BottonsheetWidget extends StatelessWidget {
  final String title;
  final String description;
  final int currentIndex;
  final int length;
  final VoidCallback onNext;

  const BottonsheetWidget({
    super.key,
    required this.title,
    required this.description,
    required this.currentIndex,
    required this.length,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.baseWhite,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeInLeft(
            duration: const Duration(milliseconds: 1300),
            child: Text(
              title,
              style: TextStyles.font26Black600Weight,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 12.h),
          FadeInLeft(
            duration: const Duration(milliseconds: 1400),
            child: Text(
              description,
              style: TextStyles.font16Grey500Weight,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              length,
              (i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: i == currentIndex ? 20 : 10,
                height: 10,
                decoration: BoxDecoration(
                  color: i == currentIndex
                      ? AppColors.primary
                      : AppColors.neutral200,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (currentIndex == length - 1) {
                  onNext(); // Finish onboarding
                } else {
                  onNext();
                }
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(double.infinity, 65.h),
                backgroundColor: ColorsManager.primary,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: currentIndex == length - 1
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(
                            "GET STARTED",
                            style: TextStyles.font16White400Weight.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: ColorsManager.primary400,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomAssetImageWidget(
                                Images.arrowGoIcon,
                                height: 20,
                                width: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Text(
                      "CONTINUE",
                      style: TextStyles.font16White400Weight.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
