import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';

class MarkAsDoneButton extends StatelessWidget {
  const MarkAsDoneButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 50.h,
        width: 150.w,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 45.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF5F63D6), // لون أغمق
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            Container(
              height: 45.h,
              decoration: BoxDecoration(
                color: const Color(0xFF7B7CF2), // اللون الأساسي
                borderRadius: BorderRadius.circular(30),
              ),
              alignment: Alignment.center,
              child: CustomText(
                title: "Mark as Done",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
