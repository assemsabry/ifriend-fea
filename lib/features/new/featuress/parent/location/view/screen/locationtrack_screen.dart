import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ifriend_app/core/routing/sizing.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/core/widgets/def_appbar.dart';
import 'package:ifriend_app/core/widgets/def_button.dart';
import 'package:ifriend_app/features/new/featuress/parent/location/view/screen/addlocation_screen.dart';
import 'package:ifriend_app/features/new/featuress/parent/location/view/screen/editlocation_screen.dart';

class LocationtrackScreen extends StatelessWidget {
  const LocationtrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefAppbar(title: "Location Tracking", backIcon: true),
      body: Container(
        alignment: Alignment.center,
        padding: AppSizing.customPadding(),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 10.h),

            CustomText(
              title:
                  " Add places like Home, School, or Club\n to track your child safely.",
              textAlign: TextAlign.center,
              color: ColorsManager.neutral500,
            ),
            SizedBox(height: 20.h),
            Container(
              alignment: Alignment.center,
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorsManager.baseWhite,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ListTile(
                title: CustomText(
                  title: "Home",
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: CustomText(
                  title: "Apartment 4B, Building 12",
                  color: ColorsManager.neutral300,
                ),
                leading: Icon(
                  Iconsax.location,
                  size: 35.sp,
                  color: ColorsManager.primary,
                ),
                trailing: InkWell(
                  onTap: () {
                    Get.to(() => EditlocationScreen());
                  },
                  child: Icon(
                    Iconsax.edit,
                    size: 25.sp,
                    color: ColorsManager.neutral400,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),
            Container(
              alignment: Alignment.center,
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorsManager.baseWhite,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ListTile(
                title: CustomText(
                  title: "School",
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: CustomText(
                  title: "Apartment 4B, Building 12",
                  color: ColorsManager.neutral300,
                ),
                leading: Icon(
                  Iconsax.location,
                  size: 35.sp,
                  color: ColorsManager.primary,
                ),
                trailing: InkWell(
                  onTap: () {
                    Get.to(() => EditlocationScreen());
                  },
                  child: Icon(
                    Iconsax.edit,
                    size: 25.sp,
                    color: ColorsManager.neutral400,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            InkWell(
              onTap: () {
                Get.to(() => AddlocationScreen());
              },
              child: Container(
                height: 100.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorsManager.baseWhite,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  spacing: 8.w,
                  mainAxisAlignment: .center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ColorsManager.neutral500,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Icon(Iconsax.add, color: Colors.white),
                    ),
                    CustomText(
                      title: "Add Location",
                      color: ColorsManager.neutral500,
                    ),
                  ],
                ),
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
