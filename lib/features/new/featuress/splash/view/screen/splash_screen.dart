import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/widgets/app_image.dart';
import 'package:ifriend_app/features/new/featuress/child/home/view/screen/childhome_screen.dart';
import 'package:ifriend_app/features/new/featuress/onboarding/view/screen/onboarding_screen.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/view/screen/parenthome_page.dart';
import 'package:ifriend_app/features/new/featuress/role/view/screen/role_screen.dart';
import 'package:ifriend_app/features/new/featuress/splash/controller/splash_cubit.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..startTimer(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigate) {
            if (HiveHelper.getData("step") == "1") {
              Get.off(() => const RoleScreen());
            } else if (HiveHelper.getData("step") == "2" &&
                HiveHelper.getData("role") == "CHILD") {
              Get.off(() => const ChildhomeScreen());
            } else if (HiveHelper.getData("step") == "2" &&
                HiveHelper.getData("role") == "PARENT") {
              Get.off(() => const ParenthomePage());
            } else {
              Get.off(() => const OnboardingScreen());
            }
          }
          // if (state is SplashForceUpdate) {
          //   Get.off(() => ForceUpdateScreen(storeUrl: state.storeUrl));
          // }
        },
        child: Scaffold(
          //   backgroundColor: AppColors.baseWhite,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/splashbg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: FadeInDown(
              duration: const Duration(milliseconds: 1400),
              child: Center(
                child: AppImage(
                  path: "assets/images/logo.png",
                  width: Get.width * 0.8,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
