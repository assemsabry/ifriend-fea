import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppImage extends StatelessWidget {
  final String path;
  final double? height, width;
  final BoxFit fit;
  final Color? color;
  const AppImage({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.fit = BoxFit.scaleDown,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (path.endsWith("svg")) {
      return SvgPicture.asset(path, fit: fit, height: height, width: width);
    } else if (path.startsWith("http")) {
      return Image.network(
        path,
        fit: fit,
        height: height,
        width: width,
        // placeholder: (context, url) {
        // return Image.asset(
        //   "${AssetsData.images}/errorimage.png",
        //   fit: fit,
        //   height: height,
        //   width: width,
        // );
        //  },
        // errorWidget: (context, url, error) {
        // return Image.asset(
        //   "${AssetsData.images}/errorimage.png",
        //   fit: fit,
        //   height: height,
        //   width: width,
        // );
        //  },
      );
    } else {
      return Image.asset(path, fit: fit, height: height, width: width);
    }
  }
}
