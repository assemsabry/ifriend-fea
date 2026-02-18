// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:quick_pad/config/themes/app_colors.dart';
// import 'package:quick_pad/core/widgets/custom_text.dart';

// class DefbottonWidget extends StatelessWidget {
//   final void Function() onPressed;
//   final String title;
//   final double? height;
//   final double? minWidth;
//   final IconData icon;
//   const DefbottonWidget({
//     super.key,
//     required this.onPressed,
//     required this.title,
//     this.height,
//     this.minWidth,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       elevation: 0,
//       focusElevation: 0,
//       hoverElevation: 0,
//       disabledElevation: 0,
//       highlightElevation: 0,
//       shape: RoundedRectangleBorder(
//         side: const BorderSide(color: AppColors.customColor),
//         borderRadius: BorderRadius.circular(5.0),
//       ),
//       clipBehavior: Clip.antiAlias,
//       height: height ?? 30.h,
//       minWidth: minWidth ?? Get.width * 0.2,
//       color: AppColors.lightColor,
//       onPressed: onPressed,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           CustomText(
//             title: title,
//             color: AppColors.customColor,
//             fontSize: 13.sp,
//           ),
//           SizedBox(width: 5.w),
//           Icon(icon, color: AppColors.customColor),
//         ],
//       ),
//     );
//   }
// }
