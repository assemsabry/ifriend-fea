import 'package:flutter/material.dart';
import 'package:ifriend_app/features/new/config/themes/sizing.dart';

class DefErrorWidget extends StatelessWidget {
  final void Function()? onTap;
  const DefErrorWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: AppSizing.customPadding(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // AppImage(path: "${AssetsData.images}/empty-box.png", height: 150.h),
            // CustomText(
            //   title: Get.locale?.languageCode == 'ar'
            //       ? "عفوا القائمة فارغة"
            //       : "Sorry, the list is empty.",
            // ),
          ],
        ),
      ),
    );
  }
}
