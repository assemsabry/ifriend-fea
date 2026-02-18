import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';

class AvatarSelector extends StatelessWidget {
  final List<String> avatarPaths;
  final String? selectedAvatarPath;
  final ValueChanged<String> onAvatarSelected;

  const AvatarSelector({
    super.key,
    required this.avatarPaths,
    this.selectedAvatarPath,
    required this.onAvatarSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        itemCount: avatarPaths.length,
        itemBuilder: (context, index) {
          final avatarPath = avatarPaths[index];
          final isSelected = selectedAvatarPath == avatarPath;

          return GestureDetector(
            onTap: () => onAvatarSelected(avatarPath),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: EdgeInsets.only(
                right: index < avatarPaths.length - 1 ? 12.w : 0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Avatar container with border
                      Container(
                        width: isSelected ? 120.w : 80.w,
                        height: isSelected ? 120.w : 80.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? ColorsManager.primary
                                : Colors.transparent,
                            width: isSelected ? 4.w : 0,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: ColorsManager.primary.withOpacity(
                                      0.3,
                                    ),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : [],
                        ),
                        child: ClipOval(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Avatar image
                              Image.asset(
                                avatarPath,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: const Color(0xFF87CEEB),
                                    child: Icon(
                                      Icons.person,
                                      size: isSelected ? 60.sp : 40.sp,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                              // Blur overlay for non-selected avatars
                              if (!isSelected)
                                BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 2.5,
                                    sigmaY: 2.5,
                                  ),
                                  child: Container(
                                    color: Colors.white.withOpacity(0.2),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Selection indicator (optional dot below selected avatar)
                  if (isSelected) ...[
                    SizedBox(height: 6.h),
                    Container(
                      width: 6.w,
                      height: 6.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorsManager.primary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
