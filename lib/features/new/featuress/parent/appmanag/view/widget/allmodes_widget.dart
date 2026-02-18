import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/model/modes_model.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/view/widget/defmodes_card.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/model/appmode_model.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/controller/modes_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllmodesWidget extends StatelessWidget {
  const AllmodesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModesCubit, ModesState>(
      buildWhen: (previous, current) => current is ModesSuccessStates,
      builder: (context, state) {
        if (state is ModesLoadingStates) {
          return Skeletonizer(
            child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: DefmodesCard(modes: Modes(), appMode: AppMode.study),
                );
              },
            ),
          );
        } else if (state is ModesErrorStates) {
          return Skeletonizer(
            child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: DefmodesCard(modes: Modes(), appMode: AppMode.study),
                );
              },
            ),
          );
        }
        if (state is ModesSuccessStates) {
          if (state.modesModel.data!.modes!.isEmpty) {}

          return ListView.builder(
            itemCount: state.modesModel.data!.modes!.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final selectedDays = ModesCubit.get(context)
                  .selectedDaysFromModes(
                    state.modesModel.data!.modes![index].days,
                  );
              final isAllDays = selectedDays.length == 7;
              return Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: DefmodesCard(
                  selectedDays: selectedDays,
                  isAllDays: isAllDays,
                  modes: state.modesModel.data!.modes![index],
                  appMode: AppModeX.fromBackend(
                    state.modesModel.data!.modes![index].type,
                  ),
                ),
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
                child: DefmodesCard(modes: Modes(), appMode: AppMode.study),
              );
            },
          ),
        );
      },
    );
  }
}
