import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';

class PermissionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isGranted;
  final VoidCallback onTap;

  const PermissionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.isGranted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isGranted ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorsManager.baseWhite,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isGranted ? ColorsManager.primary : ColorsManager.neutral200,
            width: isGranted ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: isGranted
                    ? ColorsManager.primary.withOpacity(0.1)
                    : ColorsManager.neutral50,
                borderRadius: BorderRadius.circular(99.r),
              ),
              child: Icon(
                icon,
                color: isGranted
                    ? ColorsManager.primary
                    : ColorsManager.neutral500,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isGranted
                          ? ColorsManager.baseBlack
                          : ColorsManager.neutral600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.neutral500,
                      fontFamily: 'Poppins',
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            // Status indicator
            if (isGranted)
              Icon(
                Icons.check_circle,
                color: ColorsManager.primary,
                size: 24.sp,
              )
            else
              Icon(
                Icons.arrow_forward_ios,
                color: ColorsManager.neutral500,
                size: 16.sp,
              ),
          ],
        ),
      ),
    );
  }
}
