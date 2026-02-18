import 'package:flutter/material.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';

enum AppModeModel {
  school(
    title: "School",
    imagePath: "assets/images/school.png",
    colorLight: ColorsManager.yallowLightColor,
    colorDark: ColorsManager.yallowDarkColor,
    time: "08:00 AM - 02:00 PM",
  ),
  sleep(
    title: "Sleep",
    imagePath: "assets/images/sleep.png",
    colorLight: ColorsManager.puplLightColor,
    colorDark: ColorsManager.puplDarkColor,
    time: "10:00 PM - 06:00 AM",
  ),
  freeTime(
    title: "Family",
    imagePath: "assets/images/family.png",
    colorLight: ColorsManager.orangeLightColor,
    colorDark: ColorsManager.orangeDarkColor,
    time: "04:00 PM - 06:00 PM",
  ),
  study(
    title: "Study",
    imagePath: "assets/images/study.png",
    colorLight: ColorsManager.blueLightColor,
    colorDark: ColorsManager.blueDarkColor,
    time: "07:00 PM - 09:00 PM",
  );

  final String title;
  final String imagePath;
  final Color colorLight;
  final Color colorDark;

  final String time;

  const AppModeModel({
    required this.title,
    required this.imagePath,
    required this.colorLight,
    required this.colorDark,

    required this.time,
  });
}
