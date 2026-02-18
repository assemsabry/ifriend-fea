import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget Function(BuildContext, Size) builder;

  const ResponsiveLayout({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);

        return ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, _) {
            return builder(context, size);
          },
        );
      },
    );
  }
}
