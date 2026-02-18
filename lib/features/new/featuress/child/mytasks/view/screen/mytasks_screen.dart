import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/widgets/custom_text.dart';
import 'package:ifriend_app/core/widgets/def_appbar.dart';
import 'package:ifriend_app/features/new/featuress/child/mytasks/controller/mytasks_cubit.dart';
import 'package:ifriend_app/features/new/featuress/child/mytasks/view/widget/mytasks_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyTasksScreen extends StatelessWidget {
  const MyTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DefAppbar(
        title: "My Tasks",
        textColor: Colors.black,
        backIcon: true,
        color: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/taskbg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: BlocBuilder<MyTasksCubit, MyTasksState>(
              buildWhen: (previous, current) => current is MyTasksSuccessStates,
              builder: (context, state) {
                if (state is MyTasksLoadingStates) {
                  return Skeletonizer(
                    child: ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: MytasksCard(),
                        );
                      },
                    ),
                  );
                } else if (state is MyTasksErrorStates) {
                  return Skeletonizer(
                    child: ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: MytasksCard(),
                        );
                      },
                    ),
                  );
                }
                if (state is MyTasksSuccessStates) {
                  if (state.myTasksModel.data!.tasks!.isEmpty) {
                    return Center(
                      child: CustomText(
                        title: "No Tasks Found",
                        color: ColorsManager.neutral600,
                        fontSize: 15.sp,
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.only(top: 15.h),
                    itemCount: state.myTasksModel.data!.tasks!.length,
                    itemBuilder: (context, index) {
                      return MytasksCard(
                        task: state.myTasksModel.data!.tasks![index],
                        onTap: () {
                          MyTasksCubit.get(context).markTaskAsDone(
                            taskId: state.myTasksModel.data!.tasks![index].id
                                .toString(),
                          );
                        },
                      );
                    },
                  );
                }
                return Skeletonizer(
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: MytasksCard(),
                      );
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
}
