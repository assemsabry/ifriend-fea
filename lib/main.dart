import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/core/di/bloc_observer.dart';
import 'package:ifriend_app/features/new/coree/app/myapp.dart';
import 'package:ifriend_app/features/new/coree/firebase/fsmsconfig.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';
import 'package:ifriend_app/features/new/featuress/child/apps/controller/syncapps_cubit.dart';
import 'package:ifriend_app/features/new/featuress/child/auth/comleteprofile/controller/childcompleteprofile_cubit.dart';
import 'package:ifriend_app/features/new/featuress/child/auth/qrcode/controller/qrcode_cubit.dart';
import 'package:ifriend_app/features/new/featuress/child/games/all/controller/games_cubit.dart';
import 'package:ifriend_app/features/new/featuress/child/mytasks/controller/mytasks_cubit.dart';
import 'package:ifriend_app/features/new/featuress/onboarding/controller/onboarding_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/controller/alllocation_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/controller/editlocation_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/apps/controller/apps_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/controller/modes_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/completeprofile/controller/completeprofile_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/devices/controller/parentdevices_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/controller/parenthome_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/linked/controller/qrcode_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/profile/controller/parentprofile_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/task/controller/view/ptasks_cubit.dart';
import 'package:ifriend_app/features/new/featuress/role/controller/role_cubit.dart';
import 'firebase_options.dart';
import 'package:ifriend_app/features/new/coree/dio/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await HiveHelper.initHive();

  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  requestPermissionNotification();
  fsmsconfig();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OnboardingCubit()),
        BlocProvider(create: (_) => RoleCubit()),
        BlocProvider(create: (_) => CompleteProfileCubit()),
        BlocProvider(create: (_) => ParentHomeCubit()..getHomeParent),

        BlocProvider(create: (_) => QrCodeCubit()),
        BlocProvider(create: (_) => ChildCompleteProfileCubit()),
        BlocProvider(create: (_) => PTasksCubit()..getPTasks()),
        BlocProvider(create: (_) => AllLocationCubit()..getAllSaveZone()),
        BlocProvider(create: (_) => GameCubit()..setupLevel(1)),
        BlocProvider(create: (_) => AppsCubit()..getAllApps()),
        BlocProvider(create: (_) => ModesCubit()..getAllModes()),
        BlocProvider(create: (_) => SyncAppsCubit()..getApps()),
        BlocProvider(create: (_) => EditLocationCubit()),
        BlocProvider(create: (_) => MyTasksCubit()..getAllMyTasks()),

        BlocProvider(create: (_) => QrcodeCubit()..generateQrCode()),
        BlocProvider(create: (_) => ParentProfileCubit()..getProfile()),
        // BlocProvider(create: (_) => ParentDevicesCubit()..getDevices()),
      ],
      child: MyApp(),
    ),
  );
}
