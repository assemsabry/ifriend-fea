import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/constants/imges.dart';
import 'package:ifriend_app/core/constants/strings.dart';
import 'package:ifriend_app/core/helpers/extensions.dart';
import 'package:ifriend_app/core/routing/routes.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/theme/styles_manager.dart';
import 'package:ifriend_app/core/widgets/custom_button.dart';
import 'package:ifriend_app/core/widgets/custom_text_field_widget.dart';
import 'package:ifriend_app/features/login/domain/entities/login_entity.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/widgets/custom_asset_image_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'manager/complete_profile_cubit.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key, required this.user});

  final UserEntity user;

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  late final TextEditingController _firstController = TextEditingController(
    text: widget.user.firstName,
  );
  late final TextEditingController _lastController = TextEditingController(
    text: widget.user.lastName,
  );
  late final TextEditingController _emailController = TextEditingController(
    text: widget.user.email,
  );
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _firstController.dispose();
    _lastController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompleteProfileCubit, CompleteProfileState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile created successfully')),
          );
          // NOTE: Removed setting profile completed in local storage here to avoid
          // multiple writes when this listener may trigger more than once.

          context.pushNamedAndRemoveUntil(
            Routes.privacyPolicyScreen,
            predicate: (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.completeProfile),
          leading: SizedBox(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(width: double.infinity, height: 25.h),
                BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () => _showImageSourceActionSheet(context),
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
                          child: state.imageFile == null
                              ? CustomAssetImageWidget(
                                  Images.cameraIcon,
                                  height: 35,
                                  width: 35,
                                )
                              : ClipOval(
                                  child: Image.file(
                                    state.imageFile!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _firstController,
                        title: AppStrings.firstName,
                        fillColor: ColorsManager.baseWhite,
                        filled: true,
                        onChanged: (v) => context
                            .read<CompleteProfileCubit>()
                            .firstNameChanged(v ?? ''),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: CustomTextField(
                        controller: _lastController,
                        title: AppStrings.lastName,
                        fillColor: ColorsManager.baseWhite,
                        filled: true,
                        onChanged: (v) => context
                            .read<CompleteProfileCubit>()
                            .lastNameChanged(v ?? ''),
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
                BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
                  buildWhen: (p, c) => p.phone != c.phone,
                  builder: (context, state) {
                    return IntlPhoneField(
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
                      initialCountryCode: 'EG',
                      onChanged: (phone) {
                        context.read<CompleteProfileCubit>().phoneChanged(
                          phone.completeNumber,
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  controller: _emailController,
                  title: AppStrings.email,
                  fillColor: ColorsManager.baseWhite,
                  filled: true,
                  hintText: "example@gmail.com",
                  hintStyle: TextStyles.font15Grey400Weight,
                  onChanged: (v) => context
                      .read<CompleteProfileCubit>()
                      .emailChanged(v ?? ''),
                ),
                SizedBox(height: 24.h), // spacing above the fixed button
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: CustomButton(
                    label: AppStrings.done,
                    textStyle: TextStyles.font18White500Weight,
                    height: 60,
                    backgroundColor: ColorsManager.primary,
                    onPressed: state.isSubmitting
                        ? null
                        : () async {
                            context
                                .read<CompleteProfileCubit>()
                                .firstNameChanged(_firstController.text);
                            context
                                .read<CompleteProfileCubit>()
                                .lastNameChanged(_lastController.text);
                            context.read<CompleteProfileCubit>().emailChanged(
                              _emailController.text,
                            );
                            await context.read<CompleteProfileCubit>().submit();
                            if (context
                                .read<CompleteProfileCubit>()
                                .state
                                .isSuccess) {}
                          },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                context.read<CompleteProfileCubit>().pickImage(
                  ImageSource.gallery,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                context.read<CompleteProfileCubit>().pickImage(
                  ImageSource.camera,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text('Cancel'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
