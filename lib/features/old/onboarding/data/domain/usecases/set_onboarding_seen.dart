import 'package:ifriend_app/features/old/onboarding/data/domain/repo/onboarding_repo.dart';

class SetOnboardingSeen {
  final OnboardingRepo repo;
  SetOnboardingSeen(this.repo);

  Future<void> call(bool seen) {
    return repo.setOnboardingSeen(seen);
  }
}
