import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/core/di/injection.dart' as di;
import 'package:ifriend_app/core/routing/app_router.dart';
import 'package:ifriend_app/features/home_layout/presentation/cubit/home_layout_cubit.dart';
import 'package:ifriend_app/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:ifriend_app/ifriend_app.dart';
import 'features/complete_profile/presentation/manager/complete_profile_cubit.dart';
import 'features/device_linking_scan_qr/presentation/cubit/scan_qr_cubit.dart';
import 'features/profile/presentation/manager/profile_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<OnboardingCubit>()..loadSeen()),
        BlocProvider(create: (_) => di.sl<CompleteProfileCubit>()),
        BlocProvider(create: (_) => di.sl<ScanQrCubit>()),
        BlocProvider(create: (_) => di.sl<ProfileCubit>()),
        BlocProvider(create: (_) => HomeLayoutCubit()),
      ],
      child: IfriendApp(appRouter: AppRouter()),
    ),
  );
}
