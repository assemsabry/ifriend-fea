import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/core/routing/routes.dart';
import 'package:ifriend_app/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:ifriend_app/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:ifriend_app/core/di/injection.dart' as di;
import 'package:ifriend_app/core/helpers/auth_local_datasource.dart';

/// AppEntry chooses the initial route based on whether onboarding was seen.
/// It expects an existing OnboardingCubit provided above in the widget tree.
class AppEntry extends StatefulWidget {
  const AppEntry({super.key});

  @override
  State<AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {
  bool _navigated = false;

  void _handleState(BuildContext context, OnboardingState state) async {
    if (_navigated) return;
    if (state.isLoading) return; // wait until loading finishes

    _navigated = true;

    if (state.isCompleted) {
      final authLocal = di.sl<AuthLocalDataSource>();
      final isLogged = authLocal.isLoggedIn();
      if (!isLogged) {
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed(Routes.userRoleScreen);
        return;
      }

      final user = authLocal.getStoredUser();
      if (user == null) {
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed(Routes.userRoleScreen);
        return;
      }

      final role = user.role.toUpperCase();
      if (role.contains('CHILD')) {
        if (!mounted) return;
        Navigator.of(
          context,
        ).pushReplacementNamed(Routes.setupChildProfileScreen);
        return;
      }

      if (role.contains('PARENT')) {
        if (!mounted) return;
        if (user.profileCompleted) {
          Navigator.of(
            context,
          ).pushReplacementNamed(Routes.privacyPolicyScreen);
        } else {
          Navigator.of(
            context,
          ).pushReplacementNamed(Routes.completeProfileScreen, arguments: user);
        }
        return;
      }

      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(Routes.userRoleScreen);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.onBoardingScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listener: (context, state) => _handleState(context, state),
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: state.isLoading
                  ? const CircularProgressIndicator()
                  : const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }
}
