import 'package:ifriend_app/features/old/onboarding/data/domain/repo/onboarding_repo.dart';

class GetOnboardingSeen {
  final OnboardingRepo repo;
  GetOnboardingSeen(this.repo);

  Future<bool> call() {
    return repo.getOnboardingSeen();
  }
}
