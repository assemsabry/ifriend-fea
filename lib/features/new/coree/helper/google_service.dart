import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;

  Future<String?> signInWithGoogle() async {
    googleSignIn.initialize(
      serverClientId:
          "84517540194-gh2qme1c8srbbv2kenci2h6ouq1qc7lj.apps.googleusercontent.com",
    );
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate(
        scopeHint: ["email"],
      );

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      log("🔥 Google Auth: $googleAuth");
      return googleAuth.idToken;
    } catch (e) {
      print("Error Google SignIn: $e");
      return null;
    }
  }

  Future<void> signOut() => googleSignIn.signOut();
}
