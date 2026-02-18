// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ErrorPage extends StatelessWidget {
//   final void Function() onPressed;
//   const ErrorPage({super.key, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           spacing: 10.h,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const AppImage(path: AssetsData.logoImage),
//             SizedBox(height: 6.h),
//             CustomText(
//               title: "هناك مشكلة",
//               color: AppColors.customColor,
//               fontSize: 18.sp,
//               fontWeight: FontWeight.bold,
//             ),
//             SizedBox(height: 6.h),
//             CustomText(
//               title: "للأسف قد تعذر الإتصال بالأنترنت. يرجى\n التحقق من فضلك.",
//               color: AppColors.greyColor,
//               textAlign: TextAlign.center,
//               fontSize: 13.sp,
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: SizedBox(
//         height: 120.h,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: CustomButton(
//                 height: 45.h,
//                 title: "",
//                 onPressed: onPressed,
//                 widget: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.refresh, color: Colors.white),
//                     SizedBox(width: 6.w),
//                     const CustomText(
//                       title: "أعد المحاولة مجددا",
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 5.h),
//           ],
//         ),
//       ),
//     );
//   }
// }
