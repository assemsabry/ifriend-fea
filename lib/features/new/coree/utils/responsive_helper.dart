import 'package:flutter/material.dart';

class ResponsiveHelper {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // دالات مساعدة
  static double heightPercentage(BuildContext context, double percentage) {
    return getScreenHeight(context) * percentage;
  }

  static double widthPercentage(BuildContext context, double percentage) {
    return getScreenWidth(context) * percentage;
  }
}
