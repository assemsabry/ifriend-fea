// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mt_app/config/themes/app_colors.dart';
// import 'package:mt_app/core/widgets/custom_text.dart';
// import 'package:mt_app/features/invoice/cubit/invoiceitems_cubit.dart';
// import 'package:uicons/uicons.dart';

// class ExpandableListTile extends StatefulWidget {
//   final String? leadingText;
//   final Widget? leadingWidget;
//   final Color? leadingBackground;
//   final String title;
//   final List<Widget> children;
//   final double animatedContainerHeight;
//   final String subtitle;
//   final bool? userAuthType;
//   final bool? isEmpty;

//   const ExpandableListTile({
//     super.key,
//     this.children = const [],
//     this.animatedContainerHeight = 400,
//     this.leadingText,
//     this.leadingBackground,
//     required this.subtitle,
//     required this.title,
//     this.leadingWidget,
//     this.userAuthType,
//     this.isEmpty,
//   });

//   @override
//   State<ExpandableListTile> createState() => _ExpandableListTileState();
// }

// class _ExpandableListTileState extends State<ExpandableListTile> {
//   bool _expanded = false;

//   void _toggleExpanded() {
//     setState(() {
//       _expanded = !_expanded;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColors.borderColor),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(5.0.w),
//         child: Column(
//           children: [
//             ListTile(
//               tileColor: AppColors.lighColor100,
//               onTap: _toggleExpanded,
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     child: CustomText(
//                       title: widget.title,
//                       fontSize: 12.sp,
//                       color: AppColors.blackTextColor,
//                     ),
//                   ),
//                   Icon(
//                     _expanded
//                         ? UIcons.solidRounded.angle_small_down
//                         : UIcons.solidRounded.angle_small_left,
//                     color: Theme.of(context).colorScheme.secondary,
//                   ),
//                 ],
//               ),
//               subtitle: Row(
//                 children: [
//                   Flexible(
//                     child: CustomText(
//                       title: widget.subtitle,
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.bold,
//                       color: widget.isEmpty == true
//                           ? AppColors.customColor
//                           : AppColors.textBlueColor,
//                       maxLines: 4,
//                     ),
//                   ),
//                   SizedBox(width: 10.w),

//                   BlocBuilder<InvoiceItemsCubit, InvoiceItemsState>(
//                     builder: (context, state) {
//                       return Row(
//                         children: [
//                           Icon(
//                             widget.isEmpty == true
//                                 ? FeatherIcons.xSquare
//                                 : widget.userAuthType == false
//                                 ? FeatherIcons.xSquare
//                                 : widget.userAuthType == true
//                                 ? FeatherIcons.checkSquare
//                                 : null,
//                             size: 18,
//                             color: widget.isEmpty == true
//                                 ? AppColors.customColor
//                                 : widget.userAuthType == false
//                                 ? AppColors.greenColor
//                                 : widget.userAuthType == true
//                                 ? AppColors.greenColor
//                                 : null,
//                           ),
//                           SizedBox(width: 5.w),
//                           CustomText(
//                             title: widget.isEmpty == true
//                                 ? "فارغ من المخزن"
//                                 : widget.userAuthType == true
//                                 ? "تم الحفظ"
//                                 : "",
//                             color: widget.isEmpty == true
//                                 ? AppColors.customColor
//                                 : widget.userAuthType == false
//                                 ? AppColors.greenColor
//                                 : widget.userAuthType == true
//                                 ? AppColors.greenColor
//                                 : null,
//                             fontSize: 13.sp,
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             AnimatedContainer(
//               height: _expanded ? null : 0,
//               duration: const Duration(milliseconds: 900),
//               curve: Curves.bounceInOut,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ListView(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   children: widget.children,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
