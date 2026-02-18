import 'package:flutter/material.dart';
import 'package:ifriend_app/core/routing/routes.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void navigateToLoginAndClearStack() {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      Routes.loginScreen,
      (r) => false,
    );
  }
}
