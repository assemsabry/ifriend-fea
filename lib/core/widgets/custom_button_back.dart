
import 'package:flutter/material.dart';

import '../constants/imges.dart';
import '../helpers/extensions.dart';
import '../theme/color_manager.dart';
import 'custom_asset_image_widget.dart';

class CustomButtonBack extends StatelessWidget {
  const CustomButtonBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorsManager.baseWhite,
            border: Border.all(color: ColorsManager.neutral100)
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CustomAssetImageWidget(
            Images.arrowBackIcon,
            height: 32,
            width: 32,
          ),
        ),
      ),
    );
  }
}
