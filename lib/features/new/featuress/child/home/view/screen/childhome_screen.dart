import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/widgets/app_image.dart';
import 'package:ifriend_app/core/widgets/custom_bottonshet.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/features/new/featuress/child/games/ghome/view/screen/games_screen.dart';
import 'package:ifriend_app/features/new/featuress/child/home/controller/childhome_cubit.dart';
import 'package:ifriend_app/features/new/featuress/child/home/view/widget/defcon_widget.dart';
import 'package:ifriend_app/features/new/featuress/child/learn/view/screen/learning_screen.dart';
import 'package:ifriend_app/features/new/featuress/child/mytasks/controller/mytasks_cubit.dart';
import 'package:ifriend_app/features/new/featuress/child/mytasks/view/screen/mytasks_screen.dart';

class ChildhomeScreen extends StatelessWidget {
  const ChildhomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChildHomeCubit()
        ..getChildProfile()
        ..getChildDevice(),
      child: BlocBuilder<ChildHomeCubit, ChildHomeState>(
        builder: (context, state) {
          ChildHomeCubit cubit = ChildHomeCubit.get(context);

          return Scaffold(
            extendBodyBehindAppBar: true,

            appBar: AppBar(
              toolbarHeight: 80.h,
              backgroundColor: Colors.transparent,
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 26.r,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundColor: Colors.transparent,
                      // backgroundImage: const AssetImage(
                      //   'assets/images/robot.png',
                      // ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(26.r),
                        child: AppImage(
                          path:
                              cubit
                                  .childProfileModel
                                  ?.data
                                  ?.profile
                                  ?.avatarUrl ??
                              'assets/images/robot.png',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          cubit.childProfileModel?.data?.profile?.firstName ??
                              "user",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Lv.5',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            _buildLevelBar(0.4),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Row(
                      children: [
                        // أضف أيقونة العملة هنا إذا كانت موجودة
                        // Image.asset('assets/images/coin.png', height: 18.h),
                        Text(
                          '${cubit.childProfileModel?.data?.profile?.coins.toString()} Coins',
                          style: TextStyle(
                            color: const Color(0xFFB45F06),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            body: Stack(
              children: [
                Container(
                  width: double.infinity,

                  height: double.infinity,

                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Background (1).png'),

                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // 2. المحتوى (الروبوت + الحاوية البيضاء)
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.28,
                      ), // مسافة تحت الـ AppBar
                      Image.asset(
                        'assets/images/robot.png',
                        height: 300.h,
                        fit: BoxFit.contain,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 40.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.r),
                            topRight: Radius.circular(40.r),
                          ),
                        ),
                        child: GridView.count(
                          padding: EdgeInsets
                              .zero, // تأكد أن الـ Grid يبدأ من الأعلى تماماً
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 15.w,
                          mainAxisSpacing: 15.h,
                          childAspectRatio: 2.2, // لضبط استطالة المربعات
                          children: [
                            DefconWidget(
                              title: "Games",
                              imagePath: "games (2).png",
                              color: Color(0xFFB18CD9),
                              onTap: () {
                                Get.to(() => GamesScreen());
                              },
                            ),
                            DefconWidget(
                              title: "Learning",
                              imagePath: "learn.png",
                              color: Color(0xFF30CD9C),
                              onTap: () {
                                Get.to(() => LearningScreen());
                              },
                            ),
                            DefconWidget(
                              title: "My Tasks",
                              imagePath: "task.png",
                              color: Color(0xFFF5C956),
                              onTap: () {
                                MyTasksCubit.get(context).getAllMyTasks();
                                Get.to(() => MyTasksScreen());
                              },
                            ),
                            DefconWidget(
                              title: "Messages",
                              imagePath: "message.png",
                              color: Color(0xFFABEBF4),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 50.h,
                      ), // مساحة إضافية للسكرول خلف الـ BottomNav
                    ],
                  ),
                ),
              ],
            ),
            // 4. شريط التنقل السفلي الصغير فقط
            bottomNavigationBar: Container(
              padding: EdgeInsets.only(top: 15.h),
              height: 130.h,
              decoration: BoxDecoration(
                color: Colors.white,

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: .start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem("assets/svg/home.svg", "Home", true),
                  _buildSOSButton(),
                  _buildNavItem("assets/svg/profile.svg", "Me", false),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSOSButton() {
    return InkWell(
      onTap: () {
        CustomBottomSheet.show(
          context: Get.context!,
          height: Get.height * 0.4,

          child: Column(
            children: [
              SizedBox(height: 20.h),
              AppImage(
                path: "assets/images/sos.png",
                height: 120.sp,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20.h),

              CustomText(
                title: "Are you in danger now?",
                color: Color(0xFFCC3D52),
                fontSize: 26.sp,
                fontFamily: "Baloo2",
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 20.h),

              Row(
                spacing: 10.w,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFC94154), // اللون الأحمر
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 6), // ظل من تحت
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Yes",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF7273ED), // اللون الأحمر
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 6), // ظل من تحت
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "No",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFFEA5B70), // اللون الأحمر في الصورة
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFEA5B70).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppImage(
              path: "assets/images/sos.png",
              height: 28.sp,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 8.w),
            Text(
              "SOS",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppImage(path: icon, height: 28.sp, fit: BoxFit.contain),

        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF2D9CDB) : Colors.grey,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

Widget _buildLevelBar(double progress) {
  return Container(
    width: 80.w,
    height: 10.h,
    decoration: BoxDecoration(
      color: Colors.black, // خلفية الشريط
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: progress,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // الجزء الممتلئ
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    ),
  );
}
