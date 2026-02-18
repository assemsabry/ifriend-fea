import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ifriend_app/core/routing/sizing.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/custom_bottonshet.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/core/widgets/def_appbar.dart';
import 'package:ifriend_app/core/widgets/def_button.dart';
import 'package:ifriend_app/features/new/featuress/parent/task/controller/view/ptasks_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/task/view/screen/addtask_screen.dart';
import 'package:ifriend_app/features/new/featuress/parent/task/view/widget/tasks_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefAppbar(title: "Tasks", backIcon: true),
      body: Container(
        padding: AppSizing.customPadding(),
        child: RefreshIndicator(
          onRefresh: () => PTasksCubit.get(context).getPTasks(),
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(height: 10.h),
              BlocBuilder<PTasksCubit, PTasksState>(
                buildWhen: (previous, current) =>
                    current is PTasksSuccessStates,
                builder: (context, state) {
                  if (state is PTasksLoadingStates) {
                    return Skeletonizer(
                      child: ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TasksCard(),
                        ),
                      ),
                    );
                  } else if (state is PTasksErrorStates) {
                    return Skeletonizer(
                      child: ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TasksCard(),
                        ),
                      ),
                    );
                  }
                  if (state is PTasksSuccessStates) {
                    if (state.pTasksModel.data!.tasks!.isEmpty) {
                      // return NohistoryWidget(
                      //   title: "لايوجد سجلات مدفوعات لديك",
                      //   svg: "credit.svg",
                      // );
                    }
                    return ListView.builder(
                      itemCount: state.pTasksModel.data!.tasks!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => TasksCard(
                        task: state.pTasksModel.data!.tasks![index],
                        isDelete: index > 1 ? true : false,
                      ),
                    );
                  }
                  return Skeletonizer(
                    child: ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TasksCard(),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
              DefButton(
                title: "",
                height: 65.h,

                widget: Row(
                  spacing: 5.w,
                  mainAxisAlignment: .center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ColorsManager.baseWhite,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Iconsax.add,
                        size: 25,
                        color: ColorsManager.primary,
                      ),
                    ),
                    CustomText(
                      title: "Add Task",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.baseWhite,
                    ),
                  ],
                ),
                onPressed: () {
                  CustomBottomSheet.show(
                    context: context,
                    height: Get.height * 0.7,

                    child: AddtaskScreen(),
                  );
                },
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
