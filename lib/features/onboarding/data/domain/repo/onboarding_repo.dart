abstract class OnboardingRepo {
  Future<bool> getOnboardingSeen();
  Future<void> setOnboardingSeen(bool seen);
}
