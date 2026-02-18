import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/routing/sizing.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/view/widget/sos_appbar.dart';
import 'package:ifriend_app/features/new/featuress/parent/alllocation/view/widget/sos_card.dart';

class SosHistoryScreen extends StatelessWidget {
  const SosHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SosAppbar(title: "SOS History", backIcon: true),
      body: Container(
        padding: AppSizing.customPadding(),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 20.h),
            SosCard(),
          ],
        ),
      ),
    );
  }
}
