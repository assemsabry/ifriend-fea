import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/routing/sizing.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/app_image.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/core/widgets/def_appbar.dart';
import 'package:ifriend_app/core/widgets/def_button.dart';
import 'package:ifriend_app/core/widgets/def_form_field.dart';

class AiassistScreen extends StatelessWidget {
  const AiassistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefAppbar(title: "Ai Assistant", backIcon: true),
      body: Container(
        padding: AppSizing.customPadding(),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 20.h),
            CustomText(
              title:
                  "Set a timer for the smart assistant to\n talk to your child.",
              color: ColorsManager.neutral500,
              textAlign: TextAlign.center,
            ),

            AppImage(path: "assets/images/ai.png", height: 250.h),
            SizedBox(height: 20.h),

            Row(
              spacing: 8.w,
              children: [
                Expanded(
                  child: DefFormField(
                    fillColor: Colors.white,
                    filled: true,
                    label: "Start",
                    titleOnTop: true,
                    richTextColor: ColorsManager.neutral500,
                    suffixIcon: AppImage(path: "assets/svg/aiicon.svg"),
                  ),
                ),
                Expanded(
                  child: DefFormField(
                    fillColor: Colors.white,
                    filled: true,
                    label: "End",
                    titleOnTop: true,
                    richTextColor: ColorsManager.neutral500,
                    suffixIcon: AppImage(path: "assets/svg/aiicon.svg"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorsManager.baseWhite,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  CustomText(
                    title: "Apply every day",
                    color: ColorsManager.baseBlack,
                    textAlign: TextAlign.center,
                  ),
                  Switch(
                    value: false, // الحالة الحالية
                    onChanged: (bool newValue) {},
                    activeThumbColor: ColorsManager.baseWhite,

                    inactiveTrackColor: ColorsManager.neutral100,
                    activeTrackColor: ColorsManager.primary,
                    inactiveThumbColor: Colors.white,
                    thumbIcon: WidgetStateProperty.all(
                      Icon(Icons.check, color: ColorsManager.baseWhite),
                    ),
                    trackOutlineColor: WidgetStateProperty.all(
                      Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100.h,
        padding: AppSizing.customPadding(),
        child: Column(
          children: [DefButton(title: "Next", onPressed: () {})],
        ),
      ),
    );
  }
}
