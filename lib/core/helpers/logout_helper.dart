import 'package:flutter/material.dart';
import 'package:ifriend_app/core/di/injection.dart' as di;
import 'package:ifriend_app/core/helpers/auth_local_datasource.dart';
import 'package:ifriend_app/core/routing/routes.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

/// Clears local auth data and navigates to the login screen.
/// Also attempts to sign out from social SDKs (best-effort).
Future<void> logoutAndNavigate(BuildContext context) async {
  final authLocal = di.sl<AuthLocalDataSource>();

  // Clear local auth storage
  await authLocal.clear();

  // Try to sign out from Google and Facebook (ignore errors)
  try {
    await GoogleSignIn().signOut();
  } catch (_) {}

  try {
    await FacebookAuth.instance.logOut();
  } catch (_) {}

  // Navigate to login and remove all previous routes
  if (context.mounted) {
    Navigator.of(context).pushNamedAndRemoveUntil(Routes.loginScreen, (r) => false);
  }
}

