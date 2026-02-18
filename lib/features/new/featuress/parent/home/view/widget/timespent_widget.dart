import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/app_image.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/core/widgets/def_button.dart';
import 'package:ifriend_app/features/new/featuress/parent/apps/view/screen/apps_screen.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/controller/parenthome_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/view/widget/overimages_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TimespentWidget extends StatelessWidget {
  const TimespentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentHomeCubit, ParentHomeState>(
      buildWhen: (previous, current) => current is ParentHomeSuccessState,
      builder: (context, state) {
        if (state is ParentHomeLoadingState) {
          return Skeletonizer(
            child: Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorsManager.baseWhite,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          CustomText(
                            title: "Time spent today",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorsManager.neutral500,
                          ),
                          CustomText(
                            title: "1h 30min",
                            fontSize: 42.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorsManager.baseBlack,
                          ),
                        ],
                      ),
                      OverimagesWidget(),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    spacing: 10.w,
                    children: [
                      Expanded(
                        child: DefButton(
                          title: "dfdf",
                          height: 60.h,
                          buttoncolor: ColorsManager.primary50,
                          widget: Row(
                            spacing: 5.w,
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              AppImage(path: "assets/svg/playstore.svg"),
                              CustomText(
                                title: "Apps",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          onPressed: () {
                            Get.to(() => AppsScreen());
                          },
                        ),
                      ),
                      Expanded(
                        child: DefButton(
                          title: "dfdf",
                          height: 60.h,
                          buttoncolor: ColorsManager.primary50,
                          widget: Row(
                            spacing: 5.w,

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppImage(path: "assets/svg/chirticon.svg"),
                              CustomText(
                                title: "Ai Reports",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (state is ParentHomeErrorState) {
          return Skeletonizer(
            child: Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorsManager.baseWhite,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          CustomText(
                            title: "Time spent today",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorsManager.neutral500,
                          ),
                          CustomText(
                            title: "1h 30min",
                            fontSize: 42.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorsManager.baseBlack,
                          ),
                        ],
                      ),
                      OverimagesWidget(),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    spacing: 10.w,
                    children: [
                      Expanded(
                        child: DefButton(
                          title: "dfdf",
                          height: 60.h,
                          buttoncolor: ColorsManager.primary50,
                          widget: Row(
                            spacing: 5.w,
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              AppImage(path: "assets/svg/playstore.svg"),
                              CustomText(
                                title: "Apps",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          onPressed: () {
                            Get.to(() => AppsScreen());
                          },
                        ),
                      ),
                      Expanded(
                        child: DefButton(
                          title: "dfdf",
                          height: 60.h,
                          buttoncolor: ColorsManager.primary50,
                          widget: Row(
                            spacing: 5.w,

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppImage(path: "assets/svg/chirticon.svg"),
                              CustomText(
                                title: "Ai Reports",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        if (state is ParentHomeSuccessState) {
          if (state.model.data == null) {
            return Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorsManager.baseWhite,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          CustomText(
                            title: "Time spent today",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorsManager.neutral500,
                          ),
                          CustomText(
                            title: "1h 30min",
                            fontSize: 42.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorsManager.baseBlack,
                          ),
                        ],
                      ),
                      OverimagesWidget(),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    spacing: 10.w,
                    children: [
                      Expanded(
                        child: DefButton(
                          title: "dfdf",
                          height: 60.h,
                          buttoncolor: ColorsManager.primary50,
                          widget: Row(
                            spacing: 5.w,
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              AppImage(path: "assets/svg/playstore.svg"),
                              CustomText(
                                title: "Apps",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          onPressed: () {
                            Get.to(() => AppsScreen());
                          },
                        ),
                      ),
                      Expanded(
                        child: DefButton(
                          title: "dfdf",
                          height: 60.h,
                          buttoncolor: ColorsManager.primary50,
                          widget: Row(
                            spacing: 5.w,

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppImage(path: "assets/svg/chirticon.svg"),
                              CustomText(
                                title: "Ai Reports",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          return Container(
            padding: EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorsManager.baseWhite,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        CustomText(
                          title: "Time spent today",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorsManager.neutral500,
                        ),
                        CustomText(
                          title: "1h 30min",
                          //state.model.data!.usage!.totalMinutes
                          // .toString(),
                          //"1h 30min",
                          fontSize: 42.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorsManager.baseBlack,
                        ),
                      ],
                    ),
                    OverimagesWidget(),
                  ],
                ),
                SizedBox(height: 30.h),
                Row(
                  spacing: 10.w,
                  children: [
                    Expanded(
                      child: DefButton(
                        title: "dfdf",
                        height: 60.h,
                        buttoncolor: ColorsManager.primary50,
                        widget: Row(
                          spacing: 5.w,
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            AppImage(path: "assets/svg/playstore.svg"),
                            CustomText(
                              title: "Apps",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        onPressed: () {
                          Get.to(() => AppsScreen());
                        },
                      ),
                    ),
                    Expanded(
                      child: DefButton(
                        title: "dfdf",
                        height: 60.h,
                        buttoncolor: ColorsManager.primary50,
                        widget: Row(
                          spacing: 5.w,

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppImage(path: "assets/svg/chirticon.svg"),
                            CustomText(
                              title: "Ai Reports",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return Container(
          padding: EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorsManager.baseWhite,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      CustomText(
                        title: "Time spent today",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.neutral500,
                      ),
                      CustomText(
                        title: "1h 30min",
                        fontSize: 42.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorsManager.baseBlack,
                      ),
                    ],
                  ),
                  OverimagesWidget(),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                spacing: 10.w,
                children: [
                  Expanded(
                    child: DefButton(
                      title: "dfdf",
                      height: 60.h,
                      buttoncolor: ColorsManager.primary50,
                      widget: Row(
                        spacing: 5.w,
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          AppImage(path: "assets/svg/playstore.svg"),
                          CustomText(
                            title: "Apps",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      onPressed: () {
                        Get.to(() => AppsScreen());
                      },
                    ),
                  ),
                  Expanded(
                    child: DefButton(
                      title: "dfdf",
                      height: 60.h,
                      buttoncolor: ColorsManager.primary50,
                      widget: Row(
                        spacing: 5.w,

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppImage(path: "assets/svg/chirticon.svg"),
                          CustomText(
                            title: "Ai Reports",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
