import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/features/new/coree/constants/app_image.dart';
import 'package:ifriend_app/features/new/coree/widgets/custom_button.dart';

class StatusBottomSheet extends StatelessWidget {
  final bool isSuccess;
  final String title, svgUrl;
  final String buttonText;
  final VoidCallback onPressed;

  const StatusBottomSheet({
    super.key,
    required this.isSuccess,
    required this.title,
    required this.svgUrl,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Material(
      color: Colors.transparent,
      child: Container(
        height: height * 0.45,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // لون الظل
              blurRadius: 10, // نعومة الظل
              spreadRadius: 2, // امتداد الظل
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppImage(path: svgUrl),

            CustomText(
              title: title,
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),

            // BUTTON
            CustomButton(title: title, onPressed: onPressed),
          ],
        ),
      ),
    );
  }
}
