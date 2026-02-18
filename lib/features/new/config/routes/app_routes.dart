import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/features/new/featuress/parent/devices/view/screen/parentdevices_screen.dart';
import 'package:ifriend_app/features/new/featuress/parent/profile/view/screen/parentprofile_screen.dart';
import 'package:ifriend_app/features/new/featuress/splash/view/screen/splash_screen.dart';

List<GetPage<dynamic>>? routs = [
  GetPage(
    //  middlewares: [MyMiddleWere()],
    transition: Transition.zoom,
    curve: Curves.fastOutSlowIn,
    name: '/',
    page: () => const SplashScreen(),
  ),
];
