import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/constants/imges.dart';
import 'package:ifriend_app/core/routing/app_entry.dart';
import 'package:ifriend_app/features/new/featuress/child/home/view/screen/childhome_screen.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/view/screen/parenthome_page.dart';
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      if (HiveHelper.getData("isLinked") == true &&
          HiveHelper.getData("role") == "PARENT") {
        Get.off(() => ParenthomePage());
      } else if (HiveHelper.getData("isLinked") == true &&
          HiveHelper.getData("role") == "CHILD") {
        Get.off(() => ChildhomeScreen());
      } else {
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => const AppEntry()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          Images.splashScreen,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
