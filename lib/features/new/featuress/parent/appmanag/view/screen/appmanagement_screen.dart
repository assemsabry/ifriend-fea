import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/routing/sizing.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/app_image.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/core/widgets/def_button.dart';
import 'package:ifriend_app/features/new/coree/widgets/sliver_appbar.dart';

class AppmanagementScreen extends StatelessWidget {
  const AppmanagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.neutral50,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            advancedDoctorAppBar(context: context, title: "App Management"),
          ];
        },
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: List.generate(
            30,
            (index) => Padding(
              padding: EdgeInsets.only(
                left: 17.0.w,
                right: 17.0.w,
                top: 5.h,
                bottom: 5.w,
              ),
              child: ListTile(
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                tileColor: ColorsManager.baseWhite,
                title: CustomText(title: "Among Us"),
                subtitle: CustomText(
                  title: "Allow",
                  color: ColorsManager.primary,
                ),
                leading: AppImage(
                  path: "assets/images/games.png",
                  height: 40.h,
                  width: 40.w,
                ),
                trailing: Switch(
                  value: false, // الحالة الحالية
                  onChanged: (bool newValue) {},
                  activeThumbColor: ColorsManager.baseWhite,
                  thumbIcon: WidgetStateProperty.all(
                    Icon(Icons.check, color: ColorsManager.baseWhite),
                  ),

                  inactiveTrackColor: ColorsManager.neutral100,
                  activeTrackColor: ColorsManager.primary,
                  inactiveThumbColor: Colors.white,

                  trackOutlineColor: WidgetStateProperty.all(
                    Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
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
