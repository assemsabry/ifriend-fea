import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/widgets/def_button.dart';
import 'package:ifriend_app/features/new/config/themes/sizing.dart';
import 'package:ifriend_app/features/new/coree/constants/def_appbar.dart';
import 'package:ifriend_app/features/new/coree/widgets/def_form_field.dart';
import 'package:ifriend_app/features/new/featuress/child/auth/comleteprofile/controller/childcompleteprofile_cubit.dart';
import 'package:ifriend_app/features/new/featuress/child/permission/view/screen/childpermission_screen.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/theme/styles_manager.dart';

import 'package:ifriend_app/features/old/presentation/widgets/avatar_selector.dart';
import 'package:ifriend_app/features/old/presentation/widgets/gender_card.dart';
import 'package:toastification/toastification.dart';

class CompletechildProfile extends StatelessWidget {
  const CompletechildProfile({super.key});

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
  //     firstDate: DateTime(2010),
  //     lastDate: DateTime.now(),
  //     builder: (context, child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           colorScheme: const ColorScheme.light(
  //             primary: ColorsManager.primary,
  //             onPrimary: Colors.white,
  //             onSurface: ColorsManager.baseBlack,
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );

  //   if (picked != null) {
  //     context.read<ChildProfileBloc>().add(DateOfBirthChanged(picked));
  //     _dateOfBirthController.text = DateFormat('MMM dd, yyyy').format(picked);
  //   }
  // }

  // void _handleSubmit(BuildContext context, bool isValid) {
  //   if (isValid) {
  //     context.read<ChildProfileBloc>().add(const SubmitChildProfile());
  //     // Navigate to Enable Permission screen
  //     Navigator.of(context).pushNamed(Routes.enablePermissionScreen);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChildCompleteProfileCubit, ChildCompleteProfileState>(
      listener: (context, state) {
        if (state is ChildCompleteProfileSuccess) {
          Get.to(() => ChildpermissionScreen());
        }
        if (state is ChildCompleteProfileFailure) {
          Toastification().show(
            title: Text(state.error),
            type: ToastificationType.error,
          );
        }
      },
      builder: (context, state) {
        final cubit = ChildCompleteProfileCubit.get(context);
        return Scaffold(
          backgroundColor: ColorsManager.baseWhite,
          appBar: DefAppbar(
            title: "",
            color: ColorsManager.baseWhite,
            backIcon: true,
          ),
          body: Form(
            key: cubit.formKey,
            child: Container(
              padding: AppSizing.customPadding(),

              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 16.h),
                  Text(
                    'Set Up Child Profile',
                    style: TextStyles.font26Black600Weight,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Enter your child\'s information.',
                    style: TextStyles.font15Grey400Weight,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  // Avatar Selector
                  AvatarSelector(
                    avatarPaths: cubit.avatarPaths,
                    selectedAvatarPath: cubit.selectedAvatarPath,
                    onAvatarSelected: (avatarPath) {
                      cubit.onAvatarSelected(avatarPath);
                    },
                  ),
                  SizedBox(height: 32.h),

                  // Child's Name Field
                  DefFormField(
                    label: "Child's Name",
                    controller: TextEditingController(
                      text:
                          "${cubit.firstNameController.text} ${cubit.lastNameController.text}",
                    ),
                    titleOnTop: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your child's name";
                      }
                      return null;
                    },
                    // onChanged: (value) {
                    //     context.read<ChildProfileBloc>().add(NameChanged(value));
                    //   },
                  ),
                  SizedBox(height: 16.h),
                  // Date of Birth Field
                  DefFormField(
                    label: "Date of Birth",
                    controller: cubit.dateOfBirthController,
                    titleOnTop: true,
                    suffixIcon: InkWell(
                      onTap: () {
                        cubit.selectDate(context);
                      },
                      child: Icon(
                        Icons.calendar_today,
                        color: ColorsManager.neutral500,
                        size: 20.sp,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your child's date of birth";
                      }
                      return null;
                    },
                    // onChanged: (value) {
                    //     context.read<ChildProfileBloc>().add(NameChanged(value));
                    //   },
                  ),
                  SizedBox(height: 16.h),
                  // Gender Selector
                  Row(
                    children: [
                      Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorsManager.baseBlack,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Expanded(
                        child: GenderCard(
                          gender: Gender.boy,
                          isSelected: cubit.gender == Gender.boy ? true : false,
                          onTap: () {
                            cubit.onGenderChange(0);
                          },
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: GenderCard(
                          gender: Gender.girl,
                          isSelected: cubit.gender == Gender.girl
                              ? true
                              : false,
                          onTap: () {
                            cubit.onGenderChange(1);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 100.h,
            padding: AppSizing.customPadding(),
            child: Column(
              children: [
                DefButton(
                  isLoading: cubit.isLoading,
                  loadingColor: Colors.white,
                  title: 'Next',
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate() &&
                        cubit.selectedAvatarPath != null &&
                        cubit.gender.name != "none") {
                      //   Get.to(() => ChildpermissionScreen());

                      cubit.completeChildProfile();
                    } else {
                      Toastification().show(
                        title: Text("Please fill all the fields"),
                        type: ToastificationType.error,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
