import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/routing/app_router.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/features/home_layout/presentation/home_layout_screen.dart';
import 'package:ifriend_app/features/splash/splash_screen.dart';

import 'core/theme/styles_manager.dart';
import 'core/services/navigation_service.dart';

class IfriendApp extends StatelessWidget {
  final AppRouter appRouter;

  const IfriendApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(402, 874),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'iFriend App',
          navigatorKey: NavigationService.navigatorKey,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: ColorsManager.neutral50,
              titleTextStyle: TextStyles.font20Black500Weight,
              elevation: 0,
              centerTitle: true,
            ),
            primaryColor: ColorsManager.primary,
            scaffoldBackgroundColor: ColorsManager.neutral50,
          ),
          debugShowCheckedModeBanner: false,
          // initialRoute: Routes.homeLayout,
          // Show the splash screen first; after the splash we navigate to AppEntry
          home: SplashScreen(),
          onGenerateRoute: appRouter.generateRoute,
        );
      },
    );
  }
}
