import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RequestLoadingIndactor extends StatelessWidget {
  final Color? color;
  const RequestLoadingIndactor({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.staggeredDotsWave(
      color: color ?? Colors.black,
      size: 40.h,
    );
  }
}
