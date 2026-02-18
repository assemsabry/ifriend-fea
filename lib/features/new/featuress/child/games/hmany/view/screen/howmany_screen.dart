import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/app_image.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/core/widgets/def_appbar.dart';
import 'package:ifriend_app/features/new/featuress/child/games/hmany/controller/hmany_cubit.dart';
import 'package:ifriend_app/features/new/featuress/child/games/hmany/controller/hmany_state.dart';

class HowManyScreen extends StatelessWidget {
  const HowManyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HmanyCubit()..setupLevel(1),
      child: BlocBuilder<HmanyCubit, HmanyState>(
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: DefAppbar(
              title: "Level.${state.level}",
              color: Colors.transparent,
              textColor: Colors.white,
              backIcon: true,
            ),
            body: Stack(
              children: [
                // الخلفية
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/gabesqbg.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.3],
                    ),
                  ),
                ),

                SafeArea(
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Stack(
                          children: [
                            Container(
                              height: 18.h,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              height: 18.h,
                              width:
                                  (Get.width - 80.w) *
                                  (state.targetCounts.length / 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),
                      Container(
                        // padding: const EdgeInsets.all(5),
                        width: Get.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 10.h),
                            CustomText(
                              title: "How Many ?",
                              fontSize: 24.sp,
                              fontFamily: "Baloo2",
                              fontWeight: FontWeight.w400,
                              color: ColorsManager.neutral700,
                            ),
                            Container(
                              margin: EdgeInsets.all(15),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Wrap(
                                spacing: 20,
                                runSpacing: 15,
                                alignment: WrapAlignment.center,
                                children: state.board
                                    .map(
                                      (shape) => AppImage(
                                        path: "assets/svg/$shape",
                                        width: 40.w,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                color: Colors.orange.shade300,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 2.5,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                      ),
                                  itemCount: state.userAnswers.keys.length,
                                  itemBuilder: (context, index) {
                                    String shape = state.userAnswers.keys
                                        .elementAt(index);
                                    return Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/svg/$shape",
                                          width: 50.w,
                                        ),
                                        SizedBox(width: 20.w),
                                        Expanded(
                                          child: Container(
                                            height: 60.w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Stack(
                                              children: [
                                                CustomPaint(
                                                  painter:
                                                      DashedBorderPainter(),
                                                  child: Container(),
                                                ),
                                                TextField(
                                                  controller: context
                                                      .read<HmanyCubit>()
                                                      .controllers[shape],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 22.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black54,
                                                  ),
                                                  decoration:
                                                      const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                      ),
                                                  onChanged: (val) => context
                                                      .read<HmanyCubit>()
                                                      .updateAnswer(shape, val),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20.w),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(flex: 2),
                    ],
                  ),
                ),

                if (state.isSuccess)
                  Center(
                    child: AppImage(
                      path: "assets/images/success.gif",
                      fit: BoxFit.cover,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 5, dashSpace = 3, startX = 0;
    final paint = Paint()
      ..color = ColorsManager
          .borderColor // لون الحدود الرمادي
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final RRect rRect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      const Radius.circular(8),
    );
    final Path path = Path()..addRRect(rRect);

    // رسم الخط المقطع
    for (PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        canvas.drawPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
