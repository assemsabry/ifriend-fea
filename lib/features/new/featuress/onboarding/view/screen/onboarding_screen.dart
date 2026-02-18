import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/widgets/app_image.dart';
import 'package:ifriend_app/features/new/config/themes/app_colors.dart';
import 'package:ifriend_app/features/new/featuress/onboarding/controller/onboarding_cubit.dart';
import 'package:ifriend_app/features/new/featuress/onboarding/view/widget/bottonsheet_widget.dart';
import 'package:ifriend_app/features/new/featuress/onboarding/view/widget/skip_botton.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = OnboardingCubit.get(context);
        final data = cubit.onBoardingList;

        return Scaffold(
          backgroundColor: AppColors.primary,
          body: SafeArea(
            child: Column(
              children: [
                SkipButton(onPressed: () => cubit.skip(context)),

                Expanded(
                  flex: 7,
                  child: Center(
                    child: AppImage(
                      path: 'assets/svg/defimg.svg',
                      height: 160.h,
                    ),
                  ),
                ),

                Expanded(
                  child: PageView.builder(
                    controller: cubit.onboardController,
                    itemCount: data.length,
                    onPageChanged: cubit.onPageChanged,
                    itemBuilder: (_, __) => const SizedBox.shrink(),
                  ),
                ),

                BottonsheetWidget(
                  title: data[cubit.currentIndex].title,
                  description: data[cubit.currentIndex].description,
                  currentIndex: cubit.currentIndex,
                  length: data.length,
                  onNext: () => cubit.next(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
