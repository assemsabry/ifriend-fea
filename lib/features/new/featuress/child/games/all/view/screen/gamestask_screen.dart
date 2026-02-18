import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/app_image.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/core/widgets/def_appbar.dart';
import 'package:ifriend_app/features/new/featuress/child/games/all/controller/games_cubit.dart';
import 'package:ifriend_app/features/new/featuress/child/games/all/controller/games_state.dart';

// ... (الواردات كما هي)

class GamestaskScreen extends StatelessWidget {
  const GamestaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
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
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
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
                                (state.matchedIndexes.length / 16),
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
                      padding: const EdgeInsets.all(8),
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
                            title: "Find the matching picture",
                            fontSize: 24.sp,
                            fontFamily: "Baloo2",
                            fontWeight: FontWeight.w400,
                            color: ColorsManager.neutral700,
                          ),
                          GridView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 10.h,
                            ),

                            shrinkWrap: true,

                            physics: const NeverScrollableScrollPhysics(),

                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,

                                  crossAxisSpacing: 5,

                                  mainAxisSpacing: 10,
                                ),

                            itemCount: 16,

                            itemBuilder: (context, index) {
                              return BlocBuilder<GameCubit, GameState>(
                                builder: (context, state) {
                                  bool isRevealed =
                                      state.flippedIndexes.contains(index) ||
                                      state.matchedIndexes.contains(index);

                                  return GestureDetector(
                                    onTap: () => context
                                        .read<GameCubit>()
                                        .onCardClick(index),

                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),

                                      child: isRevealed
                                          ? AppImage(
                                              path:
                                                  "assets/games/${state.board[index]}",

                                              height: 25,

                                              width: 25,

                                              fit: BoxFit.cover,
                                            )
                                          : AppImage(
                                              path: "assets/svg/defpicg.svg",

                                              height: 25,

                                              width: 25,

                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const Spacer(flex: 2),
                  ],
                ),
              ),

              // تأثير النجاح
              if (state.isMatched)
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
    );
  }
}
