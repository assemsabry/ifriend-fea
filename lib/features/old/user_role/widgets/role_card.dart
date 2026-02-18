import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/theme/styles_manager.dart';

class RoleCard extends StatelessWidget {
  final bool selected;
  final String title;
  final String description;
  final String imagePath;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.selected,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: selected
                ? const LinearGradient(
                    colors: [Color(0xff0066FF), Color(0xff003D99)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : null,
            color: selected ? null : ColorsManager.baseWhite,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? Colors.transparent : ColorsManager.neutral200,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  selected ? Colors.white : Colors.transparent,
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  imagePath,
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: 12.h),

              Text(
                title,
                style: selected
                    ? TextStyles.font16White400Weight.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                      )
                    : TextStyles.font26Black600Weight.copyWith(fontSize: 18.sp),
              ),

              SizedBox(height: 8.h),

              Text(
                description,
                style: selected
                    ? TextStyles.font16White400Weight.copyWith(fontSize: 14.sp)
                    : TextStyles.font16Grey500Weight.copyWith(fontSize: 14.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
