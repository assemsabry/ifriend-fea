import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

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
      return CachedNetworkImage(
        imageUrl: path,
        fit: fit,
        height: height,
        width: width,
        placeholder: (context, url) {
          return Image.asset(
            "assets/images/errorimage.png",
            fit: fit,
            height: height,
            width: width,
          );
        },
        errorWidget: (context, url, error) {
          return Image.asset(
            "assets/images/errorimage.png",
            fit: fit,
            height: height,
            width: width,
          );
        },
      );
    } else if (path.endsWith("json")) {
      return Lottie.asset(path, fit: fit, height: height, width: width);
    } else {
      return Image.asset(path, fit: fit, height: height, width: width);
    }
  }
}
