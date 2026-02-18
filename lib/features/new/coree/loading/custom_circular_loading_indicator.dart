import 'package:flutter/material.dart';
import 'package:ifriend_app/features/new/config/themes/app_colors.dart';

class CustomCircularLoadingIndicator extends StatelessWidget {
  const CustomCircularLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: AppColors.primary,
        valueColor: AlwaysStoppedAnimation(AppColors.red),
      ),
    );
  }
}
