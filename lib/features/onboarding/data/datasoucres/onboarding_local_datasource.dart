import 'package:shared_preferences/shared_preferences.dart';

abstract class OnboardingLocalDatasource {
  Future<bool> getSeen();
  Future<bool> setSeen(bool seen);
}

class OnboardingLocalDatasourceImpl implements OnboardingLocalDatasource {
  static const _key = 'onboarding_seen';
  final SharedPreferences prefs;

  OnboardingLocalDatasourceImpl(this.prefs);

  @override
  Future<bool> getSeen() async {
    return prefs.getBool(_key) ?? false;
  }

  @override
  Future<bool> setSeen(bool seen) async {
    return prefs.setBool(_key, seen);
  }
}
