import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ifriend_app/core/routing/sizing.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/app_image.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/features/new/featuress/parent/ai/view/screen/aiassist_screen.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/view/screen/modes_screen.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/controller/parenthome_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/view/widget/home_appbar.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/view/widget/quickcontrols_widget.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/view/widget/timespent_widget.dart';
import 'package:ifriend_app/features/new/featuress/parent/location/view/widget/currentlocation_widget.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/controller/modes_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/view/widget/currentmodes_widget.dart';
import 'package:ifriend_app/features/new/featuress/parent/task/view/screen/tasks_screen.dart';

class ParenthomeScreen extends StatelessWidget {
  const ParenthomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentHomeCubit, ParentHomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: HomeAppbar(
            title:
                ParentHomeCubit.get(
                  context,
                ).homeParentModel?.data?.child?.firstName ??
                "userName",

            imageUrl:
                ParentHomeCubit.get(
                  context,
                ).homeParentModel?.data?.child?.avatarUrl ??
                "assets/images/avatar1.png",
            children: ParentHomeCubit.get(context).homeParentModel?.allChildren,
          ),
          body: Container(
            padding: AppSizing.customPadding(),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                // CustomButton(
                //   label: "fdd",
                //   onPressed: () {
                //     print(HiveHelper.getData("token"));
                //   },
                // ),
                SizedBox(height: 20.h),
                CurrentmodesWidget(),
                SizedBox(height: 20.h),
                TimespentWidget(),
                SizedBox(height: 20.h),

                CustomText(
                  title: "Quick controls",
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorsManager.neutral700,
                ),
                SizedBox(height: 10.h),
                Container(
                  padding: EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorsManager.baseWhite,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      QuickcontrolsWidget(
                        title: "Tasks",
                        icon: Iconsax.task_square,
                        onTap: () {
                          Get.to(() => TasksScreen());
                        },
                      ),
                      QuickcontrolsWidget(
                        title: "Call",
                        icon: Iconsax.call_calling,
                      ),
                      QuickcontrolsWidget(
                        title: "Modes",
                        icon: Iconsax.toggle_off_circle,
                        onTap: () {
                          ModesCubit.get(context).getAllModes();
                          Get.to(() => ModesScreen());
                        },
                      ),
                      QuickcontrolsWidget(
                        title: "Ai Assistant",
                        icon: Iconsax.toggle_off_circle,
                        onTap: () {
                          Get.to(() => AiassistScreen());
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                CustomText(
                  title: "Location",
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorsManager.neutral700,
                ),
                SizedBox(height: 10.h),
                CurrentlocationWidget(),
                SizedBox(height: 10.h),

                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    CustomText(
                      title: "Online activity",
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorsManager.neutral700,
                    ),
                    InkWell(
                      onTap: () {},
                      child: CustomText(
                        title: "See more",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorsManager.baseWhite,
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textColor: Color(0xFFFCFCFC),

                    title: CustomText(
                      title: "Youtube kids",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.neutral800,
                    ),
                    leading: AppImage(
                      path: "assets/images/facebook.png",
                      width: 40.w,
                      height: 40.h,
                    ),
                    trailing: CustomText(
                      title: "25 min",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.neutral500,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
