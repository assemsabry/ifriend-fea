// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:ifriend_app/core/di/injection.dart';
// import 'package:ifriend_app/core/routing/routes.dart';
// import 'package:ifriend_app/core/theme/color_manager.dart';
// import 'package:ifriend_app/core/theme/styles_manager.dart';
// import 'package:ifriend_app/features/old/presentation/bloc/child_profile_bloc.dart';
// import 'package:ifriend_app/features/old/presentation/bloc/child_profile_event.dart';
// import 'package:ifriend_app/features/old/presentation/bloc/child_profile_state.dart';
// import 'package:ifriend_app/features/old/presentation/widgets/avatar_selector.dart';
// import 'package:ifriend_app/features/old/presentation/widgets/gender_card.dart';

// class SetUpChildProfileScreen extends StatelessWidget {
//   const SetUpChildProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => sl<ChildProfileBloc>(),
//       child: const _SetUpChildProfileContent(),
//     );
//   }
// }

// class _SetUpChildProfileContent extends StatefulWidget {
//   const _SetUpChildProfileContent();

//   @override
//   State<_SetUpChildProfileContent> createState() =>
//       _SetUpChildProfileContentState();
// }

// class _SetUpChildProfileContentState extends State<_SetUpChildProfileContent> {
//   final _nameController = TextEditingController();
//   final _dateOfBirthController = TextEditingController();

//   // Default avatar paths - you can update these with actual asset paths
//   final List<String> _avatarPaths = [
//     'assets/images/avatar1.png',
//     'assets/images/avatar2.png', // Replace with actual avatar assets
//     'assets/images/avatar3.png',
//     'assets/images/avatar4.png',
//     'assets/images/avatar5.png',
//   ];

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _dateOfBirthController.dispose();
//     super.dispose();
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
//       firstDate: DateTime(2010),
//       lastDate: DateTime.now(),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: ColorsManager.primary,
//               onPrimary: Colors.white,
//               onSurface: ColorsManager.baseBlack,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (picked != null) {
//       context.read<ChildProfileBloc>().add(DateOfBirthChanged(picked));
//       _dateOfBirthController.text = DateFormat('MMM dd, yyyy').format(picked);
//     }
//   }

