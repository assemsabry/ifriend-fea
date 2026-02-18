// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:quick_pad/config/themes/app_colors.dart';
// import 'package:quick_pad/core/widgets/custom_button.dart';

// void defDialog(BuildContext context, VoidCallback onConfirm) {
//   showDialog(
//     context: context,
//     builder: (context) => Dialog(
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'تأكيد',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//                 color: Colors.redAccent,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'هل تريد إزالة هذا العنوان؟',
//               style: TextStyle(color: AppColors.leightBlue),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 25),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CustomButton(
//                   minWidth: 100.w,
//                   title: "نعم",
//                   onPressed: () {
//                     Navigator.pop(context);
//                     onConfirm();
//                   },
//                 ),
//                 const SizedBox(width: 20),
//                 CustomButton(
//                   minWidth: 100.w,
//                   buttoncolor: Colors.white,
//                   textcolor: AppColors.customColor,
//                   side: const BorderSide(color: AppColors.customColor),
//                   title: "لا",
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
