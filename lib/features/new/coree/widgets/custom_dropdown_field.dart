// import 'package:animated_custom_dropdown/custom_dropdown.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomDropdownField extends StatelessWidget {
//   final String hintText;
//   final dynamic value;
//   final List<String>? menu;
//   final dynamic Function(Object?)? onChanged;
//   final void Function()? onTap;
//   final Color? color;
//   const CustomDropdownField({
//     super.key,
//     required this.hintText,
//     required this.menu,
//     required this.onChanged,
//     this.value,
//     this.onTap,
//     this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomDropdown(
//       hintText: hintText,
//       items: menu,
//       closedHeaderPadding: EdgeInsets.all(16.h),
//       excludeSelected: false,
//       initialItem: value,
//       validator: (value) => value == null ? "لايمكن ان يكون الحقل فارغ" : null,
//       onChanged: onChanged,
//       listItemBuilder: (context, item, isSelected, onItemSelect) {
//         return Text(
//           item.toString(),
//           style: const TextStyle(color: AppColors.darkGreyColor),
//         );
//       },
//       decoration: CustomDropdownDecoration(
//         listItemDecoration: const ListItemDecoration(
//           selectedColor: AppColors.primaryColor,
//         ),
//         closedFillColor: AppColors.fillColor,
//         hintStyle: const TextStyle(color: AppColors.darkGreyColor),
//         listItemStyle: const TextStyle(color: AppColors.primaryColor),
//         headerStyle: const TextStyle(color: AppColors.primaryColor),
//         expandedBorderRadius: BorderRadius.circular(12),
//         closedBorderRadius: BorderRadius.circular(12),
//         expandedBorder: Border.all(color: AppColors.primaryColor),
//         closedBorder: Border.all(color: AppColors.borderColor),
//       ),
//     );
//   }
// }