//   void _handleSubmit(BuildContext context, bool isValid) {
//     if (isValid) {
//       context.read<ChildProfileBloc>().add(const SubmitChildProfile());
//       // Navigate to Enable Permission screen
//       Navigator.of(context).pushNamed(Routes.enablePermissionScreen);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorsManager.baseWhite,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Container(
//             width: 40.w,
//             height: 40.w,
//             decoration: const BoxDecoration(
//               color: ColorsManager.baseWhite,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.arrow_back,
//               color: ColorsManager.baseBlack,
//               size: 24.sp,
//             ),
//           ),
//           onPressed: () {
//             // Navigate back to Choose Role since login clears the stack
//             Navigator.of(context).pushReplacementNamed(Routes.userRoleScreen);
//           },
//         ),
//       ),
//       body: BlocBuilder<ChildProfileBloc, ChildProfileState>(
//         builder: (context, state) {
//           return SafeArea(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.symmetric(horizontal: 24.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 16.h),
//                   Text(
//                     'Set Up Child Profile',
//                     style: TextStyles.font26Black600Weight,
//                   ),
//                   SizedBox(height: 8.h),
//                   Text(
//                     'Enter your child\'s information.',
//                     style: TextStyles.font15Grey400Weight,
//                   ),
//                   SizedBox(height: 32.h),
//                   // Avatar Selector
//                   AvatarSelector(
//                     avatarPaths: _avatarPaths,
//                     selectedAvatarPath: state.avatarPath,
//                     onAvatarSelected: (avatarPath) {
//                       context.read<ChildProfileBloc>().add(
//                         AvatarSelected(avatarPath),
//                       );
//                     },
//                   ),
//                   SizedBox(height: 32.h),
//                   // Child's Name Field
//                   _buildTextField(
//                     controller: _nameController,
//                     label: 'Child\'s Name',
//                     hintText: 'Enter your child\'s full name',
//                     onChanged: (value) {
//                       context.read<ChildProfileBloc>().add(NameChanged(value));
//                     },
//                   ),
//                   SizedBox(height: 16.h),
//                   // Date of Birth Field
//                   _buildDateField(context),
//                   SizedBox(height: 16.h),
//                   // Gender Selector
//                   Row(
//                     children: [
//                       Text(
//                         'Gender',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w500,
//                           color: ColorsManager.baseBlack,
//                           fontFamily: 'Poppins',
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8.h),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: GenderCard(
//                           gender: Gender.boy,
//                           isSelected: state.gender == Gender.boy,
//                           onTap: () {
//                             context.read<ChildProfileBloc>().add(
//                               const GenderSelected(Gender.boy),
//                             );
//                           },
//                         ),
//                       ),
//                       SizedBox(width: 16.w),
//                       Expanded(
//                         child: GenderCard(
//                           gender: Gender.girl,
//                           isSelected: state.gender == Gender.girl,
//                           onTap: () {
//                             context.read<ChildProfileBloc>().add(
//                               const GenderSelected(Gender.girl),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 32.h),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: BlocBuilder<ChildProfileBloc, ChildProfileState>(
//         builder: (context, state) {
//           return Container(
//             padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
//             decoration: BoxDecoration(
//               color: ColorsManager.baseWhite,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 10,
//                   offset: const Offset(0, -5),
//                 ),
//               ],
//             ),
//             child: SafeArea(
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 56.h,
//                 child: ElevatedButton(
//                   onPressed: state.isValid
//                       ? () => _handleSubmit(context, state.isValid)
//                       : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: ColorsManager.primary,
//                     disabledBackgroundColor: ColorsManager.primary.withOpacity(
//                       0.4,
//                     ),
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16.r),
//                     ),
//                   ),
//                   child: Text(
//                     'Next',
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                       fontFamily: 'Poppins',
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required String hintText,
//     required ValueChanged<String> onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w500,
//             color: ColorsManager.baseBlack,
//             fontFamily: 'Poppins',
//           ),
//         ),
//         SizedBox(height: 8.h),
//         TextField(
//           controller: controller,
//           onChanged: onChanged,
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontFamily: 'Poppins',
//             color: ColorsManager.baseBlack,
//           ),
//           decoration: InputDecoration(
//             hintText: hintText,
//             hintStyle: TextStyle(
//               fontSize: 16.sp,
//               color: ColorsManager.neutral500,
//               fontFamily: 'Poppins',
//             ),
//             filled: true,
//             fillColor: ColorsManager.neutral50,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: BorderSide(color: ColorsManager.neutral200, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: BorderSide(color: ColorsManager.primary, width: 2),
//             ),
//             contentPadding: EdgeInsets.symmetric(
//               horizontal: 16.w,
//               vertical: 16.h,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDateField(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Date of Birth',
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w500,
//             color: ColorsManager.baseBlack,
//             fontFamily: 'Poppins',
//           ),
//         ),
//         SizedBox(height: 8.h),
//         TextField(
//           controller: _dateOfBirthController,
//           readOnly: true,
//           onTap: () => _selectDate(context),
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontFamily: 'Poppins',
//             color: ColorsManager.baseBlack,
//           ),
//           decoration: InputDecoration(
//             hintText: 'Select date of birth',
//             hintStyle: TextStyle(
//               fontSize: 16.sp,
//               color: ColorsManager.neutral500,
//               fontFamily: 'Poppins',
//             ),
//             filled: true,
//             fillColor: ColorsManager.neutral50,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: BorderSide(color: ColorsManager.neutral200, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: BorderSide(color: ColorsManager.primary, width: 2),
//             ),
//             contentPadding: EdgeInsets.symmetric(
//               horizontal: 16.w,
//               vertical: 16.h,
//             ),
//             suffixIcon: Icon(
//               Icons.calendar_today,
//               color: ColorsManager.neutral500,
//               size: 20.sp,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
