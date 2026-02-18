import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/features/new/featuress/parent/task/controller/view/ptasks_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/task/model/ptask_model.dart';

class TasksCard extends StatelessWidget {
  final Tasks? task;
  final bool? isDelete;
  const TasksCard({super.key, this.task, this.isDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          spacing: 10.h,
          crossAxisAlignment: .start,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                CustomText(
                  title: task?.title ?? "Clean Your Room",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorsManager.baseBlack,
                ),
                Row(
                  spacing: 3.w,
                  children: [
                    CustomText(
                      title: "${task?.coins} Coins",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorsManager.yallowDarkColor,
                    ),
                    Icon(
                      Iconsax.medal_star5,
                      color: ColorsManager.yallowDarkColor,
                    ),
                  ],
                ),
              ],
            ),
            CustomText(
              title:
                  task?.description ?? "Make your bed and organize your toys.",
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: ColorsManager.neutral400,
            ),
            BlocBuilder<PTasksCubit, PTasksState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: task?.status != "PENDING"
                            ? ColorsManager.green.withOpacity(0.1)
                            : ColorsManager.orangetColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CustomText(
                        title: task?.status ?? "Pending",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: task?.status != "PENDING"
                            ? ColorsManager.green
                            : ColorsManager.orangetColor,
                      ),
                    ),

                    isDelete == true
                        ? IconButton(
                            onPressed: () {
                              PTasksCubit.get(
                                context,
                              ).deleteTask(taskId: task!.id!);
                            },
                            icon: Icon(Iconsax.trash, color: ColorsManager.red),
                          )
                        : Switch(
                            value: task?.isActive ?? false,
                            onChanged: (bool newValue) {
                              PTasksCubit.get(context).editTasks(
                                taskId: task!.id!,
                                isDefault: newValue,
                              );
                            },
                            activeThumbColor: ColorsManager.baseWhite,
                            thumbIcon: WidgetStateProperty.all(
                              Icon(Icons.check, color: ColorsManager.baseWhite),
                            ),

                            inactiveTrackColor: ColorsManager.neutral100,
                            activeTrackColor: ColorsManager.primary,
                            inactiveThumbColor: Colors.white,

                            trackOutlineColor: WidgetStateProperty.all(
                              Colors.transparent,
                            ),
                          ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
