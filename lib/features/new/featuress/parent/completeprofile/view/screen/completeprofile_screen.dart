import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/constants/imges.dart';
import 'package:ifriend_app/core/constants/strings.dart';
import 'package:ifriend_app/core/routing/sizing.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/theme/font_manager.dart';
import 'package:ifriend_app/core/theme/styles_manager.dart';
import 'package:ifriend_app/core/widgets/custom_asset_image_widget.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/core/widgets/def_appbar.dart';
import 'package:ifriend_app/core/widgets/def_button.dart';
import 'package:ifriend_app/core/widgets/def_form_field.dart';
import 'package:ifriend_app/features/new/featuress/parent/completeprofile/controller/completeprofile_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/info/view/screen/policy_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:toastification/toastification.dart';

class CompleteprofileScreen extends StatelessWidget {
  const CompleteprofileScreen({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: DefAppbar(
            centerTitle: true,
            title: AppStrings.completeProfile,
          ),
          body: BlocConsumer<CompleteProfileCubit, CompleteProfileState>(
            listener: (context, state) {
              if (state is CompleteProfileSuccess) {
                Get.offAll(() => PolicyScreen());
              } else if (state is CompleteProfileLoading) {
              } else if (state is CompleteProfileFailure) {
                Toastification().show(
                  context: context,
                  title: CustomText(
                    title: state.error,
                    fontSize: 14.sp,
                    fontWeight: FontWeightManager.regular,
                    fontFamily: FontConstants.fontFamily,
                    color: ColorsManager.neutral600,
                  ),
                  type: ToastificationType.error,
                );
              }
            },
            builder: (context, state) {
              final cubit = CompleteProfileCubit.get(context);

              return Form(
                key: cubit.formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(width: double.infinity, height: 25.h),
                        GestureDetector(
                          onTap: () => cubit.pickFile(),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ColorsManager.neutral100,
                                width: 8,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.red,
                              child: cubit.image.isEmpty
                                  ? CustomAssetImageWidget(
                                      Images.cameraIcon,
                                      height: 35,
                                      width: 35,
                                    )
                                  : ClipOval(
                                      child: Image.file(
                                        cubit.image.first,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Expanded(
                              child: DefFormField(
                                controller: cubit.firstNameController,
                                label: AppStrings.firstName,
                                fillColor: ColorsManager.baseWhite,
                                filled: true,
                                onChanged: (v) {},
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return "First Name is required";
                                  }
                                  return null;
                                },
                                // context
                                //     .read<CompleteProfileCubit>()
                                //     .firstNameChanged(v ?? ''),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: DefFormField(
                                controller: cubit.lastNameController,
                                label: AppStrings.lastName,
                                fillColor: ColorsManager.baseWhite,
                                filled: true,
                                onChanged: (v) => {},
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return "Last Name is required";
                                  }
                                  return null;
                                },
                                // context
                                //     .read<CompleteProfileCubit>()
                                //     .lastNameChanged(v ?? ''),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          AppStrings.phone,
                          style: TextStyles.font16Grey500Weight.copyWith(
                            color: ColorsManager.neutral700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
                        //   buildWhen: (p, c) => p.phone != c.phone,
                        //   builder: (context, state) {
                        // return
                        IntlPhoneField(
                          //  controller: cubit.phoneNumberController,
                          decoration: InputDecoration(
                            hintText: "0100xxxxxx",
                            counterText: '',
                            helperText: null,
                            errorText: null,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 16.0,
                            ),
                            filled: true,
                            fillColor: ColorsManager.baseWhite,
                            hintStyle: TextStyles.font15Grey400Weight,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: ColorsManager.neutral100,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: ColorsManager.neutral100,
                                width: 1.0,
                              ),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.completeNumber.isEmpty) {
                              return "Phone is required";
                            }
                            return null;
                          },
                          initialCountryCode: 'EG',
                          initialValue: cubit.phoneNumberController.text,
                          onChanged: (phone) {
                            cubit.phoneNumberController.text =
                                phone.completeNumber;
                          },
                          //  );
                          // },
                        ),
                        SizedBox(height: 16.h),
                        DefFormField(
                          controller: cubit.emailController,
                          label: AppStrings.email,
                          fillColor: ColorsManager.baseWhite,
                          hintText: "example@gmail.com",

                          filled: true,
                          onChanged: (v) => {},
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return "Email is required";
                            }
                            return null;
                          },
                          // context
                          //     .read<CompleteProfileCubit>()
                          //     .lastNameChanged(v ?? ''),
                        ),

                        SizedBox(
                          height: 24.h,
                        ), // spacing above the fixed button
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          bottomNavigationBar: Container(
            height: 100.h,
            padding: AppSizing.customPadding(),
            child: Column(
              children: [
                DefButton(
                  title: "Done",
                  onPressed: () {
                    if (CompleteProfileCubit.get(
                      context,
                    ).formKey.currentState!.validate()) {
                      CompleteProfileCubit.get(context).completeProfile();
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
