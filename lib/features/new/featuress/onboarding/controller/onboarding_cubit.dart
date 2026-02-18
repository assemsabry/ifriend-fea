import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/features/new/featuress/role/view/screen/role_screen.dart';
import 'package:ifriend_app/features/old/onboarding/data/models/onboarding_model.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());
  static OnboardingCubit get(BuildContext context) => BlocProvider.of(context);
  var onboardController = PageController();
  int isLast = 0;
  int currentIndex = 0;

  List<OnboardingModel> onBoardingList = [
    OnboardingModel(
      title: "Smart & Safe Phone Management",
      description:
          "Keep your child protected with smart, AI-powered safety tools.",
    ),
    OnboardingModel(
      title: "Healthy Screen Time Habits",
      description:
          "Create balanced screen schedules that help your child learn and grow.",
    ),
    OnboardingModel(
      title: "Location Tracking & Live Monitoring",
      description:
          "View your child’s real-time location on the map for quick and reliable tracking.",
    ),
  ];
  void onPageChanged(int index) {
    currentIndex = index;
    emit(OnboardingPageChanged());
  }

  void next(BuildContext context) {
    if (currentIndex == onBoardingList.length - 1) {
      finish(context);
    } else {
      onboardController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  Future<void> finish(BuildContext context) async {
    HiveHelper.addData("step", "1");
    Get.offAll(() => RoleScreen());
  }

  void skip(BuildContext context) {
    finish(context);
  }

  @override
  Future<void> close() {
    onboardController.dispose();
    return super.close();
  }
}
