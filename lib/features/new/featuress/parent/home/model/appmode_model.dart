import 'package:flutter/material.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';

enum AppMode { school, sleep, freeTime, study, family }

extension AppModeX on AppMode {
  static AppMode fromBackend(String? type) {
    if (type == null) return AppMode.school;

    switch (type.toLowerCase()) {
      case 'school':
        return AppMode.school;
      case 'sleep':
        return AppMode.sleep;
      case 'study':
        return AppMode.study;
      case 'free':
      case 'free_time':
        return AppMode.freeTime;
      case 'family':
        return AppMode.family;
      default:
        return AppMode.school;
    }
  }

  String get title {
    switch (this) {
      case AppMode.school:
        return "School";
      case AppMode.sleep:
        return "Sleep";
      case AppMode.freeTime:
        return "Free Time";
      case AppMode.family:
        return "Family";
      case AppMode.study:
        return "Study";
    }
  }

  String get imagePath {
    switch (this) {
      case AppMode.school:
        return "assets/images/school.png";
      case AppMode.sleep:
        return "assets/images/sleep.png";
      case AppMode.freeTime:
        return "assets/images/freetime.png";
      case AppMode.family:
        return "assets/images/family.png";
      case AppMode.study:
        return "assets/images/study.png";
    }
  }

  Color get colorLight {
    switch (this) {
      case AppMode.school:
        return ColorsManager.yallowLightColor;
      case AppMode.sleep:
        return ColorsManager.puplLightColor;
      case AppMode.freeTime:
        return ColorsManager.lemonLightColor;
      case AppMode.family:
        return ColorsManager.orangeLightColor;
      case AppMode.study:
        return ColorsManager.blueLightColor;
    }
  }

  Color get colorDark {
    switch (this) {
      case AppMode.school:
        return ColorsManager.yallowDarkColor;
      case AppMode.sleep:
        return ColorsManager.puplDarkColor;
      case AppMode.freeTime:
        return ColorsManager.lemonDarkColor;
      case AppMode.family:
        return ColorsManager.orangeDarkColor;
      case AppMode.study:
        return ColorsManager.blueDarkColor;
    }
  }
}
