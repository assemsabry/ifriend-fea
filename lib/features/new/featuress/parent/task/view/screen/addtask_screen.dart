import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ifriend_app/core/routing/sizing.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/custom_bottonshet.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/core/widgets/def_button.dart';
import 'package:ifriend_app/core/widgets/def_form_field.dart';
import 'package:ifriend_app/features/new/featuress/parent/task/controller/add/addtask_cubit.dart';

class AddtaskScreen extends StatelessWidget {
  const AddtaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTaskCubit(),
      child: BlocConsumer<AddTaskCubit, AddTaskState>(
        listener: (context, state) {
          if (state is AddTaskSuccess) {
            //  hideLoadingDialog(context);
          } else if (state is AddTaskLoading) {
            //  DialogUtils.showLoading(context, "");
            //  showLoadingDialog(context);
          } else if (state is AddTaskFailure) {
            // hideLoadingDialog(context);
          }
        },
        builder: (context, state) {
          final cubit = AddTaskCubit.get(context);
          return Form(
            key: cubit.formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    CustomText(
                      title: "Add New Task",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.baseBlack,
                    ),
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: ColorsManager.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(90.r),
                      ),
                      child: IconButton(
                        onPressed: () => CustomBottomSheet.dismiss(context),
                        icon: Icon(
                          Icons.close,
                          size: 18.sp,
                          color: ColorsManager.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                DefFormField(
                  label: "Title Task",
                  filled: true,
                  titleOnTop: true,
                  fillColor: ColorsManager.neutral50,
                  controller: cubit.titleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Title is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                DefFormField(
                  label: "Description",
                  maxLines: 3,
                  filled: true,
                  titleOnTop: true,
                  fillColor: ColorsManager.neutral50,
                  controller: cubit.descriptionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Description is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                DefFormField(
                  label: "Coins",
                  hintText: "",
                  filled: true,
                  keyboardType: TextInputType.number,
                  titleOnTop: true,
                  readOnly: true,
                  //controller: cubit.coinsController,
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "Coins is required";
                  //   }
                  // return null;
                  // },
                  fillColor: ColorsManager.neutral50,
                  suffixIcon: Padding(
                    padding: AppSizing.customPadding(left: 5.w, right: 5.w),
                    child: Row(
                      spacing: 10.w,
                      mainAxisSize: .min,
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: const Color(0xFFE8F0FE),
                          child: IconButton(
                            icon: const Icon(
                              Icons.remove,
                              size: 18,
                              color: ColorsManager.primary,
                            ),
                            onPressed: () {
                              cubit.changeCoinsCount(1, false);
                            },
                          ),
                        ),
                        CustomText(
                          title: "${cubit.coinsCount}",
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorsManager.baseBlack,
                        ),

                        CircleAvatar(
                          radius: 18,
                          backgroundColor: ColorsManager.primary,
                          child: IconButton(
                            icon: const Icon(
                              Icons.add,
                              size: 18,
                              color: ColorsManager.baseWhite,
                            ),
                            onPressed: () {
                              cubit.changeCoinsCount(1, true);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  prefixIcon: Icon(
                    Iconsax.medal_star5,
                    color: ColorsManager.yallowDarkColor,
                  ),
                ),
                SizedBox(height: 20.h),
                DefButton(
                  title: "Add Task",
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.addTask();
                    }
                  },
                ),
                SizedBox(height: 20.h),
                TextButton(
                  onPressed: () => CustomBottomSheet.dismiss(context),
                  child: CustomText(
                    title: "Cancel",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsManager.baseBlack,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
