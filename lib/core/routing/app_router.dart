import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/core/di/injection.dart' as di;
import 'package:ifriend_app/features/home_layout/presentation/cubit/home_layout_cubit.dart';
import 'package:ifriend_app/features/profile/presentation/manager/profile_cubit.dart';
import 'package:ifriend_app/core/routing/routes.dart';
import 'package:ifriend_app/features/complete_profile/presentation/complete_profile_screen.dart';
import 'package:ifriend_app/features/login/domain/entities/login_entity.dart';
import 'package:ifriend_app/features/login/login_screen.dart';
import 'package:ifriend_app/features/onboarding/onboarding_screen.dart';
import 'package:ifriend_app/features/privacy_policy/privacy_policy_screen.dart';
import 'package:ifriend_app/features/child_profile/presentation/screens/set_up_child_profile_screen.dart';
import 'package:ifriend_app/features/permissions/presentation/screens/enable_permission_screen.dart';
import 'package:ifriend_app/features/user_role/user_role_screen.dart';
import 'package:ifriend_app/features/device_link/presentation/screens/connect_device_intro_screen.dart';
import 'package:ifriend_app/features/device_link/presentation/screens/show_qr_code_screen.dart';
import 'package:ifriend_app/features/device_link/domain/entities/child_qr_code_entity.dart';
import 'package:ifriend_app/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:ifriend_app/features/device_management/presentation/screens/childs_devices_screen.dart';

import '../../features/device_linking_scan_qr/presentation/device_linking_scan_qr_screen.dart';
import '../../features/home_layout/presentation/home_layout_screen.dart';
import '../../features/registration_steps_details_child_device/steps_to_link_with_child_device_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.loginScreen:
        // allow optional role argument (String 'PARENT' | 'CHILD')
        final initialRole = arguments is String ? arguments : null;
        return MaterialPageRoute(
          builder: (_) => LoginScreen(initialRole: initialRole),
        );
      case Routes.userRoleScreen:
        return MaterialPageRoute(builder: (_) => const UserRoleScreen());
      case Routes.completeProfileScreen:
        return MaterialPageRoute(
          builder: (_) => CompleteProfileScreen(user: arguments as UserEntity),
        );
      case Routes.privacyPolicyScreen:
        return MaterialPageRoute(builder: (_) => PrivacyPolicyScreen());
      case Routes.stepsToLinkWithChildDeviceScreen:
        return MaterialPageRoute(
          builder: (_) => StepsToLinkWithChildDeviceScreen(),
        );
      case Routes.deviceLinkingScanQrScreen:
        return MaterialPageRoute(builder: (_) => DeviceLinkingScanQrScreen());
      case Routes.homeLayout:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => di.sl<HomeLayoutCubit>()),
              BlocProvider(create: (_) => di.sl<ProfileCubit>()),
            ],
            child: HomeLayout(),
          ),
        );
      case Routes.setupChildProfileScreen:
        return MaterialPageRoute(builder: (_) => SetUpChildProfileScreen());
      case Routes.enablePermissionsScreen:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text("Enable Permissions")),
            body: const Center(child: Text("Enable Permissions Screen")),
          ),
        );
      case Routes.setUpChildProfileScreen:
        return MaterialPageRoute(
          builder: (_) => const SetUpChildProfileScreen(),
        );
      case Routes.enablePermissionScreen:
        return MaterialPageRoute(
          builder: (_) => const EnablePermissionScreen(),
        );
      case Routes.connectDeviceIntroScreen:
        return MaterialPageRoute(
          builder: (_) => const ConnectDeviceIntroScreen(),
        );
      case Routes.showQrCodeScreen:
        final qrEntity = settings.arguments as ChildQrCodeEntity;
        return MaterialPageRoute(
          builder: (_) => QrCodeChildScreen(qrToken: qrEntity.qrToken),
        );
      case Routes.notificationsScreen:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case Routes.childsDevicesScreen:
        return MaterialPageRoute(builder: (_) => const ChildsDevicesScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
