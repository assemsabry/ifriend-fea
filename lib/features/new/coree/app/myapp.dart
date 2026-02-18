import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ifriend_app/features/new/config/routes/app_routes.dart';
import 'package:ifriend_app/features/new/config/themes/app_theme.dart';
import 'package:toastification/toastification.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(402, 874),
      minTextAdapt: true,
      splitScreenMode: true,
      fontSizeResolver: (fontSize, screenUtil) {
        return fontSize * screenUtil.scaleWidth.clamp(0.8, 1.2);
      },
      builder: (context, child) {
        return ToastificationWrapper(
          child: GetMaterialApp(
            //   navigatorKey: navigatorKey,
            getPages: routs,

            locale: const Locale("en"),
            transitionDuration: const Duration(milliseconds: 600),
            defaultTransition: Transition.topLevel,
            title: 'iFriend App',
            theme: appTheme(),

            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            useInheritedMediaQuery: true,
          ),
        );
      },
    );
  }
}
