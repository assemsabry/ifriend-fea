import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/core/constants/imges.dart';
import 'package:ifriend_app/core/routing/routes.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/theme/styles_manager.dart';
import 'package:ifriend_app/core/widgets/custom_asset_image_widget.dart';
import 'package:ifriend_app/features/old/onboarding/data/models/onboarding_model.dart';
import 'package:ifriend_app/features/old/onboarding/presentation/cubit/onboarding_cubit.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingModel> _onboardingData = [
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < _onboardingData.length - 1) {
      final nextIndex = _currentIndex + 1;
      // If the PageController is attached to a PageView, animate to next page.
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        // If the controller isn't attached yet, schedule a post-frame callback
        // to attempt the animation once the widgets are built. If still not
        // attached, update the index directly as a fallback so UI updates.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          if (_pageController.hasClients) {
            _pageController.animateToPage(
              nextIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          } else {
            setState(() {
              _currentIndex = nextIndex;
            });
          }
        });
      }
    }
  }

  Future<void> _finish(BuildContext context) async {
    final cubit = context.read<OnboardingCubit>();
    await cubit.setOnboardingSeen.call(true);
    // Navigate to login replacing onboarding route
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, Routes.userRoleScreen);
  }

  void _skip() {
    _finish(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primary,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _skip,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.darkBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      elevation: 2,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("SKIP", style: TextStyles.font16White400Weight),
                        const SizedBox(width: 3.5),
                        Icon(
                          Icons.arrow_forward,
                          color: ColorsManager.neutral50,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svg/onboarding.svg', height: 160.h),
                ],
              ),
            ),
            // Keep PageView attached to the controller but render empty pages
            // so the controller has clients while the SVG is outside of it.
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  // Empty page content - visual content is shown above
                  return const SizedBox.shrink();
                },
              ),
            ),

            // Bottom Sheet Container
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(20.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 28.h),
              decoration: BoxDecoration(
                color: ColorsManager.baseWhite,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _onboardingData[_currentIndex].title,
                    style: TextStyles.font26Black600Weight,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    _onboardingData[_currentIndex].description,
                    style: TextStyles.font16Grey500Weight,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                  // Dots Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingData.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: index == _currentIndex ? 20.w : 10.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                          color: index == _currentIndex
                              ? ColorsManager.primary
                              : ColorsManager.neutral200,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  // Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentIndex == _onboardingData.length - 1) {
                          _finish(context); // Finish onboarding
                        } else {
                          _nextPage();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(double.infinity, 65.h),
                        backgroundColor: ColorsManager.primary,
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: _currentIndex == _onboardingData.length - 1
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "GET STARTED",
                                    style: TextStyles.font16White400Weight
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.sp,
                                        ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: ColorsManager.primary400,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomAssetImageWidget(
                                        Images.arrowGoIcon,
                                        height: 20,
                                        width: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Text(
                              "CONTINUE",
                              style: TextStyles.font16White400Weight.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
