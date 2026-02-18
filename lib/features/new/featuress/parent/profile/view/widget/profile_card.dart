import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/constants/imges.dart';
import 'package:ifriend_app/core/constants/strings.dart';
import 'package:ifriend_app/core/helpers/extensions.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/theme/styles_manager.dart';
import 'package:ifriend_app/core/widgets/custom_asset_image_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifriend_app/core/widgets/custom_button.dart';
import 'package:ifriend_app/features/new/featuress/parent/profile/controller/parentprofile_cubit.dart';
import 'package:ifriend_app/features/old/profile/presentation/manager/profile_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ifriend_app/core/widgets/custom_text_field_widget.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ifriend_app/core/di/injection.dart' as di;
import 'package:ifriend_app/core/helpers/auth_local_datasource.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<ProfileCubit, ProfileState>(
    //   builder: (context, state) {
    //     String name = 'User';
    //     String email = '';
    //     String firstName = '';
    //     String lastName = '';
    //     String phone = '';
    //     String? avatarUrl;

    //     if (state is ProfileLoaded) {
    //       firstName = state.profile.firstName;
    //       lastName = state.profile.lastName;
    //       name = '$firstName $lastName';
    //       // Prefer the updated email from profile if present and non-empty,
    //       // otherwise fallback to locally stored user email (from auth local datasource)
    //       final updatedEmail = state.profile.updatedUser?.email;
    //       if (updatedEmail != null && updatedEmail.trim().isNotEmpty) {
    //         email = updatedEmail;
    //       } else {
    //         final authLocal = di.sl<AuthLocalDataSource>();
    //         email = authLocal.getUserEmail() ?? '';
    //       }
    //       phone = state.profile.phoneNumber;
    //       avatarUrl = state.profile.avatarUrl;
    //     }

    //     void openEditBottomSheet() {
    //       final firstController = TextEditingController(text: firstName);
    //       final lastController = TextEditingController(text: lastName);
    //       final emailController = TextEditingController(text: email);
    //       final phoneController = TextEditingController(text: phone);
    //       File? selectedAvatar;

    //       Future<void> pickImage(ImageSource source) async {
    //         final picker = ImagePicker();
    //         final picked = await picker.pickImage(
    //           source: source,
    //           imageQuality: 80,
    //         );
    //         if (picked != null) selectedAvatar = File(picked.path);
    //       }

    //       showModalBottomSheet(
    //         context: context,
    //         isScrollControlled: true,
    //         backgroundColor: ColorsManager.neutral50,
    //         builder: (ctx) => Padding(
    //           padding: EdgeInsets.only(
    //             bottom: MediaQuery.of(ctx).viewInsets.bottom,
    //           ),
    //           child: StatefulBuilder(
    //             builder: (context, setState) => Padding(
    //               padding: const EdgeInsets.all(16.0),
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 crossAxisAlignment: CrossAxisAlignment.stretch,
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         const SizedBox(width: 45),
    //                         Expanded(
    //                           child: Center(
    //                             child: Text(
    //                               'Edit Profile',
    //                               style: TextStyles.font18White500Weight
    //                                   .copyWith(color: Colors.black),
    //                               textAlign: TextAlign.center,
    //                             ),
    //                           ),
    //                         ),
    //                         Container(
    //                           height: 45,
    //                           width: 45,
    //                           decoration: BoxDecoration(
    //                             shape: BoxShape.circle,
    //                             color: ColorsManager.primary50,
    //                           ),
    //                           child: GestureDetector(
    //                             onTap: () => context.pop(),
    //                             child: Icon(
    //                               Icons.close,
    //                               color: ColorsManager.primary,
    //                               size: 20,
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   SizedBox(width: double.infinity, height: 25.h),
    //                   GestureDetector(
    //                     onTap: () async {
    //                       final source =
    //                           await showModalBottomSheet<ImageSource>(
    //                             context: ctx,
    //                             builder: (sheetCtx) => SafeArea(
    //                               child: Wrap(
    //                                 children: [
    //                                   ListTile(
    //                                     leading: const Icon(
    //                                       Icons.photo_library,
    //                                     ),
    //                                     title: const Text('Gallery'),
    //                                     onTap: () => Navigator.pop(
    //                                       sheetCtx,
    //                                       ImageSource.gallery,
    //                                     ),
    //                                   ),
    //                                   ListTile(
    //                                     leading: const Icon(Icons.camera_alt),
    //                                     title: const Text('Camera'),
    //                                     onTap: () => Navigator.pop(
    //                                       sheetCtx,
    //                                       ImageSource.camera,
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           );
    //                       if (source != null) {
    //                         await pickImage(source);
    //                         setState(() {});
    //                       }
    //                     },
    //                     child: Container(
    //                       decoration: BoxDecoration(
    //                         shape: BoxShape.circle,
    //                         border: Border.all(
    //                           color: ColorsManager.neutral100,
    //                           width: 8,
    //                         ),
    //                       ),
    //                       child: CircleAvatar(
    //                         radius: 50,
    //                         backgroundColor: Colors.red,
    //                         child: selectedAvatar == null
    //                             ? (avatarUrl == null
    //                                   ? CustomAssetImageWidget(
    //                                       Images.cameraIcon,
    //                                       height: 35,
    //                                       width: 35,
    //                                     )
    //                                   : ClipOval(
    //                                       child: Image.network(
    //                                         avatarUrl,
    //                                         width: 100,
    //                                         height: 100,
    //                                         fit: BoxFit.cover,
    //                                       ),
    //                                     ))
    //                             : ClipOval(
    //                                 child: Image.file(
    //                                   selectedAvatar!,
    //                                   width: 100,
    //                                   height: 100,
    //                                   fit: BoxFit.cover,
    //                                 ),
    //                               ),
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(height: 20.h),
    //                   Row(
    //                     children: [
    //                       Expanded(
    //                         child: CustomTextField(
    //                           controller: firstController,
    //                           title: AppStrings.firstName,
    //                           fillColor: ColorsManager.baseWhite,
    //                           filled: true,
    //                           onChanged: (v) {},
    //                         ),
    //                       ),
    //                       SizedBox(width: 10.w),
    //                       Expanded(
    //                         child: CustomTextField(
    //                           controller: lastController,
    //                           title: AppStrings.lastName,
    //                           fillColor: ColorsManager.baseWhite,
    //                           filled: true,
    //                           onChanged: (v) {},
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   SizedBox(height: 16.h),
    //                   Text(
    //                     AppStrings.phone,
    //                     style: TextStyles.font16Grey500Weight.copyWith(
    //                       color: ColorsManager.neutral700,
    //                     ),
    //                   ),
    //                   const SizedBox(height: 12),
    //                   IntlPhoneField(
    //                     decoration: InputDecoration(
    //                       hintText: "0100xxxxxx",
    //                       counterText: '',
    //                       helperText: null,
    //                       errorText: null,
    //                       isDense: true,
    //                       contentPadding: const EdgeInsets.symmetric(
    //                         vertical: 16.0,
    //                         horizontal: 16.0,
    //                       ),
    //                       filled: true,
    //                       fillColor: ColorsManager.baseWhite,
    //                       hintStyle: TextStyles.font15Grey400Weight,
    //                       enabledBorder: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(12.0),
    //                         borderSide: BorderSide(
    //                           color: ColorsManager.neutral100,
    //                           width: 1.0,
    //                         ),
    //                       ),
    //                       focusedBorder: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(12.0),
    //                         borderSide: BorderSide(
    //                           color: ColorsManager.neutral100,
    //                           width: 1.0,
    //                         ),
    //                       ),
    //                     ),
    //                     initialCountryCode: 'EG',
    //                     initialValue: phoneController.text,
    //                     onChanged: (phoneVal) {
    //                       phoneController.text = phoneVal.completeNumber;
    //                     },
    //                   ),
    //                   SizedBox(height: 16.h),
    //                   CustomTextField(
    //                     controller: emailController,
    //                     title: AppStrings.email,
    //                     fillColor: ColorsManager.baseWhite,
    //                     filled: true,
    //                     readOnly: true,
    //                     onChanged: (v) {},
    //                   ),
    //                   SizedBox(height: 24.h),
    //                   CustomButton(
    //                     label: "Save Change",
    //                     onPressed: () async {
    //                       // Normalize phone: remove non-digits, then convert +20/20 prefixes to leading 0
    //                       String normalizePhone(String input) {
    //                         final raw = input.trim();
    //                         // keep only digits
    //                         final digits = raw.replaceAll(
    //                           RegExp(r'[^0-9]'),
    //                           '',
    //                         );
    //                         if (digits.startsWith('20')) {
    //                           final withoutCountry = digits.substring(2);
    //                           return withoutCountry.length == 9
    //                               ? '0$withoutCountry'
    //                               : '0$withoutCountry';
    //                         }
    //                         if (digits.length == 10 && digits.startsWith('1')) {
    //                           // maybe missing leading zero: 1XXXXXXXXX -> 01XXXXXXXXX
    //                           return '0$digits';
    //                         }
    //                         return digits;
    //                       }

    //                       final rawPhone = phoneController.text;
    //                       final normalized = normalizePhone(rawPhone);

    //                       if (normalized.length != 11 ||
    //                           !normalized.startsWith('01')) {
    //                         ScaffoldMessenger.of(ctx).showSnackBar(
    //                           const SnackBar(
    //                             content: Text(
    //                               'Phone number must be 11 digits and start with 01',
    //                             ),
    //                           ),
    //                         );
    //                         return;
    //                       }

    //                       await context
    //                           .read<ProfileCubit>()
    //                           .updateParentProfile(
    //                             firstName: firstController.text,
    //                             lastName: lastController.text,
    //                             phoneNumber: normalized,
    //                             email: emailController.text,
    //                             avatar: selectedAvatar,
    //                           );
    //                       Navigator.pop(ctx);
    //                     },
    //                   ),
    //                   SizedBox(height: 8.h),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       );
    //     }

    return BlocBuilder<ParentProfileCubit, ParentProfileState>(
      buildWhen: (previous, current) => current is ParentProfileSuccessStates,
      builder: (context, state) {
        if (state is ParentProfileLoadingStates) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ParentProfileSuccessStates) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusGeometry.circular(100),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.brown[800],
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${state.parentProfileModel.data!.profile!.firstName ?? ""} ${state.parentProfileModel.data!.profile!.lastName ?? ""}",
                        style: TextStyles.font18White500Weight.copyWith(
                          color: ColorsManager.baseBlack,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        state.parentProfileModel.data!.profile!.user!.email ??
                            "",
                        style: TextStyles.font14Grey500Weight.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    //     openEditBottomSheet();
                  },
                  icon: CustomAssetImageWidget(
                    Images.editIcon,
                    height: 20,
                    width: 20,
                  ),
                  color: Colors.grey[700],
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
