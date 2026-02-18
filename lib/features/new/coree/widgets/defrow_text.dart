// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class DefrowText extends StatelessWidget {
//   final String title, body;
//   final Color? color;
//   final FontWeight? fontWeight;
//   final Color? titleColor;

//   const DefrowText({
//     super.key,
//     required this.title,
//     required this.body,
//     this.color,
//     this.fontWeight,
//     this.titleColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return RichText(
//       text: TextSpan(
//         text: title,
//         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//               fontSize: 14.sp,
//               fontWeight: fontWeight ?? FontWeight.normal,
//               color: titleColor ?? AppColors.defGreyColor,
//             ),
//         children: [
//           // if (requiredStyle)
//           TextSpan(
//             text: body,
//             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: color ?? AppColors.primaryColor,
//                   fontSize: 14.sp,
//                 ),
//           ),
//         ],
//       ),
//     );
//   }
// }
