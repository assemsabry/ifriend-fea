import 'package:ifriend_app/features/old/onboarding/data/datasoucres/onboarding_local_datasource.dart';
import 'package:ifriend_app/features/old/onboarding/data/domain/repo/onboarding_repo.dart';

class OnboardingRepoImpl implements OnboardingRepo {
  final OnboardingLocalDatasource local;

  OnboardingRepoImpl(this.local);

  @override
  Future<bool> getOnboardingSeen() async {
    return await local.getSeen();
  }

  @override
  Future<void> setOnboardingSeen(bool seen) async {
    await local.setSeen(seen);
  }
}
