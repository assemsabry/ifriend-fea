import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/features/new/featuress/child/auth/comleteprofile/controller/childcompleteprofile_cubit.dart';

class GenderCard extends StatelessWidget {
  final Gender gender;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderCard({
    super.key,
    required this.gender,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorsManager.primary.withOpacity(0.1)
              : ColorsManager.neutral50,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? ColorsManager.primary
                : ColorsManager.neutral200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gender Icon with image asset
            SizedBox(
              width: 28.w,
              height: 28.w,
              child: Image.asset(
                gender == Gender.boy
                    ? 'assets/images/boy.png'
                    : 'assets/images/girl.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to Material icons if images not found
                  return Icon(
                    gender == Gender.boy ? Icons.boy : Icons.girl,
                    color: isSelected
                        ? ColorsManager.primary
                        : ColorsManager.neutral500,
                    size: 28.sp,
                  );
                },
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              gender == Gender.boy ? 'Boy' : 'Girl',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? ColorsManager.primary
                    : ColorsManager.baseBlack,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
