import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ifriend_app/core/widgets/app_image.dart';
import 'package:ifriend_app/core/widgets/def_appbar.dart';
import 'package:ifriend_app/features/new/config/themes/app_colors.dart';
import 'package:ifriend_app/features/new/config/themes/sizing.dart';
import 'package:ifriend_app/features/new/featuress/child/learn/controller/letters/letters_cubit.dart';
import 'package:ifriend_app/features/new/featuress/child/learn/controller/letters/letters_state.dart';

class LettersScreen extends StatelessWidget {
  const LettersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LettersCubit()..setupLevel(1),
      child: BlocBuilder<LettersCubit, LettersState>(
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: DefAppbar(
              title: "Letter Lv.${state.level}",
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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.8),
                        BlendMode.srcATop,
                      ),
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

                Padding(
                  padding: AppSizing.customPadding(),
                  child: SafeArea(
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
                                  color: AppColors.green.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                height: 18.h,
                                width: (Get.width - 80.w) * (state.level / 10),
                                decoration: BoxDecoration(
                                  color: AppColors.green,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 50.h),

                        Container(
                          padding: const EdgeInsets.all(8),
                          width: Get.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            border: Border.all(color: AppColors.borderColor),
                            color: Colors.white,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            child: Column(
                              spacing: 20.h,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedScale(
                                  scale: state.isSpeaking ? 1.15 : 1.0,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves
                                      .elasticOut, // حركة ارتدادية محببة للأطفال
                                  child: AppImage(
                                    path:
                                        "assets/letters/${state.board[state.currentIndex]}",
                                    height: 0.3.sh,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(height: 30.h),
                                // زر الصوت
                                InkWell(
                                  onTap: () => context
                                      .read<LettersCubit>()
                                      .speakCurrentLetter(),
                                  child: Center(
                                    child: Stack(
                                      children: [
                                        // shadow / bottom layer
                                        Container(
                                          width: 260.w,
                                          height: 80.h,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF0077B6),
                                            borderRadius: BorderRadius.circular(
                                              40,
                                            ),
                                          ),
                                        ),

                                        // main button
                                        AnimatedPositioned(
                                          duration: const Duration(
                                            milliseconds: 100,
                                          ),
                                          top: state.isSpeaking ? 0 : -6,
                                          child: Container(
                                            width: 260.w,
                                            height: 75.h,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2AA7DF),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  state.isSpeaking
                                                      ? Iconsax.volume_cross
                                                      : Iconsax.volume_high,
                                                  color: Colors.white,
                                                  size: 28,
                                                ),
                                                SizedBox(width: 12),
                                                Text(
                                                  state.isSpeaking
                                                      ? 'Listening...'
                                                      : 'Sound',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 35.h),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        InkWell(
                          borderRadius: BorderRadius.circular(40),
                          onTap: () {
                            context.read<LettersCubit>().nextLetter();
                          },
                          child: Container(
                            width: double.infinity,
                            height: 70,
                            decoration: BoxDecoration(
                              color: const Color(0xFF34C759), // الأخضر الأساسي
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xFF2E9F47), // ظل أغمق
                                  offset: Offset(0, 6),
                                  blurRadius: 0,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
