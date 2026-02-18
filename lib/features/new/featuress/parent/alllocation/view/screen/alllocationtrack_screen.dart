import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ifriend_app/core/routing/sizing.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/app_image.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/core/widgets/def_appbar.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/controller/alllocation_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/view/widget/location_card.dart';
import 'package:ifriend_app/features/new/featuress/parent/location/view/screen/addlocation_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllLocationtrackScreen extends StatelessWidget {
  const AllLocationtrackScreen({super.key});

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
            CustomText(
              title: "Select Child on Change location",
              textAlign: TextAlign.center,
              color: ColorsManager.neutral800,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 10.h),

            BlocBuilder<AllLocationCubit, AllLocationState>(
              buildWhen: (previous, current) =>
                  current is AllMyChildSuccessStates,
              builder: (context, state) {
                if (state is AllMyChildLoadingStates) {
                  return SizedBox(
                    height: 80.h,

                    child: Skeletonizer(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        padding: EdgeInsets.symmetric(
                          horizontal: Get.width / 5,
                        ),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(5.w),
                            child: Container(
                              alignment: .center,
                              width: 60.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorsManager.primary,
                              ),
                              child: ClipOval(
                                child: AppImage(
                                  path: "assets/images/avatar1.png",
                                  height: 55.h,
                                  width: 55.w,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else if (state is AllLocationErrorStates) {
                  return SizedBox(
                    height: 80.h,

                    child: Skeletonizer(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        padding: EdgeInsets.symmetric(
                          horizontal: Get.width / 5,
                        ),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(5.w),
                            child: Container(
                              alignment: .center,
                              width: 60.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorsManager.primary,
                              ),
                              child: ClipOval(
                                child: AppImage(
                                  path: "assets/images/avatar1.png",
                                  height: 55.h,
                                  width: 55.w,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                if (state is AllMyChildSuccessStates) {
                  return SizedBox(
                    height: 80.h,

                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.allMyChildModel.data!.children!.length,
                      padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(5.w),
                          child: Container(
                            alignment: .center,
                            width: 60.w,
                            height: 60.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorsManager.primary,
                            ),
                            child: ClipOval(
                              child: AppImage(
                                path:
                                    state
                                        .allMyChildModel
                                        .data!
                                        .children![index]
                                        .avatar ??
                                    "assets/images/avatar1.png",
                                height: 55.h,
                                width: 55.w,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
            SizedBox(height: 20.h),

            BlocBuilder<AllLocationCubit, AllLocationState>(
              buildWhen: (previous, current) =>
                  current is AllLocationSuccessStates,
              builder: (context, state) {
                if (state is AllLocationLoadingStates) {
                  return Skeletonizer(
                    child: ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LocationCard(),
                      ),
                    ),
                  );
                } else if (state is AllLocationErrorStates) {
                  return Skeletonizer(
                    child: ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LocationCard(),
                      ),
                    ),
                  );
                }
                if (state is AllLocationSuccessStates) {
                  if (state.allsavezoneModel.data!.safeZones!.isEmpty) {
                    // return NohistoryWidget(
                    //   title: "لايوجد سجلات مدفوعات لديك",
                    //   svg: "credit.svg",
                    // );
                  }
                  return ListView.builder(
                    itemCount: state.allsavezoneModel.data!.safeZones!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LocationCard(
                        safeZones:
                            state.allsavezoneModel.data!.safeZones![index],
                      ),
                    ),
                  );
                }
                return Skeletonizer(
                  child: ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LocationCard(),
                    ),
                  ),
                );
              },
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
      // bottomNavigationBar: Container(
      //   height: 100.h,
      //   padding: AppSizing.customPadding(),
      //   child: Column(
      //     children: [DefButton(title: "Next", onPressed: () {})],
      //   ),
      // ),
    );
  }
}
