import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/routing/sizing.dart';
import 'package:ifriend_app/features/new/featuress/parent/appmanag/model/modes_model.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/controller/parenthome_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/model/appmode_model.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/view/widget/modecard_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CurrentmodesWidget extends StatelessWidget {
  const CurrentmodesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentHomeCubit, ParentHomeState>(
      buildWhen: (previous, current) => current is ParentHomeSuccessState,
      builder: (context, state) {
        if (state is ParentHomeLoadingState) {
          return Skeletonizer(
            child: SizedBox(
              height: 160.h,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                padEnds: false,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: AppSizing.customPadding(left: 5, right: 5),
                    child: ModeCardWidget(
                      modes: Modes(),
                      appMode: AppMode.school,
                    ),
                  );
                },
              ),
            ),
          );
        } else if (state is ParentHomeErrorState) {
          return Skeletonizer(
            child: SizedBox(
              height: 160.h,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                padEnds: false,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: AppSizing.customPadding(left: 5, right: 5),
                    child: ModeCardWidget(
                      modes: Modes(),
                      appMode: AppMode.school,
                    ),
                  );
                },
              ),
            ),
          );
        }
        if (state is ParentHomeSuccessState) {
          if (state.model.data == null) {
            return SizedBox(
              height: 160.h,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                padEnds: false,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: AppSizing.customPadding(left: 5, right: 5),
                    child: ModeCardWidget(
                      modes: Modes(),
                      appMode: AppMode.school,
                    ),
                  );
                },
              ),
            );
          }

          return SizedBox(
            height: 160.h,
            child: Padding(
              padding: AppSizing.customPadding(left: 5, right: 5),
              child: ModeCardWidget(
                modes: Modes(
                  startTime: state.model.data!.activeMode?.startTime,
                  endTime: state.model.data!.activeMode?.endTime,
                  type: state.model.data!.activeMode?.type,
                ),
                appMode: AppModeX.fromBackend(
                  state.model.data!.activeMode?.type,
                ),
              ),
            ),
          );
        }
        return Skeletonizer(
          child: SizedBox(
            height: 160.h,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 15,
              padEnds: false,
              itemBuilder: (context, index) {
                return Padding(
                  padding: AppSizing.customPadding(left: 5, right: 5),
                  child: ModeCardWidget(
                    modes: Modes(),
                    appMode: AppMode.school,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
